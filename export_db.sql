-- ============================================================
--  export_db.sql
--  Eksport struktury i danych bazy matura_db
--  Uzycie: mysql -u root -p < export_db.sql
-- ============================================================

USE matura_db;

-- ============================================================
--  CZESC 1: Struktura bazy danych wraz z relacjami
-- ============================================================

-- 1a. Lista wszystkich tabel
SELECT '=== LISTA TABEL ===' AS '';
SHOW TABLES;

-- 1b. Struktura kazdej tabeli (kolumny, typy, klucze)
SELECT '=== STRUKTURA TABEL ===' AS '';

SELECT '--- algo_tasks ---' AS '';
SHOW CREATE TABLE algo_tasks\G

SELECT '--- algo_task_tests ---' AS '';
SHOW CREATE TABLE algo_task_tests\G

SELECT '--- algo_attempts ---' AS '';
SHOW CREATE TABLE algo_attempts\G

SELECT '--- algo_test_results ---' AS '';
SHOW CREATE TABLE algo_test_results\G

SELECT '--- quiz_questions ---' AS '';
SHOW CREATE TABLE quiz_questions\G

SELECT '--- quiz_results ---' AS '';
SHOW CREATE TABLE quiz_results\G

SELECT '--- flashcard_progress ---' AS '';
SHOW CREATE TABLE flashcard_progress\G

SELECT '--- sessions ---' AS '';
SHOW CREATE TABLE sessions\G

SELECT '--- users ---' AS '';
SHOW CREATE TABLE users\G

SELECT '--- sql_scenarios ---' AS '';
SHOW CREATE TABLE sql_scenarios\G

SELECT '--- sql_tasks ---' AS '';
SHOW CREATE TABLE sql_tasks\G

SELECT '--- sql_attempts ---' AS '';
SHOW CREATE TABLE sql_attempts\G

-- 1c. Wszystkie klucze obce (relacje miedzy tabelami)
SELECT '=== KLUCZE OBCE (RELACJE) ===' AS '';
SELECT
    CONSTRAINT_NAME        AS `Nazwa relacji`,
    TABLE_NAME             AS `Tabela`,
    COLUMN_NAME            AS `Kolumna`,
    REFERENCED_TABLE_NAME  AS `Tabela nadrzedna`,
    REFERENCED_COLUMN_NAME AS `Kolumna nadrzedna`
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'matura_db'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;

-- 1d. Wszystkie indeksy
SELECT '=== INDEKSY ===' AS '';
SELECT
    TABLE_NAME  AS `Tabela`,
    INDEX_NAME  AS `Indeks`,
    NON_UNIQUE  AS `Nie-unikalny`,
    GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX) AS `Kolumny`
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'matura_db'
GROUP BY TABLE_NAME, INDEX_NAME, NON_UNIQUE
ORDER BY TABLE_NAME, INDEX_NAME;

-- 1e. Ograniczenia CHECK
SELECT '=== OGRANICZENIA CHECK ===' AS '';
SELECT
    CONSTRAINT_NAME AS `Nazwa`,
    TABLE_NAME      AS `Tabela`,
    CHECK_CLAUSE    AS `Warunek`
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'matura_db'
ORDER BY TABLE_NAME;

-- 1f. Podsumowanie liczby rekordow w kazdej tabeli
SELECT '=== LICZBA REKORDOW ===' AS '';
SELECT 'algo_tasks'          AS `Tabela`, COUNT(*) AS `Rekordy` FROM algo_tasks
UNION ALL
SELECT 'algo_task_tests',     COUNT(*) FROM algo_task_tests
UNION ALL
SELECT 'algo_attempts',       COUNT(*) FROM algo_attempts
UNION ALL
SELECT 'algo_test_results',   COUNT(*) FROM algo_test_results
UNION ALL
SELECT 'quiz_questions',      COUNT(*) FROM quiz_questions
UNION ALL
SELECT 'quiz_results',        COUNT(*) FROM quiz_results
UNION ALL
SELECT 'flashcard_progress',  COUNT(*) FROM flashcard_progress
UNION ALL
SELECT 'sessions',            COUNT(*) FROM sessions
UNION ALL
SELECT 'users',               COUNT(*) FROM users
UNION ALL
SELECT 'sql_scenarios',       COUNT(*) FROM sql_scenarios
UNION ALL
SELECT 'sql_tasks',           COUNT(*) FROM sql_tasks
UNION ALL
SELECT 'sql_attempts',        COUNT(*) FROM sql_attempts;


-- ============================================================
--  CZESC 2: Wszystkie dane
-- ============================================================

SELECT '=== DANE: algo_tasks ===' AS '';
SELECT * FROM algo_tasks ORDER BY id;

SELECT '=== DANE: algo_task_tests ===' AS '';
SELECT * FROM algo_task_tests ORDER BY task_id, id;

SELECT '=== DANE: algo_attempts ===' AS '';
SELECT * FROM algo_attempts ORDER BY id;

SELECT '=== DANE: algo_test_results ===' AS '';
SELECT * FROM algo_test_results ORDER BY id;

SELECT '=== DANE: quiz_questions ===' AS '';
SELECT * FROM quiz_questions ORDER BY id;

SELECT '=== DANE: quiz_results ===' AS '';
SELECT * FROM quiz_results ORDER BY id;

SELECT '=== DANE: flashcard_progress ===' AS '';
SELECT * FROM flashcard_progress ORDER BY id;

SELECT '=== DANE: sessions ===' AS '';
SELECT * FROM sessions ORDER BY id;

SELECT '=== DANE: users ===' AS '';
SELECT * FROM users ORDER BY id;

SELECT '=== DANE: sql_scenarios ===' AS '';
SELECT * FROM sql_scenarios ORDER BY id;

SELECT '=== DANE: sql_tasks ===' AS '';
SELECT * FROM sql_tasks ORDER BY id;

SELECT '=== DANE: sql_attempts ===' AS '';
SELECT * FROM sql_attempts ORDER BY id;
