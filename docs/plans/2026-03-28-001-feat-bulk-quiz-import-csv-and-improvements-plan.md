---
title: "feat: Enhance bulk quiz question import with CSV support and improvements"
type: feat
status: active
date: 2026-03-28
---

# feat: Enhance bulk quiz question import with CSV support and improvements

## Overview

The bulk quiz question import feature already has a working JSON implementation (backend endpoint + frontend form with preview/confirm flow). This plan covers adding CSV support, duplicate detection, and several UX/robustness improvements identified during analysis.

**Current state:** JSON-only bulk import works end-to-end via `POST /api/quiz/questions/bulk` (`server.js:479-521`) and a collapsible form in the quiz DB panel (`index.html:2502-2536`, JS at `index.html:5618-5713`).

## Problem Statement / Motivation

- Admin requested both JSON and CSV formats for bulk import
- No duplicate detection -- importing the same file twice doubles every question (documented historical issue, see `docs/plans/2026-03-23-002-live-db-reconciliation-plan.md`)
- Several UX gaps: no format toggle, truncated error reporting, no example templates, whitespace-only fields pass validation
- Category fragmentation risk -- free-text category with no autocomplete against existing categories

## Proposed Solution

Extend the existing bulk import implementation with:
1. **CSV parsing** alongside existing JSON support (format auto-detection + manual toggle)
2. **Duplicate detection** in the preview step (client-side comparison against loaded questions)
3. **UX improvements**: better error reporting, whitespace trimming, category suggestions, example templates

## Technical Considerations

### Architecture

- **No new dependencies** -- CSV parsing done with vanilla JS (split by delimiter, handle quoted fields). The project has zero frontend build tools, so no npm packages on the client side.
- **No new backend endpoints needed** -- the existing `POST /api/quiz/questions/bulk` accepts a `questions` array regardless of the source format. CSV->JSON conversion happens entirely on the frontend.
- **Express body limit** is 1MB (`server.js:26`) -- sufficient for 500 questions in JSON.

### Performance

- Batch INSERT optimization: current implementation does 500 individual INSERTs in a transaction. Could be improved with multi-row `INSERT INTO ... VALUES (...), (...), ...` for ~10x speedup on large batches. However, for <=500 rows this is a nice-to-have, not critical.
- Connection pool: single connection held for the transaction duration (pool size: 10). Acceptable.

### Security

- XSS prevention: `escH()` function (`index.html:1906`) is already used in the preview table. Must also apply to any new preview columns.
- No new auth surface -- the import endpoint has no auth (consistent with existing admin panel pattern, which is session-based or local-only).

## Acceptance Criteria

### CSV Support
- [ ] Format selector (JSON/CSV) above the textarea, with auto-detection fallback
- [ ] CSV parsing handles: comma and semicolon delimiters, quoted fields, UTF-8 with BOM stripping
- [ ] CSV requires a header row with field names matching JSON keys: `category`, `question`, `opt_a`, `opt_b`, `opt_c`, `opt_d`, `correct`, `answer_full` (optional)
- [ ] Delimiter auto-detection: count `;` vs `,` in first line, pick the more frequent one
- [ ] Same preview table and validation flow as JSON after parsing

### Duplicate Detection
- [ ] After parsing (JSON or CSV), compare each `(category, question)` pair against currently loaded `quizQArr` data
- [ ] Show duplicate count in preview header: "X pytań do importu (Y duplikatow w bazie)"
- [ ] Highlight duplicate rows in preview table with a warning badge/color
- [ ] Allow user to proceed anyway (duplicates are a warning, not a blocker)

### UX Improvements
- [ ] Whitespace trimming on all text fields (both frontend preview and backend insert)
- [ ] Full scrollable error list when validation fails (remove the 10-error truncation at `index.html:5667`)
- [ ] Example template buttons: "Przyklad JSON" and "Przyklad CSV" that populate the textarea with sample data
- [ ] Category autocomplete: show existing categories as `<datalist>` suggestions when `category` field values are being previewed
- [ ] Preview table shows all options (opt_a-d) and answer_full, not just question + correct answer

### Backend Improvements
- [ ] Whitespace trim all fields before validation (`server.js:489-497`)
- [ ] Batch INSERT optimization: single multi-row INSERT statement instead of loop (optional, performance enhancement)

## Implementation Details

### File Changes

#### `index.html` -- Frontend HTML (around line 2502-2536)

Add format selector radio buttons above textarea:

```html
<!-- Format selector -->
<div class="form-field" style="margin-bottom:.5rem">
  <label>Format danych</label>
  <div style="display:flex;gap:1rem;font-size:.82rem">
    <label><input type="radio" name="bulkFormat" value="json" checked> JSON</label>
    <label><input type="radio" name="bulkFormat" value="csv"> CSV</label>
  </div>
</div>

<!-- Example template buttons -->
<div style="display:flex;gap:8px;margin-bottom:.5rem">
  <button class="btn sm" id="btnBulkExampleJson" type="button">Przyklad JSON</button>
  <button class="btn sm" id="btnBulkExampleCsv" type="button">Przyklad CSV</button>
</div>
```

Update instructions text to mention both formats.

#### `index.html` -- Frontend JS (around line 5618-5713)

1. **CSV parser function** (~30 lines):

```javascript
function parseBulkCsv(raw) {
  // Strip BOM
  if (raw.charCodeAt(0) === 0xFEFF) raw = raw.slice(1);
  
  var lines = raw.split(/\r?\n/).filter(function(l) { return l.trim(); });
  if (lines.length < 2) throw new Error('CSV musi miec naglowek i min. 1 wiersz danych.');
  
  // Auto-detect delimiter
  var header = lines[0];
  var delim = (header.split(';').length > header.split(',').length) ? ';' : ',';
  
  var cols = header.split(delim).map(function(c) { return c.trim().replace(/^"|"$/g, ''); });
  var required = ['category','question','opt_a','opt_b','opt_c','opt_d','correct'];
  required.forEach(function(f) {
    if (cols.indexOf(f) === -1) throw new Error('Brak kolumny: ' + f);
  });
  
  var data = [];
  for (var i = 1; i < lines.length; i++) {
    var vals = splitCsvLine(lines[i], delim);
    var obj = {};
    cols.forEach(function(c, j) { obj[c] = (vals[j] || '').trim(); });
    obj.correct = parseInt(obj.correct);
    data.push(obj);
  }
  return data;
}

function splitCsvLine(line, delim) {
  // Handle quoted fields containing delimiters
  var result = [], current = '', inQuotes = false;
  for (var i = 0; i < line.length; i++) {
    if (line[i] === '"') { inQuotes = !inQuotes; }
    else if (line[i] === delim && !inQuotes) { result.push(current); current = ''; }
    else { current += line[i]; }
  }
  result.push(current);
  return result;
}
```

2. **Update `btnBulkPreview` click handler** to branch on selected format:

```javascript
var format = document.querySelector('input[name="bulkFormat"]:checked').value;
var data;
if (format === 'csv') {
  try { data = parseBulkCsv(raw); } catch(e) { bulkShowError('Blad CSV: ' + e.message); return; }
} else {
  try { data = JSON.parse(raw); } catch(e) { bulkShowError('Blad JSON: ' + e.message); return; }
}
```

3. **Duplicate detection** after validation, before showing preview:

```javascript
var dupes = [];
if (window.quizQArr && window.quizQArr.length) {
  var existing = {};
  quizQArr.forEach(function(q) { existing[q.category + '||' + q.question] = true; });
  data.forEach(function(q, i) {
    if (existing[q.category + '||' + q.question]) dupes.push(i);
  });
}
```

4. **Full error list** -- replace truncation logic:

```javascript
if (errors.length > 0) {
  var errHtml = '<div style="max-height:160px;overflow-y:auto">';
  errors.forEach(function(e) { errHtml += '<div>' + escH(e) + '</div>'; });
  errHtml += '</div>';
  $('bulkQuizError').innerHTML = errHtml;
  // ... show error, hide preview
}
```

5. **Example template buttons**:

```javascript
$('btnBulkExampleJson').addEventListener('click', function() {
  document.querySelector('input[name="bulkFormat"][value="json"]').checked = true;
  $('bulkQuizJson').value = JSON.stringify([
    { category:"Sieci komputerowe", question:"Co to jest IP?", answer_full:"IP to protokol...",
      opt_a:"Protokol internetowy", opt_b:"Przegladarka", opt_c:"System operacyjny", opt_d:"Jezyk programowania", correct:0 },
    { category:"Sieci komputerowe", question:"Co to jest DNS?", answer_full:"DNS to system...",
      opt_a:"Domain Name System", opt_b:"Data Network Service", opt_c:"Digital Name Server", opt_d:"Dynamic Node System", correct:0 }
  ], null, 2);
});
```

#### `server.js` -- Backend (around line 489)

Add whitespace trimming in the validation loop:

```javascript
questions.forEach((q, i) => {
  // Trim all string fields
  ['category','question','answer_full','opt_a','opt_b','opt_c','opt_d'].forEach(f => {
    if (typeof q[f] === 'string') q[f] = q[f].trim();
  });
  // ... existing validation
});
```

### Enhanced Preview Table

Current preview shows only: `#`, `Kategoria`, `Pytanie`, `Poprawna`. Expand to include all 4 options in a more detailed view:

```javascript
html += '<th>Opcje A-D</th>';
// In row:
html += '<td style="font-size:.72rem;max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">' +
  'A: ' + escH(q.opt_a) + ' | B: ' + escH(q.opt_b) + ' | C: ' + escH(q.opt_c) + ' | D: ' + escH(q.opt_d) + '</td>';
```

## Dependencies & Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| CSV encoding issues (Polish chars via Excel) | Medium | BOM stripping + UTF-8 assumption. Document that CSV must be UTF-8. |
| Category fragmentation from imports | Medium | Show existing categories in preview, add datalist for category field in add form |
| Duplicate data on re-import | High | Client-side duplicate detection with visual warning in preview |
| Express 1MB body limit for large batches | Low | 500 question cap keeps payloads well under 1MB |

## Success Metrics

- Admins can import 50+ questions in under 30 seconds (vs ~5 minutes individually)
- Zero accidental duplicate imports (warning catches them)
- Both JSON and CSV formats work correctly with Polish characters

## Sources & References

### Internal References
- Existing bulk import backend: `server.js:479-521`
- Existing bulk import frontend HTML: `index.html:2502-2536`
- Existing bulk import frontend JS: `index.html:5618-5713`
- Single question add form pattern: `index.html:2485-2500`, JS at `index.html:5501-5523`
- Transaction pattern reference: `server.js:296-319`
- Quiz question schema: `server.js:59-71`
- HTML escape helper: `index.html:1906` (`escH()`)
- Toast helper: `index.html:1909` (`toast()`)
- Duplicate data history: `docs/plans/2026-03-23-002-live-db-reconciliation-plan.md`
- Batch INSERT suggestion: `docs/plans/2026-03-23-001-fix-full-app-audit-plan.md:254`
- Leitner bucket impact: `docs/plans/2026-03-24-001-feat-leitner-bucket-question-selection-plan.md`
