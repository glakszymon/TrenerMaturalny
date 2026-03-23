szymon@atari:/opt/matura$ docker exec -i matura-db-1 mariadb -u matura_user -pzmien_na_silne_haslo_12^! matura_db < ./TrenerMaturalny/export_db.sql 

=== LISTA TABEL ===
Tables_in_matura_db
algo_attempts
algo_task_tests
algo_tasks
algo_test_results
flashcard_progress
quiz_questions
quiz_results
sessions
sql_attempts
sql_scenarios
sql_tasks
users

=== STRUKTURA TABEL ===

--- algo_tasks ---
*************************** 1. row ***************************
       Table: algo_tasks
Create Table: CREATE TABLE `algo_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `difficulty` enum('easy','medium','hard') DEFAULT 'easy',
  `description` text NOT NULL,
  `hint` text DEFAULT NULL,
  `ex_input` text DEFAULT NULL,
  `ex_output` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `solution` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- algo_task_tests ---
*************************** 1. row ***************************
       Table: algo_task_tests
Create Table: CREATE TABLE `algo_task_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `test_name` varchar(100) NOT NULL,
  `input_data` mediumtext DEFAULT NULL,
  `expected` mediumtext DEFAULT NULL,
  `is_hidden` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `algo_task_tests_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `algo_tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci

--- algo_attempts ---
*************************** 1. row ***************************
       Table: algo_attempts
Create Table: CREATE TABLE `algo_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `task_id` int(11) NOT NULL,
  `task_title` varchar(200) NOT NULL,
  `code` mediumtext NOT NULL,
  `tests_total` int(11) NOT NULL,
  `tests_passed` int(11) NOT NULL,
  `attempted_at` datetime DEFAULT current_timestamp(),
  `duration_ms` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_sess_algo` (`session_id`),
  KEY `idx_task` (`task_id`),
  CONSTRAINT `fk_algo_attempts_task` FOREIGN KEY (`task_id`) REFERENCES `algo_tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- algo_test_results ---
*************************** 1. row ***************************
       Table: algo_test_results
Create Table: CREATE TABLE `algo_test_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attempt_id` bigint(20) unsigned NOT NULL,
  `test_name` varchar(200) NOT NULL,
  `input_data` text DEFAULT NULL,
  `expected` text DEFAULT NULL,
  `got` text DEFAULT NULL,
  `passed` tinyint(1) NOT NULL,
  `time_ms` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `attempt_id` (`attempt_id`),
  CONSTRAINT `algo_test_results_ibfk_1` FOREIGN KEY (`attempt_id`) REFERENCES `algo_attempts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=577 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- quiz_questions ---
*************************** 1. row ***************************
       Table: quiz_questions
Create Table: CREATE TABLE `quiz_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `question` text NOT NULL,
  `answer_full` text DEFAULT NULL,
  `opt_a` text NOT NULL,
  `opt_b` text NOT NULL,
  `opt_c` text NOT NULL,
  `opt_d` text NOT NULL,
  `correct` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_correct` CHECK (`correct` between 0 and 3)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci

--- quiz_results ---
*************************** 1. row ***************************
       Table: quiz_results
Create Table: CREATE TABLE `quiz_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `question_text` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `time_ms` int(11) NOT NULL,
  `answered_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_sess_quiz` (`session_id`),
  KEY `idx_category` (`category`),
  KEY `fk_quiz_results_question` (`question_id`),
  CONSTRAINT `fk_quiz_results_question` FOREIGN KEY (`question_id`) REFERENCES `quiz_questions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=779 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- flashcard_progress ---
*************************** 1. row ***************************
       Table: flashcard_progress
Create Table: CREATE TABLE `flashcard_progress` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `seen_count` int(11) DEFAULT 0,
  `correct_count` int(11) DEFAULT 0,
  `last_seen` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sess_q` (`session_id`,`question_id`),
  KEY `fk_flashcard_question` (`question_id`),
  CONSTRAINT `fk_flashcard_question` FOREIGN KEY (`question_id`) REFERENCES `quiz_questions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- sessions ---
*************************** 1. row ***************************
       Table: sessions
Create Table: CREATE TABLE `sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=854 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- users ---
*************************** 1. row ***************************
       Table: users
Create Table: CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(64) NOT NULL,
  `pin` varchar(128) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci

--- sql_scenarios ---
*************************** 1. row ***************************
       Table: sql_scenarios
Create Table: CREATE TABLE `sql_scenarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ddl` mediumtext NOT NULL,
  `seed` mediumtext NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_sql_scenario_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- sql_tasks ---
*************************** 1. row ***************************
       Table: sql_tasks
Create Table: CREATE TABLE `sql_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scenario_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `difficulty` enum('easy','medium','hard') DEFAULT 'hard',
  `description` text NOT NULL,
  `hint` text DEFAULT NULL,
  `solution` text NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_sql_task_scenario` (`scenario_id`),
  CONSTRAINT `sql_tasks_ibfk_1` FOREIGN KEY (`scenario_id`) REFERENCES `sql_scenarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

--- sql_attempts ---
*************************** 1. row ***************************
       Table: sql_attempts
Create Table: CREATE TABLE `sql_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `task_title` varchar(200) NOT NULL,
  `query` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `error_msg` text DEFAULT NULL,
  `attempted_at` datetime DEFAULT current_timestamp(),
  `task_id_ref` int(11) DEFAULT NULL,
  `scenario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sess_sql` (`session_id`),
  KEY `idx_sql_task` (`task_id`),
  KEY `fk_sql_attempts_task_ref` (`task_id_ref`),
  KEY `fk_sql_attempts_scenario` (`scenario_id`),
  CONSTRAINT `fk_sql_attempts_scenario` FOREIGN KEY (`scenario_id`) REFERENCES `sql_scenarios` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_sql_attempts_task_ref` FOREIGN KEY (`task_id_ref`) REFERENCES `sql_tasks` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

=== KLUCZE OBCE (RELACJE) ===
Nazwa relacji	Tabela	Kolumna	Tabela nadrzedna	Kolumna nadrzedna
fk_algo_attempts_task	algo_attempts	task_id	algo_tasks	id
algo_task_tests_ibfk_1	algo_task_tests	task_id	algo_tasks	id
algo_test_results_ibfk_1	algo_test_results	attempt_id	algo_attempts	id
fk_flashcard_question	flashcard_progress	question_id	quiz_questions	id
fk_quiz_results_question	quiz_results	question_id	quiz_questions	id
fk_sql_attempts_scenario	sql_attempts	scenario_id	sql_scenarios	id
fk_sql_attempts_task_ref	sql_attempts	task_id_ref	sql_tasks	id
sql_tasks_ibfk_1	sql_tasks	scenario_id	sql_scenarios	id

=== INDEKSY ===
Tabela	Indeks	Nie-unikalny	Kolumny
algo_attempts	idx_sess_algo	1	session_id
algo_attempts	idx_task	1	task_id
algo_attempts	PRIMARY	0	id
algo_tasks	PRIMARY	0	id
algo_task_tests	PRIMARY	0	id
algo_task_tests	task_id	1	task_id
algo_test_results	attempt_id	1	attempt_id
algo_test_results	PRIMARY	0	id
flashcard_progress	fk_flashcard_question	1	question_id
flashcard_progress	PRIMARY	0	id
flashcard_progress	uq_sess_q	0	session_id,question_id
quiz_questions	PRIMARY	0	id
quiz_results	fk_quiz_results_question	1	question_id
quiz_results	idx_category	1	category
quiz_results	idx_sess_quiz	1	session_id
quiz_results	PRIMARY	0	id
sessions	PRIMARY	0	id
sessions	session_id	0	session_id
sql_attempts	fk_sql_attempts_scenario	1	scenario_id
sql_attempts	fk_sql_attempts_task_ref	1	task_id_ref
sql_attempts	idx_sess_sql	1	session_id
sql_attempts	idx_sql_task	1	task_id
sql_attempts	PRIMARY	0	id
sql_scenarios	idx_sql_scenario_active	1	is_active
sql_scenarios	PRIMARY	0	id
sql_tasks	idx_sql_task_scenario	1	scenario_id
sql_tasks	PRIMARY	0	id
users	nick	0	nick
users	PRIMARY	0	id

=== OGRANICZENIA CHECK ===
Nazwa	Tabela	Warunek
chk_correct	quiz_questions	`correct` between 0 and 3

=== LICZBA REKORDOW ===
Tabela	Rekordy
algo_tasks	37
algo_task_tests	310
algo_attempts	17
algo_test_results	132
quiz_questions	372
quiz_results	690
flashcard_progress	0
sessions	5
users	2
sql_scenarios	3
sql_tasks	17
sql_attempts	9

=== DANE: algo_tasks ===
id	title	difficulty	description	hint	ex_input	ex_output	is_active	created_at	solution
1	Liczba pierwsza	easy	Wczytaj liczbę całkowitą N (0 ≤ N ≤ 10^9). Wypisz TAK jeśli jest pierwsza, NIE w przeciwnym razie.	Sprawdzaj dzielniki tylko do √N. Pętla: for(int i=2; i*i<=n; i++). Pamiętaj: 0 i 1 to nie liczby pierwsze.	17	TAK	1	2026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nbool pierwsza(long long n){\n    if(n < 2) return false;\n    if(n == 2) return true;\n    if(n % 2 == 0) return false;\n    for(long long i = 3; i * i <= n; i += 2)\n        if(n % i == 0) return false;\n    return true;\n}\nint main(){\n    long long n; cin >> n;\n    cout << (pierwsza(n) ? "TAK" : "NIE") << endl;\n    return 0;\n}
2	Rozkład na czynniki pierwsze	easy	Wczytaj N (2 ≤ N ≤ 10^6). Wypisz rozkład: p1^e1 * p2^e2 * ... Pomiń "^1" gdy wykładnik = 1.	Dziel N przez kolejne liczby od 2. Licz powtórzenia. Gdy i*i > N i N > 1, N jest ostatnim czynnikiem.	360	2^3 * 3^2 * 5	1	2026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nbool pierwsza(long long n){\n    if(n < 2) return false;\n    if(n == 2) return true;\n    if(n % 2 == 0) return false;\n    for(long long i = 3; i * i <= n; i += 2)\n        if(n % i == 0) return false;\n    return true;\n}\nint main(){\n    long long n; cin >> n;\n    cout << (pierwsza(n) ? "TAK" : "NIE") << endl;\n    return 0;\n}
3	Wyszukiwanie binarne	medium	Wczytaj n, następnie n posortowanych liczb, potem x. Wypisz indeks (od 0) pierwszego x lub -1.	l=0, r=n-1, mid=(l+r)/2. Porównaj a[mid] z x i zawęż przedział.	7\n1 3 5 7 9 11 13\n7	3	1	2026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int& x : a) cin >> x;\n    int k; cin >> k;\n    int lo = 0, hi = n-1, pos = -1;\n    while(lo <= hi){\n        int mid = (lo+hi)/2;\n        if(a[mid] == k){ pos = mid; break; }\n        else if(a[mid] < k) lo = mid+1;\n        else hi = mid-1;\n    }\n    cout << pos << endl;\n    return 0;\n}
4	Konwersja dziesiętna → binarna	easy	Wczytaj N (0 ≤ N ≤ 10^9). Wypisz reprezentację binarną bez wiodących zer. Wyjątek: N=0 → "0".	Dziel N przez 2, zbieraj reszty od tyłu. Szczególny przypadek: N=0.	42	101010	1	2026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long n; cin >> n;\n    if(n == 0){ cout << 0; return 0; }\n    string bin = "";\n    while(n > 0){ bin = char('0' + n%2) + bin; n /= 2; }\n    cout << bin << endl;\n    return 0;\n}
5	Algorytm Euklidesa NWD	easy	Wczytaj A i B (0 ≤ A, B ≤ 10^18). Wypisz NWD(A,B). Przypadek: NWD(0,0) = 0.	nwd(a,b) = nwd(b, a%b), nwd(a,0) = a. Użyj long long!	48 18	6	12026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long a, b;\n    cin >> a >> b;\n    while(b != 0){\n        long long r = a % b;\n        a = b; b = r;\n    }\n    cout << a << endl;\n    return 0;\n}
6	Sortowanie przez wstawianie	medium	Wczytaj n, potem n liczb. Posortuj insertion sort rosnąco. Wypisz tablicę, w drugiej linii liczbę przestawień.	Klucz = a[i], cofaj elementy > klucz o jeden w prawo. Każde cofnięcie = +1 do licznika.	5\n5 3 1 4 2	1 2 3 4 5\n7	1	2026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int i = 0; i < n; i++) cin >> a[i];\n    for(int i = 1; i < n; i++){\n        int key = a[i], j = i-1;\n        while(j >= 0 && a[j] > key){ a[j+1] = a[j]; j--; }\n        a[j+1] = key;\n    }\n    for(int i = 0; i < n; i++) cout << a[i] << " \n"[i==n-1];\n    return 0;\n}
7	Sito Eratostenesa	medium	Wczytaj N (2 ≤ N ≤ 10^6). Wypisz wszystkie liczby pierwsze od 2 do N, każdą w osobnej linii.	Tablica bool is_prime[N+1]. Dla i od 2: jeśli is_prime[i], oznacz wielokrotności i (od i*i) jako false.	20	2\n3\n5\n7\n11\n13\n17\n19	1	2026-03-14 11:29:38	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<bool> sito(n+1, true);\n    sito[0] = sito[1] = false;\n    for(int i = 2; i * i <= n; i++)\n        if(sito[i])\n            for(int j = i*i; j <= n; j += i)\n                sito[j] = false;\n    for(int i = 2; i <= n; i++)\n        if(sito[i]) cout << i << "\n";\n    return 0;\n}
8	Liczba doskonała	easy	Wczytaj liczbę całkowitą N (1 ≤ N ≤ 10^7). Wypisz TAK jeśli N jest liczbą doskonałą (suma właściwych dzielników = N), NIE w przeciwnym razie.	Sumuj dzielniki d od 1 do N-1 gdzie N%d==0. Optymalizacja: iteruj do √N i dodawaj oba dzielniki, uważaj na d=√N.	6	TAK	1	2026-03-14 12:19:36	NULL
9	Konwersja: dziesiętny → hex	easy	Wczytaj liczbę całkowitą N (0 ≤ N ≤ 10^9). Wypisz jej reprezentację szesnastkową WIELKIMI LITERAMI (bez prefiksu 0x). Przypadek: N=0 → "0".	Dziel N przez 16, reszty: 10→A, 11→B, 12→C, 13→D, 14→E, 15→F. Zbieraj od tyłu.	255	FF	1	2026-03-14 12:19:36	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long n; int b;\n    cin >> n >> b;\n    if(n == 0){ cout << 0; return 0; }\n    string res = "";\n    while(n > 0){\n        int r = n % b;\n        res = char(r < 10 ? '0'+r : 'A'+(r-10)) + res;\n        n /= b;\n    }\n    cout << res << endl;\n    return 0;\n}
10	Konwersja: dziesiętny → system o podstawie B	medium	Wczytaj dwie liczby: N (0 ≤ N ≤ 10^9) i B (2 ≤ B ≤ 16). Wypisz N w systemie o podstawie B (cyfry >9 jako A-F wielkie litery). N=0 → "0".	Dziel N przez B, resztę zamieniaj na znak (0-9 lub A-F). Zbieraj reszty od tyłu.	42 2	101010	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long n; int b; cin >> n >> b;\n    if(n == 0){ cout << 0; return 0; }\n    string res = "";\n    while(n > 0){\n        int r = n % b;\n        res = char(r < 10 ? '0'+r : 'A'+(r-10)) + res;\n        n /= b;\n    }\n    cout << res << endl;\n    return 0;\n}
11	NWD i NWW	easy	Wczytaj dwie dodatnie liczby całkowite A i B (1 ≤ A, B ≤ 10^9). Wypisz w dwóch liniach: NWD(A,B) i NWW(A,B). NWW = A/NWD * B (uważaj na overflow, użyj long long).	NWD algorytmem Euklidesa. NWW(a,b) = a / NWD(a,b) * b – najpierw dziel, by uniknąć overflow.	12 8	4\n24	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long a, b;\n    cin >> a >> b;\n    long long p = a, q = b;\n    while(q != 0){ long long r = p % q; p = q; q = r; }\n    cout << (a / p) * b << endl;\n    return 0;\n}
12	Porównywanie tekstów (anagram)	easy	Wczytaj dwa słowa S1 i S2 (tylko małe litery, max 1000 znaków). Wypisz TAK jeśli są anagramami (zawierają te same litery w dowolnej kolejności), NIE w przeciwnym razie.	Posortuj oba ciągi i porównaj. Lub zlicz wystąpienia każdej litery (tablica int freq[26]).	listen\nsilent	TAK	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    string a, b; cin >> a >> b;\n    sort(a.begin(), a.end());\n    sort(b.begin(), b.end());\n    cout << (a == b ? "TAK" : "NIE") << endl;\n    return 0;\n}
13	Wyszukiwanie wzorca (metoda naiwna)	medium	Wczytaj tekst T i wzorzec W (tylko małe litery). Wypisz wszystkie pozycje (od 0) początku wzorca w tekście, każdą w osobnej linii. Jeśli brak – wypisz "BRAK".	Dla każdej pozycji i (0..len(T)-len(W)) sprawdź czy T[i..i+len(W)] == W. Złożoność O(n*m) jest wystarczająca.	ababcabab\nab	0\n2\n5\n7	1	2026-03-14 12:19:37	NULL
14	Szyfr Cezara	easy	Wczytaj tekst (tylko małe litery i spacje) i liczbę przesunięcia K (0 ≤ K ≤ 25). Wypisz zaszyfrowany tekst (spacje bez zmian, litery przesunięte cyklicznie o K w prawo).	Dla każdej litery c: wynik = (c - 'a' + K) % 26 + 'a'. Spacje przepisz bez zmian.	hello world\n3	khoor zruog	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    string s; int k;\n    cin >> s >> k;\n    k = ((k % 26) + 26) % 26;\n    for(char& c : s){\n        if(c>='a'&&c<='z') c = 'a' + (c-'a'+k)%26;\n        else if(c>='A'&&c<='Z') c = 'A' + (c-'A'+k)%26;\n    }\n    cout << s << endl;\n    return 0;\n}
15	Algorytm Euklidesa – wersja rekurencyjna	easy	Wczytaj dwie nieujemne liczby całkowite A i B (0 ≤ A,B ≤ 10^18). Wypisz NWD używając rekurencji. Następnie wypisz liczbę wywołań rekurencyjnych (wliczając pierwsze wywołanie).	nwd(a,b): jeśli b==0 zwróć a, wpp zwróć nwd(b, a%b). Licznik++przy każdym wywołaniu. Użyj long long.	48 18	6\n4	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long a, b;\n    cin >> a >> b;\n    while(b != 0){\n        long long r = a % b;\n        a = b; b = r;\n    }\n    cout << a << endl;\n    return 0;\n}
16	Wyszukiwanie max i min jednocześnie	easy	Wczytaj n (1 ≤ n ≤ 10^6) i n liczb całkowitych. Wypisz minimum i maksimum w dwóch liniach. Policz porównania i wypisz w trzeciej linii. Metoda dziel i zwyciężaj: porównuj parami (ceil(3n/2)-2 porównań).	Metoda par: dla każdej pary (a[i], a[i+1]) znajdź lokalny min i max (1 porównanie), potem porównaj z globalnym min/max (2 porównania). Razem ~3n/2 porównań.	6\n3 1 4 1 5 9	1\n9\n8	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int& x : a) cin >> x;\n    cout << *max_element(a.begin(), a.end()) << " "\n         << *min_element(a.begin(), a.end()) << endl;\n    return 0;\n}
17	Sortowanie przez scalanie (Merge Sort)	hard	Wczytaj n (1 ≤ n ≤ 10^5) i n liczb całkowitych. Posortuj rosnąco algorytmem merge sort i wypisz wynik. W drugiej linii wypisz liczbę porównań wykonanych podczas scalania.	Rekurencyjnie dziel na pół, sort lewą, sort prawą, scal. Podczas scalania licz każde porównanie elementów. Złożoność O(n log n).	5\n5 3 1 4 2	1 2 3 4 5\n8	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nvoid msort(vector<int>& a, int l, int r){\n    if(l >= r) return;\n    int mid=(l+r)/2;\n    msort(a,l,mid); msort(a,mid+1,r);\n    inplace_merge(a.begin()+l, a.begin()+mid+1, a.begin()+r+1);\n}\nint main(){\n    int n; cin>>n;\n    vector<int> a(n);\n    for(int& x:a) cin>>x;\n    msort(a,0,n-1);\n    for(int i=0;i<n;i++) cout<<a[i]<<" \n"[i==n-1];\n    return 0;\n}
18	Metoda połowienia – miejsce zerowe	medium	Wczytaj trzy liczby rzeczywiste a, b, eps (a < b, eps > 0). Znajdź miejsce zerowe funkcji f(x) = x^3 - x - 2 w przedziale [a,b] metodą bisekcji. Wypisz wynik z dokładnością do eps (format %.6f).	mid = (a+b)/2. Jeśli f(a)*f(mid) <= 0, to b=mid, wpp a=mid. Powtarzaj dopóki b-a > eps.	1.0 2.0 0.000001	1.521380	12026-03-14 12:19:37	NULL
19	Pierwiastek kwadratowy (metoda Newtona)	medium	Wczytaj liczbę rzeczywistą X (0 < X ≤ 10^9) i dokładność eps (domyślnie 1e-9). Wypisz sqrt(X) obliczone metodą Newtona-Raphsona z dokładnością 6 miejsc po przecinku.	x_{n+1} = (x_n + X/x_n) / 2. Startuj od x0 = X/2. Powtarzaj dopóki |x_{n+1} - x_n| > eps.	2	1.414214	1	2026-03-14 12:19:37	NULL
20	Schemat Hornera – wartość wielomianu	medium	Wczytaj stopień n (0 ≤ n ≤ 1000), następnie n+1 współczynników a_n, a_{n-1}, ..., a_0, a na końcu wartość x. Oblicz wartość wielomianu W(x) i wypisz ją. Użyj schematu Hornera.	W = a_n; for i in 1..n: W = W*x + a_{n-i}. Złożoność O(n), bez potęgowania.	2\n1 -3 2\n3	2	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nlong long power(long long base, long long exp, long long mod){\n    long long result = 1;\n    base %= mod;\n    while(exp > 0){\n        if(exp & 1) result = result * base % mod;\n        base = base * base % mod;\n        exp >>= 1;\n    }\n    return result;\n}\nint main(){\n    long long a, b, m;\n    cin >> a >> b >> m;\n    cout << power(a, b, m) << endl;\n    return 0;\n}
21	Szybkie potęgowanie iteracyjne	medium	Wczytaj podstawę B i wykładnik E (0 ≤ B ≤ 10^9, 0 ≤ E ≤ 10^18). Oblicz B^E mod 10^9+7 algorytmem szybkiego potęgowania iteracyjnego.	res=1, base=B%MOD. Dopóki E>0: jeśli E%2==1 to res=res*base%MOD. base=base*base%MOD. E/=2. Użyj long long!	2 10	1024	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nlong long power(long long base, long long exp, long long mod){\n    long long result = 1; base %= mod;\n    while(exp > 0){\n        if(exp & 1) result = result * base % mod;\n        base = base * base % mod;\n        exp >>= 1;\n    }\n    return result;\n}\nint main(){\n    long long a, b, m; cin >> a >> b >> m;\n    cout << power(a, b, m) << endl;\n    return 0;\n}
22	Szybkie potęgowanie rekurencyjne	medium	Wczytaj B i E (0 ≤ B ≤ 10^9, 0 ≤ E ≤ 10^9). Oblicz B^E mod 10^9+7 rekurencyjnie. Wypisz wynik i głębokość rekurencji.	fast_pow(b,e): jeśli e==0 zwróć 1; jeśli e parzyste: t=fast_pow(b,e/2); zwróć t*t%MOD; wpp zwróć b*fast_pow(b,e-1)%MOD. Głębokość = log2(E)+1.	2 10	1024\n5	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nlong long power(long long base, long long exp, long long mod){\n    long long result = 1;\n    base %= mod;\n    while(exp > 0){\n        if(exp & 1) result = result * base % mod;\n        base = base * base % mod;\n        exp >>= 1;\n    }\n    return result;\n}\nint main(){\n    long long a, b, m;\n    cin >> a >> b >> m;\n    cout << power(a, b, m) << endl;\n    return 0;\n}
23	Rekurencyjne fraktale – ciąg Kocha (długość)	hard	Wczytaj długość boku L (liczba całkowita) i liczbę iteracji n (0 ≤ n ≤ 20). Wypisz łączną długość krzywej Kocha po n iteracjach. Każdy segment dzieli się na 4 segmenty o długości 1/3 pierwotnego. Wypisz jako liczbę całkowitą (L * 4^n / 3^n – wypisz licznik i mianownik w postaci nieskracalnej).	Po n krokach: liczba segmentów = 4^n, długość segmentu = L/3^n. Łączna = L * (4/3)^n. Wypisz licznik/mianownik po uproszczeniu przez NWD.	3 2	16/3	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    long long a, b;\n    cin >> a >> b;\n    while(b != 0){\n        long long r = a % b;\n        a = b; b = r;\n    }\n    cout << a << endl;\n    return 0;\n}
24	Najdłuższy wspólny podciąg (LCS)	hard	Wczytaj dwa ciągi znaków S1 i S2 (tylko małe litery, max 1000 znaków każdy). Wypisz długość najdłuższego wspólnego podciągu (LCS) i sam podciąg. Programowanie dynamiczne.	dp[i][j] = dp[i-1][j-1]+1 jeśli S1[i]==S2[j], wpp max(dp[i-1][j], dp[i][j-1]). Odtwórz podciąg idąc wstecz.	ABCBDAB\nBDCAB	4\nBCAB	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    string a, b; cin >> a >> b;\n    int n=a.size(), m=b.size();\n    vector<vector<int>> dp(n+1,vector<int>(m+1,0));\n    for(int i=1;i<=n;i++)\n        for(int j=1;j<=m;j++)\n            if(a[i-1]==b[j-1]) dp[i][j]=dp[i-1][j-1]+1;\n            else dp[i][j]=max(dp[i-1][j],dp[i][j-1]);\n    cout<<dp[n][m]<<endl;\n    return 0;\n}
25	Zamiana na ONP i obliczanie wartości	hard	Wczytaj wyrażenie arytmetyczne w notacji infiksowej (liczby całkowite, operatory +,-,*,/, nawiasy). Wypisz postać ONP (odwrotna notacja polska), a w drugiej linii wartość wyrażenia (dzielenie całkowite).	Algorytm stacji rozrządowej (Shunting-yard): operatory na stos, liczby do kolejki. Priorytety: */=2, +/−=1. Ewaluuj ONP stosem.	3 + 4 * 2	3 4 2 * +\n11	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    string s; cin >> s;\n    stack<char> st;\n    bool ok = true;\n    for(char c : s){\n        if(c=='(' || c=='[' || c=='{') st.push(c);\n        else if(c==')' || c==']' || c=='}'){\n            if(st.empty()){ ok=false; break; }\n            char top = st.top(); st.pop();\n            if((c==')' && top!='(') ||\n               (c==']' && top!='[') ||\n               (c=='}' && top!='{')){ ok=false; break; }\n        }\n    }\n    if(!st.empty()) ok = false;\n    cout << (ok ? "TAK" : "NIE") << endl;\n    return 0;\n}
26	Podejście zachłanne – wydawanie reszty	medium	Wczytaj kwotę Q i liczbę nominałów k (1 ≤ k ≤ 20). Następnie k nominałów w kolejności malejącej. Wypisz minimalną liczbę monet metodą zachłanną i ich skład (po jednej linii na nominał: "nominał x ilość", pomiń zera). Zakładaj, że nominały pozwalają zawsze wydać resztę.	Zachłannie: bierz jak najwięcej największego nominału, potem następnego. Monety[i] = Q / nominał[i]; Q %= nominał[i].	41\n3\n25 10 1	4\n25 x 1\n10 x 1\n1 x 6	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n, k; cin >> n >> k;\n    vector<int> monety(k);\n    for(int& x : monety) cin >> x;\n    vector<int> dp(n+1, INT_MAX);\n    dp[0] = 0;\n    for(int i = 1; i <= n; i++)\n        for(int m : monety)\n            if(m <= i && dp[i-m] != INT_MAX)\n                dp[i] = min(dp[i], dp[i-m]+1);\n    cout << (dp[n]==INT_MAX ? -1 : dp[n]) << endl;\n    return 0;\n}
27	Programowanie dynamiczne – najdłuższy rosnący podciąg (LIS)	hard	Wczytaj n (1 ≤ n ≤ 10^4) i n liczb całkowitych. Wypisz długość najdłuższego ściśle rosnącego podciągu (LIS) i sam podciąg.	dp[i] = max(dp[j]+1) dla j<i gdzie a[j]<a[i]. dp[i] = 1 na starcie. Złożoność O(n^2). Odtwórz podciąg śledząc poprzedniki.	8\n10 9 2 5 3 7 101 18	4\n2 3 7 18	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\n// Przykład: najdłuższy rosnący podciąg (LIS)\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int& x : a) cin >> x;\n    vector<int> dp(n, 1);\n    for(int i=1;i<n;i++)\n        for(int j=0;j<i;j++)\n            if(a[j]<a[i]) dp[i]=max(dp[i], dp[j]+1);\n    cout << *max_element(dp.begin(), dp.end()) << endl;\n    return 0;\n}
28	Struktury dynamiczne – stos (realizacja ONP)	medium	Zaimplementuj stos na tablicy. Wczytaj n operacji: "PUSH x" (wstaw x), "POP" (usuń i wypisz), "TOP" (podejrzyj bez usuwania), "EMPTY" (wypisz 1 jeśli pusty, 0 wpp). Na wyjściu każda operacja wypisująca w osobnej linii.	Tablica int stack[MAX]; int top=-1. PUSH: stack[++top]=x. POP: return stack[top--]. TOP: return stack[top]. EMPTY: return top==-1.	5\nPUSH 3\nPUSH 7\nTOP\nPOP\nEMPTY	7\n7\n0	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    string s; cin >> s;\n    stack<char> st;\n    bool ok = true;\n    for(char c : s){\n        if(c=='('||c=='['||c=='{') st.push(c);\n        else if(c==')'||c==']'||c=='}'){\n            if(st.empty()){ ok=false; break; }\n            char top = st.top(); st.pop();\n            if((c==')'&&top!='(') || (c==']'&&top!='[') || (c=='}'&&top!='{')){ ok=false; break; }\n        }\n    }\n    if(!st.empty()) ok = false;\n    cout << (ok ? "TAK" : "NIE") << endl;\n    return 0;\n}
29	Struktury dynamiczne – kolejka	medium	Zaimplementuj kolejkę (FIFO). Wczytaj n operacji: "ENQUEUE x", "DEQUEUE" (usuń i wypisz pierwszy), "FRONT" (podejrzyj), "EMPTY". Na wyjściu operacje wypisujące w osobnych liniach.	Tablica cykliczna lub dwie zmienne head/tail. ENQUEUE: arr[tail++]=x. DEQUEUE: return arr[head++].	5\nENQUEUE 3\nENQUEUE 7\nFRONT\nDEQUEUE\nEMPTY3\n3\n0	1	2026-03-14 12:19:37	NULL
30	Metoda połowienia – wyszukiwanie w tablicy (rekurencja)	medium	Wczytaj n, tablicę posortowaną rosnąco i szukaną wartość x. Zaimplementuj wyszukiwanie binarne REKURENCYJNIE. Wypisz indeks (od 0) lub -1 oraz głębokość rekurencji.	bin_search(arr, l, r, x, depth): mid=(l+r)/2. Jeśli arr[mid]==x zwróć {mid, depth}. Jeśli x<arr[mid] szukaj w lewej, wpp prawej. Przypadek: l>r → {-1, depth}.	7\n1 3 5 7 9 11 13\n7	3\n2	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int& x : a) cin >> x;\n    int k; cin >> k;\n    int lo = 0, hi = n-1, pos = -1;\n    while(lo <= hi){\n        int mid = (lo+hi)/2;\n        if(a[mid] == k){ pos = mid; break; }\n        else if(a[mid] < k) lo = mid+1;\n        else hi = mid-1;\n    }\n    cout << pos << endl;\n    return 0;\n}
31	Rekurencja – ciąg Fibonacciego z memoizacją	medium	Wczytaj n (0 ≤ n ≤ 50). Oblicz F(n) metodą rekurencyjną z memoizacją. Wypisz F(n) i liczbę unikalnych wywołań rekurencyjnych (bez powtórek dzięki memoizacji). F(0)=0, F(1)=1.	memo[n] = -1 na starcie. Jeśli memo[n] != -1 zwróć memo[n]. Wpp oblicz rekurencyjnie i zapisz. Licznik wywołań bez memoizacji = n+1.	10	55\n11	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n;\n    cin >> n;\n    long long a = 0, b = 1;\n    if(n == 0){ cout << 0; return 0; }\n    for(int i = 2; i <= n; i++){\n        long long c = a + b;\n        a = b; b = c;\n    }\n    cout << b << endl;\n    return 0;\n}
32	Grafy – BFS (najkrótsza ścieżka)	hard	Wczytaj liczbę wierzchołków V i krawędzi E, potem E par (u v) reprezentujących krawędzie nieskierowane, a na końcu wierzchołek startowy S i docelowy T. Wypisz długość najkrótszej ścieżki od S do T lub -1 jeśli nie istnieje. Wierzchołki numerowane od 1.	BFS z kolejką: odległości dist[V+1]=-1. dist[S]=0. Dodaj S do kolejki. Dla każdego u z kolejki: dla każdego sąsiada v: jeśli dist[v]==-1 to dist[v]=dist[u]+1, dodaj v do kolejki.	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	1	2026-03-14 12:19:37	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n, m; cin >> n >> m;\n    vector<vector<int>> adj(n+1);\n    for(int i = 0; i < m; i++){\n        int u, v; cin >> u >> v;\n        adj[u].push_back(v); adj[v].push_back(u);\n    }\n    int s, t; cin >> s >> t;\n    vector<int> dist(n+1, -1);\n    queue<int> q;\n    dist[s] = 0; q.push(s);\n    while(!q.empty()){\n        int u = q.front(); q.pop();\n        for(int v : adj[u]) if(dist[v]==-1){ dist[v]=dist[u]+1; q.push(v); }\n    }\n    cout << dist[t] << endl;\n    return 0;\n}
33	Sortowanie bąbelkowe (Bubble Sort)	easy	Wczytaj n (1 ≤ n ≤ 1000) i n liczb całkowitych. Posortuj rosnąco algorytmem bubble sort. Wypisz posortowaną tablicę, a w drugiej linii liczbę wykonanych zamian (swapów).	Zewnętrzna pętla i od 0 do n-1, wewnętrzna j od 0 do n-i-2. Jeśli a[j]>a[j+1] → zamień i swap++. Optymalizacja: przerwij gdy brak zamian w przejściu.5\n5 3 1 4 2	1 2 3 4 5\n7	1	2026-03-14 12:28:28	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int i = 0; i < n; i++) cin >> a[i];\n    for(int i = 0; i < n-1; i++)\n        for(int j = 0; j < n-1-i; j++)\n            if(a[j] > a[j+1]) swap(a[j], a[j+1]);\n    for(int i = 0; i < n; i++) cout << a[i] << " \n"[i==n-1];\n    return 0;\n}
34	Sortowanie szybkie (Quick Sort)	hard	Wczytaj n (1 ≤ n ≤ 10^5) i n liczb całkowitych. Posortuj rosnąco algorytmem quicksort (pivot = ostatni element partycji). Wypisz posortowaną tablicę i liczbę porównań wykonanych w funkcji partition.	partition(arr,l,r): pivot=arr[r], i=l-1. Dla j=l..r-1: jeśli arr[j]<=pivot to i++, swap(arr[i],arr[j]), porównanie++. Swap(arr[i+1],arr[r]). Rekurencja na obu częściach.	5\n3 6 8 10 1	1 3 6 8 10\n10	1	2026-03-14 12:28:28	#include <bits/stdc++.h>\nusing namespace std;\nvoid qsort(vector<int>& a, int l, int r){\n    if(l >= r) return;\n    int pivot = a[(l+r)/2], i = l, j = r;\n    while(i <= j){\n        while(a[i] < pivot) i++;\n        while(a[j] > pivot) j--;\n        if(i <= j) swap(a[i++], a[j--]);\n    }\n    qsort(a, l, j);\n    qsort(a, i, r);\n}\nint main(){\n    int n; cin >> n;\n    vector<int> a(n);\n    for(int& x : a) cin >> x;\n    qsort(a, 0, n-1);\n    for(int i = 0; i < n; i++) cout << a[i] << " \\n"[i==n-1];\n    return 0;\n}
35	Wyszukiwanie liniowe	easy	Wczytaj n (1 ≤ n ≤ 10^6), n liczb całkowitych, a następnie szukaną wartość x. Wypisz indeks (od 0) pierwszego wystąpienia x lub -1 jeśli nie znaleziono. W drugiej linii wypisz liczbę wykonanych porównań.	Iteruj od i=0 do n-1, porównanie++ przy każdym kroku. Jeśli a[i]==x zwróć i. Jeśli przeszedłeś całą tablicę → -1. Liczba porównań = i+1 (znaleziony) lub n (nieznaleziony).	5\n3 1 4 1 5\n4	2\n3	1	2026-03-14 12:28:28	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    map<int, int> cnt;\n    for(int i = 0; i < n; i++){\n        int x; cin >> x; cnt[x]++;\n    }\n    for(auto& [val, c] : cnt)\n        cout << val << ": " << c << "\\n";\n    return 0;\n}
36	Ciąg Fibonacciego (iteracyjny)	easy	Wczytaj n (0 ≤ n ≤ 93). Wypisz F(n) – n-ty wyraz ciągu Fibonacciego obliczony iteracyjnie. F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2). Użyj long long (F(93) przekracza zakres int).	Użyj dwóch zmiennych: a=0, b=1. W pętli: temp=a+b, a=b, b=temp. Po n-1 iteracjach a = F(n). Przypadki brzegowe: F(0)=0, F(1)=1.	10	55	1	2026-03-14 12:28:28	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n;\n    cin >> n;\n    if(n == 0){ cout << 0; return 0; }\n    long long a = 0, b = 1;\n    for(int i = 2; i <= n; i++){\n        long long c = a + b;\n        a = b; b = c;\n    }\n    cout << b << endl;\n    return 0;\n}
37	Palindromy	easy	Wczytaj słowo S (tylko małe litery, 1 ≤ |S| ≤ 10^6). Wypisz TAK jeśli S jest palindromem (czytane od przodu i od tyłu jest identyczne), NIE w przeciwnym razie.	Porównuj S[i] z S[n-1-i] dla i od 0 do n/2-1. Jeśli jakakolwiek para różna → NIE. Lub odwróć ciąg i porównaj z oryginałem.	kajak	TAK	1	2026-03-14 12:28:28	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    string s; cin >> s;\n    string r = s; reverse(r.begin(), r.end());\n    cout << (s == r ? "TAK" : "NIE") << endl;\n    return 0;\n}

=== DANE: algo_task_tests ===
id	task_id	test_name	input_data	expected	is_hidden	created_at
338	1	zero	0	NIE	0	2026-03-18 19:22:53
339	1	jeden	1	NIE	0	2026-03-18 19:22:53
340	1	dwa	2	TAK	0	2026-03-18 19:22:53
341	1	trzy	3	TAK	0	2026-03-18 19:22:53
342	1	cztery	4	NIE	0	2026-03-18 19:22:53
343	1	siedemnascie	17	TAK	0	2026-03-18 19:22:53
344	1	duza_pierwsza	1000000007	TAK	1	2026-03-18 19:22:53
345	1	duza_zlozona	1000000008	NIE	1	2026-03-18 19:22:53
346	1	zlozena_25	25	NIE	1	2026-03-18 19:22:53
347	2	dwa	2	2	0	2026-03-18 19:22:53
348	2	cztery	4	2^2	0	2026-03-18 19:22:53
349	2	dwanascie	12	2^2 * 3	0	2026-03-18 19:22:53
350	2	trzysta	360	2^3 * 3^2 * 5	0	2026-03-18 19:22:53
351	2	pierwsza	997	997	1	2026-03-18 19:22:53
352	2	milion	1000000	2^6 * 5^6	1	2026-03-18 19:22:53
353	3	jeden_elem_ok	1\n5\n5	0	0	2026-03-18 19:22:53
354	3	jeden_elem_brak	1\n5\n3	-1	0	2026-03-18 19:22:53
355	3	siedem_elem	7\n1 3 5 7 9 11 13\n7	3	0	2026-03-18 19:22:53
356	3	brak_w_tablicy	5\n2 4 6 8 10\n1	-1	1	2026-03-18 19:22:53
357	3	ostatni_elem	5\n2 4 6 8 10\n10	4	1	2026-03-18 19:22:53
358	4	zero	0	0	0	2026-03-18 19:22:53
359	4	jeden	1	1	0	2026-03-18 19:22:53
360	4	dwa	2	10	0	2026-03-18 19:22:53
361	4	czterdziesci_dwa	42	101010	0	2026-03-18 19:22:53
362	4	osiem_bitow	255	11111111	1	2026-03-18 19:22:53
363	4	miliard	1000000000	111011100110101100101000000000	1	2026-03-18 19:22:53
364	5	klasyczny	48 18	6	0	2026-03-18 19:22:53
365	5	zero_b	0 5	5	0	2026-03-18 19:22:53
366	5	a_zero	5 0	5	0	2026-03-18 19:22:53
367	5	oba_zero	0 0	0	0	2026-03-18 19:22:53
368	5	wzglednie_pierwsze	13 7	1	1	2026-03-18 19:22:53
369	5	duze_liczby	1000000000000000000 999999999999999999	1	1	2026-03-18 19:22:53
370	6	jeden_elem	1\n7	7\n0	0	2026-03-18 19:22:53
371	6	juz_posortowane	5\n1 2 3 4 5	1 2 3 4 5\n0	0	2026-03-18 19:22:53
372	6	odwrotne	5\n5 4 3 2 1	1 2 3 4 5\n10	0	2026-03-18 19:22:53
373	6	przyklad	5\n5 3 1 4 2	1 2 3 4 5\n7	1	2026-03-18 19:22:53
374	7	tylko_dwa	2	2	0	2026-03-18 19:22:53
375	7	do_dziesiec	10	2\n3\n5\n7	0	2026-03-18 19:22:53
376	7	do_dwadziescia	20	2\n3\n5\n7\n11\n13\n17\n19	0	2026-03-18 19:22:53
377	7	do_trzydziesci	30	2\n3\n5\n7\n11\n13\n17\n19\n23\n29	1	2026-03-18 19:22:53
378	8	szesc	6	TAK	0	2026-03-18 19:22:53
379	8	dwadziescia_osiem	28	TAK	0	2026-03-18 19:22:53
380	8	jeden	1	NIE	0	2026-03-18 19:22:53
381	8	dwanascie	12	NIE	0	2026-03-18 19:22:53
382	8	czterysta_dziewiec	496	TAK	1	2026-03-18 19:22:53
383	8	osiem_tysiecy	8128	TAK	1	2026-03-18 19:22:53
384	8	duza_zlozona	100	NIE	1	2026-03-18 19:22:53
507	8	szesc	6	TAK	0	2026-03-18 19:22:54
508	8	dwadziescia_osiem	28	TAK	0	2026-03-18 19:22:54
509	8	jeden	1	NIE	0	2026-03-18 19:22:54
510	8	dwanascie	12	NIE	0	2026-03-18 19:22:54
511	8	czterysta_dziewiec	496	TAK	1	2026-03-18 19:22:54
512	8	osiem_tysiecy	8128	TAK	1	2026-03-18 19:22:54
513	8	duza_zlozona	100	NIE	1	2026-03-18 19:22:54
385	9	zero	0	0	0	2026-03-18 19:22:53
386	9	jeden	1	1	0	2026-03-18 19:22:53
387	9	dziesiec	10	A	0	2026-03-18 19:22:53
388	9	ff	255	FF	0	2026-03-18 19:22:53
389	9	sto	256	100	0	2026-03-18 19:22:53
390	9	cafe	51966	CAFE	1	2026-03-18 19:22:53
391	9	miliard	1000000000	3B9ACA00	1	2026-03-18 19:22:53
514	9	zero	0	0	0	2026-03-18 19:22:54
515	9	jeden	1	1	0	2026-03-18 19:22:54
516	9	dziesiec	10	A	0	2026-03-18 19:22:54
517	9	ff	255	FF	0	2026-03-18 19:22:54
518	9	sto	256	100	0	2026-03-18 19:22:54
519	9	cafe	51966	CAFE	1	2026-03-18 19:22:54
520	9	miliard	1000000000	3B9ACA00	1	2026-03-18 19:22:54
392	10	binarny_zero	0 2	0	0	2026-03-18 19:22:53
393	10	binarny_42	42 2	101010	0	2026-03-18 19:22:53
394	10	osemkowy_255	255 8	377	0	2026-03-18 19:22:53
395	10	hex_255	255 16	FF	0	2026-03-18 19:22:53
396	10	trojkowy_10	10 3	101	0	2026-03-18 19:22:53
397	10	hex_miliard	1000000000 16	3B9ACA00	1	2026-03-18 19:22:53
521	10	binarny_zero	0 2	0	0	2026-03-18 19:22:54
522	10	binarny_42	42 2	101010	0	2026-03-18 19:22:54
523	10	osemkowy_255	255 8	377	0	2026-03-18 19:22:54
524	10	hex_255	255 16	FF	0	2026-03-18 19:22:54
525	10	trojkowy_10	10 3	101	0	2026-03-18 19:22:54
526	10	hex_miliard	1000000000 16	3B9ACA00	1	2026-03-18 19:22:54
398	11	przyklad	12 8	4\n24	0	2026-03-18 19:22:53
399	11	wzglednie	13 7	1\n91	0	2026-03-18 19:22:53
400	11	rowne	6 6	6\n6	0	2026-03-18 19:22:53
401	11	jeden_jeden	1 1	1\n1	0	2026-03-18 19:22:53
402	11	duze	999999999 1000000000	1\n999999999000000000	1	2026-03-18 19:22:53
527	11	przyklad	12 8	4\n24	0	2026-03-18 19:22:54
528	11	wzglednie	13 7	1\n91	0	2026-03-18 19:22:54
529	11	rowne	6 6	6\n6	0	2026-03-18 19:22:54
530	11	jeden_jeden	1 1	1\n1	0	2026-03-18 19:22:54
531	11	duze	999999999 1000000000	1\n999999999000000000	1	2026-03-18 19:22:54
403	12	listen_silent	listen\nsilent	TAK	0	2026-03-18 19:22:53
404	12	hello_world	hello\nworld	NIE	0	2026-03-18 19:22:53
405	12	abc_cba	abc\ncba	TAK	0	2026-03-18 19:22:53
406	12	rozna_dlugosc	ab\nabc	NIE	0	2026-03-18 19:22:53
407	12	jedno_slowo	a\na	TAK	1	2026-03-18 19:22:53
408	12	puste_rozne	ab\nba	TAK	1	2026-03-18 19:22:53
532	12	listen_silent	listen\nsilent	TAK	0	2026-03-18 19:22:54
533	12	hello_world	hello\nworld	NIE	0	2026-03-18 19:22:54
534	12	abc_cba	abc\ncba	TAK	0	2026-03-18 19:22:54
535	12	rozna_dlugosc	ab\nabc	NIE	0	2026-03-18 19:22:54
536	12	jedno_slowo	a\na	TAK	1	2026-03-18 19:22:54
537	12	puste_rozne	ab\nba	TAK	1	2026-03-18 19:22:54
409	13	przyklad	ababcabab\nab	0\n2\n5\n7	0	2026-03-18 19:22:53
410	13	brak	hello\nxyz	BRAK	0	2026-03-18 19:22:53
411	13	poczatek	abcdef\nabc	0	0	2026-03-18 19:22:53
412	13	koniec	xyzabc\nabc	3	0	2026-03-18 19:22:53
413	13	caly_tekst	abc\nabc	0	0	2026-03-18 19:22:53
414	13	wielokrotne	aaaaaa\naa	0\n1\n2\n3\n4	1	2026-03-18 19:22:53
538	13	przyklad	ababcabab\nab	0\n2\n5\n7	0	2026-03-18 19:22:54
539	13	brak	hello\nxyz	BRAK	0	2026-03-18 19:22:54
540	13	poczatek	abcdef\nabc	0	0	2026-03-18 19:22:54
541	13	koniec	xyzabc\nabc	3	0	2026-03-18 19:22:54
542	13	caly_tekst	abc\nabc	0	0	2026-03-18 19:22:54
543	13	wielokrotne	aaaaaa\naa	0\n1\n2\n3\n4	1	2026-03-18 19:22:54
415	14	przyklad	hello world\n3	khoor zruog	0	2026-03-18 19:22:53
416	14	zero	abc\n0	abc	0	2026-03-18 19:22:53
417	14	dwadziescia_szesc	abc\n26	abc	0	2026-03-18 19:22:53
418	14	pelny_obrot	xyz\n3	abc	0	2026-03-18 19:22:53
419	14	ze_spacjami	ab cd\n1	bc de	1	2026-03-18 19:22:53
420	14	jeden_znak	z\n1	a	1	2026-03-18 19:22:53
544	14	przyklad	hello world\n3	khoor zruog	0	2026-03-18 19:22:54
545	14	zero	abc\n0	abc	0	2026-03-18 19:22:54
546	14	dwadziescia_szesc	abc\n26	abc	0	2026-03-18 19:22:54
547	14	pelny_obrot	xyz\n3	abc	0	2026-03-18 19:22:54
548	14	ze_spacjami	ab cd\n1	bc de	1	2026-03-18 19:22:54
549	14	jeden_znak	z\n1	a	1	2026-03-18 19:22:54
421	16	przyklad	48 18	6\n4	0	2026-03-18 19:22:53
422	16	b_zero	5 0	5\n1	0	2026-03-18 19:22:53
423	16	rowne	7 7	7\n2	0	2026-03-18 19:22:53
424	16	wzglednie_pierw	13 7	1\n5	1	2026-03-18 19:22:53
425	16	duze	1000000000000000000 999999999999999999	1\n87	1	2026-03-18 19:22:53
550	16	przyklad	48 18	6\n4	0	2026-03-18 19:22:54
551	16	b_zero	5 0	5\n1	0	2026-03-18 19:22:54
552	16	rowne	7 7	7\n2	0	2026-03-18 19:22:54
553	16	wzglednie_pierw	13 7	1\n5	1	2026-03-18 19:22:54
554	16	duze	1000000000000000000 999999999999999999	1\n87	1	2026-03-18 19:22:54
426	17	przyklad	6\n3 1 4 1 5 9	1\n9\n8	0	2026-03-18 19:22:53
427	17	jeden_elem	1\n42	42\n42\n0	0	2026-03-18 19:22:53
428	17	dwa_elem	2\n5 3	3\n5\n1	0	2026-03-18 19:22:54
429	17	posortowane	4\n1 2 3 4	1\n4\n5	0	2026-03-18 19:22:54
430	17	wszystkie_rowne	4\n7 7 7 7	7\n7\n5	1	2026-03-18 19:22:54
555	17	przyklad	6\n3 1 4 1 5 9	1\n9\n8	0	2026-03-18 19:22:54
556	17	jeden_elem	1\n42	42\n42\n0	0	2026-03-18 19:22:54
557	17	dwa_elem	2\n5 3	3\n5\n1	0	2026-03-18 19:22:54
558	17	posortowane	4\n1 2 3 4	1\n4\n5	0	2026-03-18 19:22:54
559	17	wszystkie_rowne	4\n7 7 7 7	7\n7\n5	1	2026-03-18 19:22:54
431	18	przyklad	5\n5 3 1 4 2	1 2 3 4 5\n8	0	2026-03-18 19:22:54
432	18	jeden	1\n7	7\n0	0	2026-03-18 19:22:54
433	18	juz_posortowane	4\n1 2 3 4	1 2 3 4\n4	0	2026-03-18 19:22:54
434	18	odwrotne	4\n4 3 2 1	1 2 3 4\n4	0	2026-03-18 19:22:54
435	18	dwa_elem	2\n2 1	1 2\n1	1	2026-03-18 19:22:54
436	18	wiekszy	8\n8 7 6 5 4 3 2 1	1 2 3 4 5 6 7 8\n12	1	2026-03-18 19:22:54
560	18	przyklad	5\n5 3 1 4 2	1 2 3 4 5\n8	0	2026-03-18 19:22:54
561	18	jeden	1\n7	7\n0	0	2026-03-18 19:22:54
562	18	juz_posortowane	4\n1 2 3 4	1 2 3 4\n4	0	2026-03-18 19:22:54
563	18	odwrotne	4\n4 3 2 1	1 2 3 4\n4	0	2026-03-18 19:22:54
564	18	dwa_elem	2\n2 1	1 2\n1	1	2026-03-18 19:22:54
565	18	wiekszy	8\n8 7 6 5 4 3 2 1	1 2 3 4 5 6 7 8\n12	1	2026-03-18 19:22:54
437	19	przyklad	1.0 2.0 0.000001	1.521380	0	2026-03-18 19:22:54
438	19	szersza	0.0 3.0 0.000001	1.521380	0	2026-03-18 19:22:54
439	19	dokladna	1.0 2.0 0.0000001	1.521380	1	2026-03-18 19:22:54
566	19	przyklad	1.0 2.0 0.000001	1.521380	0	2026-03-18 19:22:54
567	19	szersza	0.0 3.0 0.000001	1.521380	0	2026-03-18 19:22:54
568	19	dokladna	1.0 2.0 0.0000001	1.521380	1	2026-03-18 19:22:54
440	20	sqrt2	2	1.414214	0	2026-03-18 19:22:54
441	20	sqrt9	9	3.000000	0	2026-03-18 19:22:54
442	20	sqrt1	1	1.000000	0	2026-03-18 19:22:54
443	20	sqrt100	100	10.000000	0	2026-03-18 19:22:54
444	20	sqrt2_5	2.25	1.500000	1	2026-03-18 19:22:54
569	20	sqrt2	2	1.414214	0	2026-03-18 19:22:54
570	20	sqrt9	9	3.000000	0	2026-03-18 19:22:54
571	20	sqrt1	1	1.000000	0	2026-03-18 19:22:54
572	20	sqrt100	100	10.000000	0	2026-03-18 19:22:54
573	20	sqrt2_5	2.25	1.500000	1	2026-03-18 19:22:54
445	21	przyklad	2\n1 -3 2\n3	2	0	2026-03-18 19:22:54
446	21	stala	0\n5\n100	5	0	2026-03-18 19:22:54
447	21	liniowy	1\n2 1\n3	7	0	2026-03-18 19:22:54
448	21	x_zero	3\n1 2 3 4\n0	4	0	2026-03-18 19:22:54
449	21	ujemne_x	2\n1 0 -1\n-2	3	1	2026-03-18 19:22:54
574	21	przyklad	2\n1 -3 2\n3	2	0	2026-03-18 19:22:54
575	21	stala	0\n5\n100	5	0	2026-03-18 19:22:54
576	21	liniowy	1\n2 1\n3	7	0	2026-03-18 19:22:54
577	21	x_zero	3\n1 2 3 4\n0	4	0	2026-03-18 19:22:54
578	21	ujemne_x	2\n1 0 -1\n-2	3	1	2026-03-18 19:22:54
450	22	przyklad	2 10	1024	0	2026-03-18 19:22:54
451	22	zero_exp	5 0	1	0	2026-03-18 19:22:54
452	22	jeden_base	1 1000000000000000000	1	0	2026-03-18 19:22:54
453	22	modulo	2 30	1073741824	0	2026-03-18 19:22:54
454	22	duze	2 1000000000	140625001	1	2026-03-18 19:22:54
455	22	zero_base	0 5	0	1	2026-03-18 19:22:54
579	22	przyklad	2 10	1024	0	2026-03-18 19:22:54
580	22	zero_exp	5 0	1	0	2026-03-18 19:22:54
581	22	jeden_base	1 1000000000000000000	1	0	2026-03-18 19:22:54
582	22	modulo	2 30	1073741824	0	2026-03-18 19:22:54
583	22	duze	2 1000000000	140625001	1	2026-03-18 19:22:54
584	22	zero_base	0 5	0	1	2026-03-18 19:22:54
456	23	przyklad	2 10	1024\n5	0	2026-03-18 19:22:54
457	23	zero_exp	5 0	1\n1	0	2026-03-18 19:22:54
458	23	dwa_jeden	2 1	2\n2	0	2026-03-18 19:22:54
459	23	dwa_osiem	2 8	256\n5	1	2026-03-18 19:22:54
585	23	przyklad	2 10	1024\n5	0	2026-03-18 19:22:54
586	23	zero_exp	5 0	1\n1	0	2026-03-18 19:22:54
587	23	dwa_jeden	2 1	2\n2	0	2026-03-18 19:22:54
588	23	dwa_osiem	2 8	256\n5	1	2026-03-18 19:22:54
460	24	n0	3 0	3/1	0	2026-03-18 19:22:54
461	24	n1	3 1	4/1	0	2026-03-18 19:22:54
462	24	n2	3 2	16/3	0	2026-03-18 19:22:54
463	24	n3	9 3	64/1	0	2026-03-18 19:22:54
464	24	n5	3 5	1024/81	1	2026-03-18 19:22:54
589	24	n0	3 0	3/1	0	2026-03-18 19:22:54
590	24	n1	3 1	4/1	0	2026-03-18 19:22:54
591	24	n2	3 2	16/3	0	2026-03-18 19:22:54
592	24	n3	9 3	64/1	0	2026-03-18 19:22:54
593	24	n5	3 5	1024/81	1	2026-03-18 19:22:54
465	26	przyklad	ABCBDAB\nBDCAB	4\nBCAB	0	2026-03-18 19:22:54
466	26	identyczne	ABC\nABC	3\nABC	0	2026-03-18 19:22:54
467	26	rozlaczne	ABC\nXYZ	0\n	0	2026-03-18 19:22:54
468	26	jeden_znak	A\nA	1\nA	0	2026-03-18 19:22:54
469	26	dlugi	AGGTAB\nGXTXAYB	4\nGTAB	1	2026-03-18 19:22:54
594	26	przyklad	ABCBDAB\nBDCAB	4\nBCAB	0	2026-03-18 19:22:54
595	26	identyczne	ABC\nABC	3\nABC	0	2026-03-18 19:22:54
596	26	rozlaczne	ABC\nXYZ	0\n	0	2026-03-18 19:22:54
597	26	jeden_znak	A\nA	1\nA	0	2026-03-18 19:22:54
598	26	dlugi	AGGTAB\nGXTXAYB	4\nGTAB	1	2026-03-18 19:22:54
470	27	przyklad	3 + 4 * 2	3 4 2 * +\n11	0	2026-03-18 19:22:54
471	27	nawiasy	( 2 + 3 ) * 4	2 3 + 4 *\n20	0	2026-03-18 19:22:54
472	27	samo_dodanie	1 + 2	1 2 +\n3	0	2026-03-18 19:22:54
473	27	zlozone	2 * ( 3 + 4 ) - 1	2 3 4 + * 1 -\n13	1	2026-03-18 19:22:54
599	27	przyklad	3 + 4 * 2	3 4 2 * +\n11	0	2026-03-18 19:22:54
600	27	nawiasy	( 2 + 3 ) * 4	2 3 + 4 *\n20	0	2026-03-18 19:22:54
601	27	samo_dodanie	1 + 2	1 2 +\n3	0	2026-03-18 19:22:54
602	27	zlozone	2 * ( 3 + 4 ) - 1	2 3 4 + * 1 -\n13	1	2026-03-18 19:22:54
474	28	przyklad	41\n3\n25 10 1	4\n25 x 1\n10 x 1\n1 x 6	0	2026-03-18 19:22:54
475	28	zero	0\n2\n10 1	0	0	2026-03-18 19:22:54
476	28	dokładny	100\n2\n50 25	2\n50 x 2	0	2026-03-18 19:22:54
477	28	jeden_grosz	7\n3\n5 2 1	4\n5 x 1\n2 x 1\n1 x 0	1	2026-03-18 19:22:54
603	28	przyklad	41\n3\n25 10 1	4\n25 x 1\n10 x 1\n1 x 6	0	2026-03-18 19:22:54
604	28	zero	0\n2\n10 1	0	0	2026-03-18 19:22:54
605	28	dokładny	100\n2\n50 25	2\n50 x 2	0	2026-03-18 19:22:54
606	28	jeden_grosz	7\n3\n5 2 1	4\n5 x 1\n2 x 1\n1 x 0	1	2026-03-18 19:22:54
478	29	przyklad	8\n10 9 2 5 3 7 101 18	4\n2 3 7 18	0	2026-03-18 19:22:54
479	29	jeden	1\n5	1\n5	0	2026-03-18 19:22:54
480	29	malejace	4\n4 3 2 1	1\n1	0	2026-03-18 19:22:54
481	29	rosnace	5\n1 2 3 4 5	5\n1 2 3 4 5	0	2026-03-18 19:22:54
482	29	z_rownoscia	5\n3 3 3 3 3	1\n3	1	2026-03-18 19:22:54
607	29	przyklad	8\n10 9 2 5 3 7 101 18	4\n2 3 7 18	0	2026-03-18 19:22:54
608	29	jeden	1\n5	1\n5	0	2026-03-18 19:22:54
609	29	malejace	4\n4 3 2 1	1\n1	0	2026-03-18 19:22:54
610	29	rosnace	5\n1 2 3 4 5	5\n1 2 3 4 5	0	2026-03-18 19:22:54
611	29	z_rownoscia	5\n3 3 3 3 3	1\n3	1	2026-03-18 19:22:54
483	31	przyklad	5\nPUSH 3\nPUSH 7\nTOP\nPOP\nEMPTY	7\n7\n0	0	2026-03-18 19:22:54
484	31	pusty	1\nEMPTY	1	0	2026-03-18 19:22:54
485	31	push_pop	3\nPUSH 1\nPOP\nEMPTY	1\n1	0	2026-03-18 19:22:54
486	31	trzy_push	4\nPUSH 5\nPUSH 3\nPUSH 1\nTOP	1	1	2026-03-18 19:22:54
612	31	przyklad	5\nPUSH 3\nPUSH 7\nTOP\nPOP\nEMPTY	7\n7\n0	0	2026-03-18 19:22:54
613	31	pusty	1\nEMPTY	1	0	2026-03-18 19:22:54
614	31	push_pop	3\nPUSH 1\nPOP\nEMPTY	1\n1	0	2026-03-18 19:22:54
615	31	trzy_push	4\nPUSH 5\nPUSH 3\nPUSH 1\nTOP	1	1	2026-03-18 19:22:54
487	32	przyklad	5\nENQUEUE 3\nENQUEUE 7\nFRONT\nDEQUEUE\nEMPTY	3\n3\n0	0	2026-03-18 19:22:54
488	32	pusty	1\nEMPTY	1	0	2026-03-18 19:22:54
489	32	fifo_order	4\nENQUEUE 1\nENQUEUE 2\nDEQUEUE\nDEQUEUE	1\n2	0	2026-03-18 19:22:54
490	32	front_nie_usuwa	3\nENQUEUE 9\nFRONT\nFRONT	9\n9	1	2026-03-18 19:22:54
616	32	przyklad	5\nENQUEUE 3\nENQUEUE 7\nFRONT\nDEQUEUE\nEMPTY	3\n3\n0	0	2026-03-18 19:22:54
617	32	pusty	1\nEMPTY	1	0	2026-03-18 19:22:54
618	32	fifo_order	4\nENQUEUE 1\nENQUEUE 2\nDEQUEUE\nDEQUEUE	1\n2	0	2026-03-18 19:22:54
619	32	front_nie_usuwa	3\nENQUEUE 9\nFRONT\nFRONT	9\n9	1	2026-03-18 19:22:54
491	33	przyklad	7\n1 3 5 7 9 11 13\n7	3\n2	0	2026-03-18 19:22:54
492	33	pierwszy	5\n1 2 3 4 5\n1	0\n3	0	2026-03-18 19:22:54
493	33	ostatni	5\n1 2 3 4 5\n5	4\n3	0	2026-03-18 19:22:54
494	33	brak	3\n1 3 5\n4	-1\n3	0	2026-03-18 19:22:54
495	33	jeden_elem	1\n42\n42	0\n1	1	2026-03-18 19:22:54
620	33	przyklad	7\n1 3 5 7 9 11 13\n7	3\n2	0	2026-03-18 19:22:54
621	33	pierwszy	5\n1 2 3 4 5\n1	0\n3	0	2026-03-18 19:22:54
622	33	ostatni	5\n1 2 3 4 5\n5	4\n3	0	2026-03-18 19:22:54
623	33	brak	3\n1 3 5\n4	-1\n3	0	2026-03-18 19:22:54
624	33	jeden_elem	1\n42\n42	0\n1	1	2026-03-18 19:22:54
496	34	n10	10	55\n11	0	2026-03-18 19:22:54
497	34	n0	0	0\n1	0	2026-03-18 19:22:54
498	34	n1	1	1\n2	0	2026-03-18 19:22:54
499	34	n5	5	5\n6	0	2026-03-18 19:22:54
500	34	n20	20	6765\n21	1	2026-03-18 19:22:54
501	34	n50	50	12586269025\n51	1	2026-03-18 19:22:54
625	34	n10	10	55\n11	0	2026-03-18 19:22:54
626	34	n0	0	0\n1	0	2026-03-18 19:22:54
627	34	n1	1	1\n2	0	2026-03-18 19:22:54
628	34	n5	5	5\n6	0	2026-03-18 19:22:54
629	34	n20	20	6765\n21	1	2026-03-18 19:22:54
630	34	n50	50	12586269025\n51	1	2026-03-18 19:22:54
502	35	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	0	2026-03-18 19:22:54
503	35	bezposredni	2 1\n1 2\n1 2	1	0	2026-03-18 19:22:54
504	35	brak	3 2\n1 2\n2 3\n1 3	1	0	2026-03-18 19:22:54
505	35	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	0	2026-03-18 19:22:54
506	35	ten_sam	3 2\n1 2\n2 3\n2 2	0	1	2026-03-18 19:22:54
631	35	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	0	2026-03-18 19:22:54
632	35	bezposredni	2 1\n1 2\n1 2	1	0	2026-03-18 19:22:54
633	35	brak	3 2\n1 2\n2 3\n1 3	1	0	2026-03-18 19:22:54
634	35	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	0	2026-03-18 19:22:54
635	35	ten_sam	3 2\n1 2\n2 3\n2 2	0	1	2026-03-18 19:22:54
636	36	przyklad	5\n5 3 1 4 2	1 2 3 4 5\n7	0	2026-03-18 19:22:54
637	36	jeden_elem	1\n7	7\n0	0	2026-03-18 19:22:54
638	36	juz_posortowane	5\n1 2 3 4 5	1 2 3 4 5\n0	0	2026-03-18 19:22:54
639	36	odwrotne	4\n4 3 2 1	1 2 3 4\n6	0	2026-03-18 19:22:54
640	36	dwa_elem_ok	2\n1 2	1 2\n0	0	2026-03-18 19:22:54
641	36	dwa_elem_swap	2\n2 1	1 2\n1	1	2026-03-18 19:22:54
642	36	wszystkie_rowne	4\n3 3 3 3	3 3 3 3\n0	1	2026-03-18 19:22:54
643	36	wiekszy	6\n6 5 4 3 2 1	1 2 3 4 5 6\n15	1	2026-03-18 19:22:54
644	37	przyklad	5\n3 6 8 10 1	1 3 6 8 10\n10	0	2026-03-18 19:22:54
645	37	jeden_elem	1\n42	42\n0	0	2026-03-18 19:22:54
646	37	dwa_posortowane	2\n1 2	1 2\n1	0	2026-03-18 19:22:54
647	37	dwa_odwrotne	2\n2 1	1 2\n1	0	2026-03-18 19:22:54

=== DANE: algo_attempts ===
id	session_id	task_id	task_title	code	tests_total	tests_passed	attempted_at	duration_ms
33	sess_1773858814644_bxxtcfy	12	Porównywanie tekstów (anagram)	#include <iostream>\nusing namespace std;\n\nint main() {\n    \n    return 0;\n}	0	0	2026-03-18 19:21:11	0
34	sess_1773858814644_bxxtcfy	14	Szyfr Cezara	#include <iostream>\n#include <string>\n\nusing namespace std;\n\nint main() {\n    string tekst, ans= "";\n    cin>>tekst;\n    int klucz;\n    cin>>klucz;\n    \n    for(int i = 0; i < tekst.size(); ++i)\n    {\n        int znak_wart = (int)tekst.at(i);\n        int po_edycji;\n        \n        if(znak_wart + klucz > 122)\n        {\n            int temp = (znak_wart + klucz) - 122;\n            po_edycji = 96+temp;\n        }else\n        {\n            po_edycji = znak_wart+klucz;\n        }\n        \n        ans += (char)po_edycji;\n    }\n    \n    cout<<ans;\n    return 0;\n}	12	8	2026-03-18 20:12:15	435000
35	sess_1773858814644_bxxtcfy	7	Sito Eratostenesa	#include <iostream>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    bool sito[n+1];\n    \n    for(int i = 0; i <=n; ++i)\n        sito[i] = true;\n    \n    sito[0] = false;\n    sito[1] = false;\n    \n    for(int i = 2; i <= n; ++i)\n    {\n        if(sito[i])\n        {\n            for(int j = i*i; j <= n; j+=i)\n            {\n                sito[j] = false;\n            }\n        }\n    }\n    \n    for(int i = 0; i <= n; ++i)\n    {\n        if(sito[i])\n            cout<<i<<endl;\n    }\n    return 0;\n}	4	4	2026-03-18 20:48:32	371000
36	sess_1773858814644_bxxtcfy	28	Struktury dynamiczne – stos (realizacja ONP)	#include <iostream>\n#include <vector>\n#include <string>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    \n    vector <int> stos;\n    \n    for(int p = 0; p < n; ++p)\n    {\n        string polecenie;\n        int wart;\n        cin>>polecenie;\n        \n        if(polecenie == "TOP")\n        {\n            cout<<stos.at(stos.size()-1)<<endl;\n            continue;\n        }\n        if(polecenie == "POP")\n        {\n            stos.pop_back();\n            continue;\n        }\n        if(polecenie == "EMPTY")\n        {\n            if(stos.size() == 0)\n                cout<<1<<endl;\n            else\n                cout<<0<<endl;\n            continue;\n        }\n        if(polecenie == "PUSH")\n        {\n            cin>>wart;\n            stos.push_back(wart);\n            continue;\n        }\n    }\n    return 0;\n}	8	0	2026-03-18 21:09:56	630000
37	sess_1773485427401_dkig00i	7	Sito Eratostenesa	#include <iostream>\nusing namespace std;\n\nint main() {\n    \n    return 0;\n}	4	0	2026-03-18 21:27:13	27000
38	sess_1773485427401_dkig00i	7	Sito Eratostenesa	#include <bits/stdc++.h>\nusing namespace std;\nint main(){\n    int n; cin >> n;\n    vector<bool> sito(n+1, true);\n    sito[0] = sito[1] = false;\n    for(int i = 2; i * i <= n; i++)\n        if(sito[i])\n            for(int j = i*i; j <= n; j += i)\n                sito[j] = false;\n    for(int i = 2; i <= n; i++)\n        if(sito[i]) cout << i << endl;\n    return 0;\n}	4	4	2026-03-18 21:27:51	62000
39	szymon	35	Wyszukiwanie liniowe	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int licz = 0;\n    vector<int> tab;\n    int n;\n    cin>>n;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        tab.push_back(x);\n    }\n    int szukana, znalez_na;\n    cin>>szukana;\n    bool found = false;\n    for(int i = 0; i < n; ++i)\n    {\n        ++licz;\n        if(tab.at(i) == szukana)\n        {\n            found = true;\n            znalez_na = i;\n            break;\n        }\n    }\n    \n    if(found)\n    {\n        cout<<endl<<znalez_na<<endl<<licz;\n    }else\n    {\n        cout<< -1;\n    }\n    return 0;\n}	10	2	2026-03-21 15:23:21	244000
40	szymon	35	Wyszukiwanie liniowe	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int licz = 0;\n    vector<int> tab;\n    int n;\n    cin>>n;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        tab.push_back(x);\n    }\n    int szukana, znalez_na;\n    cin>>szukana;\n    bool found = false;\n    for(int i = 0; i < n; ++i)\n    {\n        ++licz;\n        if(tab.at(i) == szukana)\n        {\n            found = true;\n            znalez_na = i;\n            break;\n        }\n    }\n    \n    if(found)\n    {\n        cout<<endl<<znalez_na<<endl;\n    }else\n    {\n        cout<< -1;\n    }\n    return 0;\n}	10	6	2026-03-21 15:24:05	288000
41	szymon	35	Wyszukiwanie liniowe	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int licz = 0;\n    vector<int> tab;\n    int n;\n    cin>>n;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        tab.push_back(x);\n    }\n    int szukana, znalez_na;\n    cin>>szukana;\n    bool found = false;\n    for(int i = 0; i < n; ++i)\n    {\n        ++licz;\n        if(tab.at(i) == szukana)\n        {\n            found = true;\n            znalez_na = i;\n            break;\n        }\n    }\n    \n    if(found)\n    {\n        cout<<endl<<znalez_na+1<<endl;\n    }else\n    {\n        cout<< -1;\n    }\n    return 0;\n}	10	4	2026-03-21 15:24:36	318000
42	szymon	35	Wyszukiwanie liniowe	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int licz = 0;\n    vector<int> tab;\n    int n;\n    cin>>n;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        tab.push_back(x);\n    }\n    int szukana, znalez_na;\n    cin>>szukana;\n    bool found = false;\n    for(int i = 0; i < n; ++i)\n    {\n        ++licz;\n        if(tab.at(i) == szukana)\n        {\n            found = true;\n            znalez_na = i;\n            break;\n        }\n    }\n    \n    if(found)\n    {\n        cout<<endl<<znalez_na<<endl;\n    }else\n    {\n        cout<< -1;\n    }\n    return 0;\n}	10	6	2026-03-21 15:24:43	326000
43	szymon	16	Wyszukiwanie max i min jednocześnie	#include <iostream>\nusing namespace std;\n\nint main() {\n    int wart_max = 0, wart_min = 10000, licz = 0;\n    int n;\n    cin>>n;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        wart_max=max(wart_max,x);\n        wart_min=min(wart_min,x);\n        ++licz;\n    }\n    \n    cout<<wart_min<<endl<<wart_max<<endl<<licz;\n    return 0;\n}	10	0	2026-03-22 14:14:02	265000
44	szymon	20	Schemat Hornera – wartość wielomianu	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    vector<int>tab;\n    \n    for(int i = 0; i <= n; ++i)\n    {\n        int z;\n        cin>>z;\n        cout<<z<<endl;\n        tab.push_back(z);\n    }\n    \n    for(int t : tab)\n        cout<<t<<" ";\n    int x;\n    cin>>x;\n    \n    int suma = 0, pot = 1;\n    \n    for(int i = tab.size()-1; i <= 0; --i)\n    {\n        suma += pot * tab.at(i);\n        pot *= x;\n    }\n    \n    cout<<suma;\n    \n    return 0;\n}	10	0	2026-03-22 14:36:16	350000
45	szymon	20	Schemat Hornera – wartość wielomianu	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    vector<int>tab;\n    \n    for(int i = 0; i <= n; ++i)\n    {\n        int z;\n        cin>>z;\n//         cout<<z<<endl;\n        tab.push_back(z);\n    }\n    \n//     for(int t : tab)\n//         cout<<t<<" ";\n    int x;\n    cin>>x;\n    \n    int suma = 0, pot = 1;\n    \n    for(int i = tab.size()-1; i <= 0; --i)\n    {\n        suma += pot * tab.at(i);\n        pot *= x;\n    }\n    \n    cout<<suma;\n    \n    return 0;\n}	10	0	2026-03-22 14:36:32	366000
46	szymon	20	Schemat Hornera – wartość wielomianu	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    vector<int>tab;\n    \n    for(int i = 0; i <= n; ++i)\n    {\n        float z;\n        cin>>z;\n//         cout<<z<<endl;\n        tab.push_back(z);\n    }\n    \n//     for(int t : tab)\n//         cout<<t<<" ";\n    float x;\n    cin>>x;\n    \n    float suma = 0, pot = 1;\n    \n    for(int i = tab.size()-1; i <= 0; --i)\n    {\n        suma += pot * tab.at(i);\n        pot *= x;\n    }\n    \n    cout<<suma;\n    \n    return 0;\n}	10	0	2026-03-22 14:36:56	390000
47	szymon	20	Schemat Hornera – wartość wielomianu	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    float n;\n    cin>>n;\n    vector<int>tab;\n    \n    for(int i = 0; i <= n; ++i)\n    {\n        float z;\n        cin>>z;\n//         cout<<z<<endl;\n        tab.push_back(z);\n    }\n    \n//     for(int t : tab)\n//         cout<<t<<" ";\n    float x;\n    cin>>x;\n    \n    float suma = 0, pot = 1;\n    \n    for(int i = tab.size()-1; i <= 0; --i)\n    {\n        suma += pot * tab.at(i);\n        pot *= x;\n    }\n    \n    cout<<suma;\n    \n    return 0;\n}	10	0	2026-03-22 14:37:17	411000
48	szymon	3	Wyszukiwanie binarne	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    vector<int>tab;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        tab.push_back(x);\n    }\n    \n    int szukana;\n    cin>>szukana;\n    \n    int id1 = 0, id2 = n-1,id_mid = n/2;\n    \n    while(id2 >= id1)\n    {\n        if(tab.at(id_mid) == szukana)\n        {\n            cout<<id_mid;\n            return 0;\n        }\n\n        if(tab.at(id_mid) < szukana)\n        {\n            id2 = id_mid+1;\n            id_mid = (id2 + id1)/2;\n        }else\n        {\n            id1 = id_mid+1;\n            id_mid = (id2+id1)/2;\n        }\n    }\n    \n    cout<<-1;\n    \n\n    return 0;\n}	5	4	2026-03-23 19:32:37	429000
49	szymon	3	Wyszukiwanie binarne	#include <iostream>\n#include <vector>\nusing namespace std;\n\nint main() {\n    int n;\n    cin>>n;\n    vector<int>tab;\n    for(int i = 0; i < n; ++i)\n    {\n        int x;\n        cin>>x;\n        tab.push_back(x);\n    }\n    \n    int szukana;\n    cin>>szukana;\n    \n    int id1 = 0, id2 = n-1,id_mid = n/2;\n    \n    while(id2 >= id1)\n    {\n        if(tab.at(id_mid) == szukana)\n        {\n            cout<<id_mid;\n            return 0;\n        }\n\n        if(tab.at(id_mid) < szukana)\n        {\n            id2 = id_mid-1;\n            id_mid = (id2 + id1)/2;\n        }else\n        {\n            id1 = id_mid+1;\n            id_mid = (id2+id1)/2;\n        }\n    }\n    \n    cout<<-1;\n    \n\n    return 0;\n}	5	4	2026-03-23 19:33:10	465000

=== DANE: algo_test_results ===
id	attempt_id	test_name	input_data	expected	got	passed	time_ms
445	34	przyklad	hello world\n3	khoor zruog	hello	0	6
446	34	zero	abc\n0	abc	abc	1	10
447	34	dwadziescia_szesc	abc\n26	abc	abc	1	7
448	34	pelny_obrot	xyz\n3	abc	abc	1	5
449	34	ze_spacjami	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	4
450	34	jeden_znak	NULL	(ukryty – OK)	(ukryty – OK)	1	5
451	34	przyklad	hello world\n3	khoor zruog	hello	0	6
452	34	zero	abc\n0	abc	abc	1	6
453	34	dwadziescia_szesc	abc\n26	abc	abc	1	7
454	34	pelny_obrot	xyz\n3	abc	abc	1	4
455	34	ze_spacjami	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	4
456	34	jeden_znak	NULL	(ukryty – OK)	(ukryty – OK)	1	7
457	35	tylko_dwa	2	2	2	1	6
458	35	do_dziesiec	10	2\n3\n5\n7	2\n3\n5\n7	1	6
459	35	do_dwadziescia	20	2\n3\n5\n7\n11\n13\n17\n19	2\n3\n5\n7\n11\n13\n17\n19	1	6
460	35	do_trzydziesci	NULL	(ukryty – OK)	(ukryty – OK)	1	5
461	36	przyklad	41\n3\n25 10 1	4\n25 x 1\n10 x 1\n1 x 6		0	6
462	36	zero	0\n2\n10 1	0		0	6
463	36	dokładny	100\n2\n50 25	2\n50 x 2		0	6
464	36	jeden_grosz	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	6
465	36	przyklad	41\n3\n25 10 1	4\n25 x 1\n10 x 1\n1 x 6		0	5
466	36	zero	0\n2\n10 1	0		0	9
467	36	dokładny	100\n2\n50 25	2\n50 x 2		0	7
468	36	jeden_grosz	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	6
469	37	tylko_dwa	2	2		0	8
470	37	do_dziesiec	10	2\n3\n5\n7		0	11
471	37	do_dwadziescia	20	2\n3\n5\n7\n11\n13\n17\n19		0	5
472	37	do_trzydziesci	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	6
473	38	tylko_dwa	2	2	2	1	6
474	38	do_dziesiec	10	2\n3\n5\n7	2\n3\n5\n7	1	9
475	38	do_dwadziescia	20	2\n3\n5\n7\n11\n13\n17\n19	2\n3\n5\n7\n11\n13\n17\n19	1	5
476	38	do_trzydziesci	NULL	(ukryty – OK)	(ukryty – OK)	1	5
477	39	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	2\n3	0	5
478	39	bezposredni	2 1\n1 2\n1 2	1	-1	0	4
479	39	brak	3 2\n1 2\n2 3\n1 3	1	0\n1	0	5
480	39	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	9
481	39	ten_sam	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	7
482	39	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	2\n3	0	6
483	39	bezposredni	2 1\n1 2\n1 2	1	-1	0	6
484	39	brak	3 2\n1 2\n2 3\n1 3	1	0\n1	0	5
485	39	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	6
486	39	ten_sam	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	5
487	40	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	2	1	5
488	40	bezposredni	2 1\n1 2\n1 2	1	-1	0	7
489	40	brak	3 2\n1 2\n2 3\n1 3	1	0	0	6
490	40	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	5
491	40	ten_sam	NULL	(ukryty – OK)	(ukryty – OK)	1	6
492	40	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	2	1	5
493	40	bezposredni	2 1\n1 2\n1 2	1	-1	0	5
494	40	brak	3 2\n1 2\n2 3\n1 3	1	0	0	8
495	40	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	5
496	40	ten_sam	NULL	(ukryty – OK)	(ukryty – OK)	1	9
497	41	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	3	0	6
498	41	bezposredni	2 1\n1 2\n1 2	1	-1	0	8
499	41	brak	3 2\n1 2\n2 3\n1 3	1	1	1	9
500	41	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	9
501	41	ten_sam	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	8
502	41	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	3	0	7
503	41	bezposredni	2 1\n1 2\n1 2	1	-1	0	8
504	41	brak	3 2\n1 2\n2 3\n1 3	1	1	1	8
505	41	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	8
506	41	ten_sam	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	7
507	42	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	2	1	9
508	42	bezposredni	2 1\n1 2\n1 2	1	-1	0	6
509	42	brak	3 2\n1 2\n2 3\n1 3	1	0	0	6
510	42	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	6
511	42	ten_sam	NULL	(ukryty – OK)	(ukryty – OK)	1	5
512	42	przyklad	5 6\n1 2\n1 3\n2 4\n3 4\n4 5\n3 5\n1 5	2	2	1	6
513	42	bezposredni	2 1\n1 2\n1 2	1	-1	0	4
514	42	brak	3 2\n1 2\n2 3\n1 3	1	0	0	4
515	42	rozlaczny	4 2\n1 2\n3 4\n1 4	-1	-1	1	4
516	42	ten_sam	NULL	(ukryty – OK)	(ukryty – OK)	1	4
517	43	przyklad	48 18	6\n4	18\n18\n48	0	6
518	43	b_zero	5 0	5\n1	0\n0\n5	0	7
519	43	rowne	7 7	7\n2	7\n7\n7	0	6
520	43	wzglednie_pierw	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	8
521	43	duze	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	3005
522	43	przyklad	48 18	6\n4	18\n18\n48	0	7
523	43	b_zero	5 0	5\n1	0\n0\n5	0	5
524	43	rowne	7 7	7\n2	7\n7\n7	0	12
525	43	wzglednie_pierw	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	7
526	43	duze	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	3017
527	44	sqrt2	2	1.414214	0\n0\n0\n0 0 0 0	0	5
528	44	sqrt9	9	3.000000	0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0 0 0 0 0 0 0 0 0 0 0	0	6
529	44	sqrt1	1	1.000000	0\n0\n0 0 0	0	6
530	44	sqrt100	100	10.000000	0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	0	12
531	44	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	9
532	44	sqrt2	2	1.414214	0\n0\n0\n0 0 0 0	0	7
533	44	sqrt9	9	3.000000	0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0 0 0 0 0 0 0 0 0 0 0	0	5
534	44	sqrt1	1	1.000000	0\n0\n0 0 0	0	6
535	44	sqrt100	100	10.000000	0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	0	10
536	44	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	6
537	45	sqrt2	2	1.414214	0	0	6
538	45	sqrt9	9	3.000000	0	0	5
539	45	sqrt1	1	1.000000	0	0	5
540	45	sqrt100	100	10.000000	0	0	4
541	45	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	5
542	45	sqrt2	2	1.414214	0	0	4
543	45	sqrt9	9	3.000000	0	0	5
544	45	sqrt1	1	1.000000	0	0	6
545	45	sqrt100	100	10.000000	0	0	7
546	45	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	7
547	46	sqrt2	2	1.414214	0	0	7
548	46	sqrt9	9	3.000000	0	0	10
549	46	sqrt1	1	1.000000	0	0	11
550	46	sqrt100	100	10.000000	0	0	8
551	46	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	7
552	46	sqrt2	2	1.414214	0	0	9
553	46	sqrt9	9	3.000000	0	0	7
554	46	sqrt1	1	1.000000	0	0	8
555	46	sqrt100	100	10.000000	0	0	5
556	46	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	5
557	47	sqrt2	2	1.414214	0	0	7
558	47	sqrt9	9	3.000000	0	0	6
559	47	sqrt1	1	1.000000	0	0	12
560	47	sqrt100	100	10.000000	0	0	10
561	47	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	9
562	47	sqrt2	2	1.414214	0	0	7
563	47	sqrt9	9	3.000000	0	0	6
564	47	sqrt1	1	1.000000	0	0	6
565	47	sqrt100	100	10.000000	0	0	8
566	47	sqrt2_5	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	6
567	48	jeden_elem_ok	1\n5\n5	0	0	1	4
568	48	jeden_elem_brak	1\n5\n3	-1	-1	1	5
569	48	siedem_elem	7\n1 3 5 7 9 11 13\n7	3	3	1	6
570	48	brak_w_tablicy	NULL	(ukryty – OK)	(ukryty – OK)	1	5
571	48	ostatni_elem	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	3016
572	49	jeden_elem_ok	1\n5\n5	0	0	1	5
573	49	jeden_elem_brak	1\n5\n3	-1	-1	1	4
574	49	siedem_elem	7\n1 3 5 7 9 11 13\n7	3	3	1	4
575	49	brak_w_tablicy	NULL	(ukryty – OK)	(ukryty – OK)	1	4
576	49	ostatni_elem	NULL	(ukryty – BŁĄD)	(ukryty – BŁĄD)	0	5

=== DANE: quiz_questions ===
id	category	question	answer_full	opt_a	opt_b	opt_c	opt_d	correct	is_active	created_at
1	Protokoły sieciowe	Do czego służy protokół HTTP?	HTTP (Hypertext Transfer Protocol) – protokół przesyłania stron internetowych.	Automatyczne przydzielanie adresów IP	Szyfrowane przesyłanie plików	Przesyłanie stron internetowych między przeglądarką a serwerem	Zdalny dostęp do komputera	2	1	2026-03-15 16:08:10
2	Protokoły sieciowe	Co to jest FTP i do czego służy?	FTP (File Transfer Protocol) – protokół służący do przesyłania plików między klientem a serwerem.	Tłumaczenie nazw domenowych na adresy IP	Przesyłanie plików między klientem a serwerem	Zarządzanie urządzeniami sieciowymi	Synchronizacja czasu systemowego	1	1	2026-03-15 16:08:10
3	Protokoły sieciowe	Czym HTTPS różni się od HTTP?	HTTPS to zabezpieczona wersja HTTP, wykorzystuje SSL/TLS do szyfrowania danych.	HTTPS działa wyłącznie w sieciach lokalnych	HTTPS jest wolniejszy, ale bardziej niezawodny	HTTPS używa innego portu i innego formatu pakietów	HTTPS szyfruje dane za pomocą SSL/TLS w odróżnieniu od HTTP	3	1	2026-03-15 16:08:10
4	Protokoły sieciowe	Co umożliwia technologia VoIP?	VoIP (Voice over Internet Protocol) umożliwia przesyłanie głosu przez Internet.	Szyfrowanie połączeń w sieci lokalnej	Prowadzenie rozmów głosowych przez Internet	Zdalny dostęp do plików na serwerze	Zarządzanie ruchem sieciowym	1	1	2026-03-15 16:08:10
5	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	TELNET przesyła dane (w tym hasła) w niezabezpieczonej formie tekstowej.	Przesyła dane w niezaszyfrowanej formie tekstowej	Działa tylko w sieciach IPv6	Nie obsługuje połączeń zdalnych	Wymaga instalacji dodatkowego sprzętu	0	1	2026-03-15 16:08:10
6	Protokoły sieciowe	W czym SSH jest lepszy od TELNET?	SSH (Secure Shell) używa szyfrowania danych, w przeciwieństwie do TELNET.	SSH jest szybszy i obsługuje więcej urządzeń	SSH działa tylko lokalnie, TELNET przez Internet	SSH nie wymaga uwierzytelniania	SSH szyfruje dane – TELNET przesyła je jako czysty tekst	3	1	2026-03-15 16:08:10
7	Protokoły sieciowe	Co robi protokół DHCP?	DHCP automatycznie przydziela adresy IP oraz inne parametry sieciowe urządzeniom.	Tłumaczy nazwy domen na adresy IP	Szyfruje połączenia w sieci lokalnej	Automatycznie przydziela adresy IP urządzeniom w sieci	Zarządza trasowaniem pakietów między sieciami	2	1	2026-03-15 16:08:10
8	Protokoły sieciowe	Za co odpowiada system DNS?	DNS (Domain Name System) tłumaczy nazwy domenowe na adresy IP.	Tłumaczy nazwy domenowe na adresy IP	Przydziela adresy IP w sieciach lokalnych	Zarządza bezpieczeństwem połączeń	Monitoruje ruch sieciowy	0	1	2026-03-15 16:08:10
9	Protokoły sieciowe	Co to jest NAT i po co się go używa?	NAT (Network Address Translation) mapuje wiele prywatnych adresów IP na jeden publiczny.	Metoda kompresji pakietów sieciowych	Protokół do szyfrowania transmisji danych	System synchronizacji zegarów sieciowych	Mapowanie wielu prywatnych IP na jeden publiczny	3	1	2026-03-15 16:08:10
10	Protokoły sieciowe	Do czego służy protokół SNMP?	SNMP (Simple Network Management Protocol) służy do zarządzania i monitorowania urządzeń sieciowych.	Przesyłanie poczty elektronicznej	Zarządzanie i monitorowanie urządzeń sieciowych	Szyfrowanie ruchu w sieci WAN	Synchronizacja czasu na urządzeniach sieciowych	1	1	2026-03-15 16:08:10
11	Protokoły sieciowe	Do czego służy protokół NTP?	NTP (Network Time Protocol) służy do synchronizacji czasu systemowego.	Przesyłania plików w sieci lokalnej	Synchronizacji czasu systemowego w sieci	Zarządzania adresami IP	Monitorowania przepustowości łącza	1	1	2026-03-15 16:08:10
12	Protokoły sieciowe	Jaka jest rola protokołu SMTP?	SMTP (Simple Mail Transfer Protocol) jest używany do wysyłania poczty elektronicznej.	Pobieranie poczty na urządzenie klienta	Zarządzanie skrzynką na wielu urządzeniach jednocześnie	Wysyłanie poczty elektronicznej między serwerami	Szyfrowanie wiadomości e-mail	2	1	2026-03-15 16:08:10
13	Protokoły sieciowe	Czym POP3 różni się od IMAP?	POP3 pobiera pocztę na urządzenie i usuwa ją z serwera. IMAP synchronizuje skrzynkę na wielu urządzeniach.	POP3 szyfruje pocztę, IMAP nie	POP3 pobiera i usuwa pocztę z serwera; IMAP synchronizuje ją na wielu urządzeniach	POP3 obsługuje tylko tekst, IMAP też załączniki	Oba protokoły działają identycznie	1	1	2026-03-15 16:08:10
14	Protokoły sieciowe	Czym jest protokół SSL?	SSL (Secure Sockets Layer) to protokół kryptograficzny zapewniający bezpieczne połączenia.	Protokół kryptograficzny szyfrujący dane między klientem a serwerem	Protokół do przesyłania plików multimedialnych	Protokół zarządzania adresami w sieci	System nazw domenowych	0	1	2026-03-15 16:08:10
15	Protokoły sieciowe	Jaka jest relacja między TLS a SSL?	TLS (Transport Layer Security) jest następcą SSL, zapewnia nowocześniejsze szyfrowanie.	TLS i SSL to dwie niezależne i równoważne technologie	TLS jest starszy i mniej bezpieczny niż SSL	TLS działa tylko w sieciach IPv6	TLS jest następcą SSL i zapewnia nowocześniejsze szyfrowanie	3	1	2026-03-15 16:08:10
16	Protokoły sieciowe	Do czego służy VPN?	VPN (Virtual Private Network) tworzy bezpieczny szyfrowany tunel przez Internet.	Przyspiesza pobieranie plików z Internetu	Zarządza domenami i adresami IP	Tworzy bezpieczny tunel przez Internet do sieci prywatnych	Monitoruje ruch w sieci lokalnej	2	1	2026-03-15 16:08:10
17	Protokoły sieciowe	Czym jest serwer Proxy?	Serwer Proxy działa jako pośrednik między klientem a serwerem, służy do filtrowania ruchu.	Pośrednik między klientem a serwerem filtrujący ruch	Urządzenie przydzielające adresy IP	System szyfrowania połączeń	Protokół do zdalnego zarządzania	0	1	2026-03-15 16:08:10
18	Protokoły sieciowe	Czym jest TCP/IP?	TCP/IP to zestaw protokołów stanowiący podstawę internetu. TCP dzieli dane na pakiety, IP adresuje je.	Jeden protokół do szyfrowania połączeń	Zestaw protokołów stanowiący podstawę internetu – TCP pakietuje dane, IP adresuje je	System nazw domenowych	Protokół zarządzania urządzeniami sieciowymi	1	1	2026-03-15 16:08:10
19	Licencje i prawo IT	Co gwarantuje licencja GNU GPL?	GNU GPL pozwala uruchamiać, modyfikować i dystrybuować oprogramowanie; zmiany muszą być na tej samej licencji.	Dowolne użycie bez obowiązku udostępniania zmian	Bezpłatne użycie tylko do celów osobistych	Uruchamianie, modyfikowanie i dystrybucję – zmiany muszą być na tej samej licencji	Używanie kodu tylko w projektach komercyjnych	2	1	2026-03-15 16:08:10
20	Licencje i prawo IT	Co to jest Adware?	Adware to darmowe oprogramowanie wyświetlające reklamy.	Złośliwe oprogramowanie blokujące pliki	Oprogramowanie wymagające subskrypcjiOprogramowanie szyfrujące dysk	Darmowe oprogramowanie finansowane przez wyświetlanie reklam	3	1	2026-03-15 16:08:10
21	Licencje i prawo IT	Co to jest Shareware?	Shareware to oprogramowanie dostępne bezpłatnie przez ograniczony czas lub z ograniczoną funkcjonalnością.	Oprogramowanie dostępne bezpłatnie przez ograniczony czas lub z ograniczoną funkcją	Oprogramowanie całkowicie darmowe na zawsze	Oprogramowanie open source z dostępem do kodu	Oprogramowanie wymagające opłaty miesięcznej	0	1	2026-03-15 16:08:10
22	Licencje i prawo IT	Czym jest Freeware?	Freeware to oprogramowanie całkowicie darmowe do użytku, bez możliwości modyfikacji.	Oprogramowanie na licencji GPL	Darmowe oprogramowanie, którego nie wolno modyfikować ani redystrybuować zmienionej wersji	Oprogramowanie open source z kodem źródłowym	Oprogramowanie dostępne przez 30-dniowy trial	1	1	2026-03-15 16:08:10
23	Licencje i prawo IT	Co charakteryzuje licencję MIT?	Licencja MIT jest bardzo liberalna – pozwala na dowolne użycie z zachowaniem informacji o autorze.	Wymaga udostępnienia kodu pochodnego na tej samej licencji	Dozwolona tylko do użytku niekomercyjnego	Zabrania dystrybucji bez zgody właściciela	Pozwala na dowolne użycie z zachowaniem informacji o autorze	3	1	2026-03-15 16:08:10
24	Licencje i prawo IT	Co to jest licencja LGPL?	LGPL pozwala na linkowanie do bibliotek bez konieczności udostępniania całego kodu na tej samej licencji.	Licencja zabraniająca komercyjnego użycia bibliotek	Pozwala linkować biblioteki bez wymogu udostępniania całego kodu na tej samej licencji	Wymaga pełnego open source całej aplikacji	Jest identyczna z GPL	1	1	2026-03-15 16:08:10
25	Licencje i prawo IT	Co to jest Proprietary License?	Licencja zastrzeżona zabrania kopiowania, modyfikowania lub dystrybucji bez zgody właściciela.	Licencja pozwalająca na dowolne modyfikacje	Licencja wymagająca publikacji kodu źródłowego	Licencja zastrzegająca wyłączne prawa właściciela – zakaz kopii i modyfikacji bez zgody	Licencja do użytku wyłącznie edukacyjnego	2	1	2026-03-15 16:08:10
26	Licencje i prawo IT	Czym jest licencja subskrypcyjna?	Model subskrypcyjny umożliwia korzystanie z oprogramowania w zamian za regularne opłaty.	Jednorazowy zakup oprogramowania na zawsze	Bezpłatne oprogramowanie finansowane reklamami	Licencja tylko dla instytucji edukacyjnych	Regularne opłaty za dostęp do oprogramowania i aktualizacji	3	12026-03-15 16:08:10
27	Licencje i prawo IT	Co to są licencje Creative Commons?	CC to zestaw licencji umożliwiających twórcom udostępnianie prac na określonych zasadach.	Licencje wyłącznie dla oprogramowania komercyjnego	Zestaw licencji do udostępniania prac twórczych na określonych zasadach	Protokół szyfrowania komunikacji	System zarządzania prawami autorskimi w UE	11	2026-03-15 16:08:10
28	Licencje i prawo IT	Kiedy powstaje ochrona praw autorskich?	Prawa autorskie chronią twórcę automatycznie od momentu stworzenia dzieła, bez żadnych formalności.	Po opublikowaniu w Internecie	Po zarejestrowaniu w urzędzie patentowym	Po upływie 70 lat od powstania	Automatycznie od momentu stworzenia dzieła – bez żadnych formalności	3	1	2026-03-15 16:08:10
29	Licencje i prawo IT	Na czym polega Prawo Cytatu?	Prawo Cytatu pozwala używać fragmentów treści chronionej w celach edukacji lub krytyki z podaniem autora.	Prawo do kopiowania całych dzieł w celach edukacyjnych	Prawo do używania fragmentów chronionej treści z podaniem autora i źródła	Prawo autora do wycofania dzieła z obiegu	Prawo do tłumaczenia dzieła bez zgody autora	1	1	2026-03-15 16:08:10
30	Licencje i prawo IT	Do czego służą Cookies (ciasteczka)?	Cookies to małe pliki tekstowe zapisywane przez strony WWW zapamiętujące preferencje i stan sesji.	Pliki złośliwego oprogramowania pobierane automatycznie	Protokół szyfrowania danych w przeglądarkach	Mechanizm blokowania reklam w przeglądarce	Małe pliki tekstowe zapamiętujące preferencje i stan sesji na stronach WWW	3	1	2026-03-15 16:08:10
31	Języki programowania	Co to jest język programowania?	Język programowania to formalny język z instrukcjami do tworzenia oprogramowania.	Formalny język z instrukcjami do tworzenia oprogramowania	Naturalny język do komunikacji z użytkownikiem	Protokół sieciowy do przesyłania kodu	System operacyjny do uruchamiania programów	0	1	2026-03-15 16:08:10
32	Języki programowania	Co to jest Python i gdzie się go stosuje?	Python to wysokopoziomowy język stosowany w Data Science, AI, automatyzacji oraz web developmencie.	Język niskopoziomowy do programowania układów FPGA	Język wyłącznie do tworzenia aplikacji mobilnych	Wysokopoziomowy język do AI, Data Science, automatyzacji i web developmentu	Język dedykowany systemom iOS i macOS	2	1	2026-03-15 16:08:10
33	Języki programowania	Do czego służy JavaScript?	JavaScript to język używany w web developmencie (front-end i back-end), aplikacjach mobilnych oraz serwerach.	Tworzenie sterowników i systemów operacyjnych	Web development (front-end i back-end), aplikacje mobilne i serwerowe	Projektowanie układów cyfrowych FPGA	Programowanie systemów wbudowanych	1	12026-03-15 16:08:10
34	Języki programowania	Do czego używa się języka Java?	Java to język do aplikacji webowych, mobilnych (Android), systemów wbudowanych i serwerowych.	Wyłącznie do gier komputerowych	Programowanie GPU i obliczeń równoległych	Tworzenie aplikacji wyłącznie na iOS	Aplikacje webowe, mobilne (Android), systemy wbudowane i serwerowe	3	1	2026-03-15 16:08:10
35	Języki programowania	Do czego stosuje się C#?	C# to język do aplikacji desktopowych, webowych, gier (Unity) oraz aplikacji mobilnych.	Aplikacje desktopowe, webowe, gry (Unity) i mobilne	Wyłącznie do aplikacji serwerowych Linux	Programowanie mikrokontrolerów Arduino	Projektowanie układów ASIC	0	1	2026-03-15 16:08:10
36	Języki programowania	Gdzie najczęściej stosuje się PHP?	PHP to język do tworzenia stron WWW, systemów CMS i aplikacji serwerowych.	Tworzenie gier 3D i silników graficznych	Strony WWW, systemy CMS i aplikacje serwerowe	Programowanie sterowników urządzeń	Aplikacje na systemy iOS i macOS	1	1	2026-03-15 16:08:10
37	Języki programowania	Co to jest Swift i gdzie się go używa?	Swift to język stworzony przez Apple, przeznaczony do tworzenia aplikacji na iOS i macOS.	Język do programowania aplikacji Android	Język do data science i analizy danych	Język Apple do tworzenia aplikacji na iOS i macOS	Język skryptowy do automatyzacji Windows	2	1	2026-03-15 16:08:10
38	Języki programowania	Czym jest SQL jako język?	SQL (Structured Query Language) to specjalistyczny język służący do zarządzania relacyjnymi bazami danych.	Język ogólnego przeznaczenia do aplikacji webowych	Język niskopoziomowy do programowania systemowego	Język skryptowy do automatyzacji zadań	Język specjalistyczny do zarządzania relacyjnymi bazami danych	3	1	2026-03-15 16:08:10
39	Języki programowania	Czym charakteryzują się języki wysokopoziomowe?	Języki wysokopoziomowe mają wysoką abstrakcję od sprzętu, zbliżone do języka naturalnego.	Dają bezpośrednią kontrolę nad sprzętem bez abstrakcji	Wymagają ręcznego zarządzania pamięcią	Są zbliżone do języka naturalnego, łatwe w nauce, mają bogate biblioteki	Działają tylko na jednej platformie	2	1	2026-03-15 16:08:10
40	Języki programowania	Co charakteryzuje języki średniopoziomowe?	Języki średniopoziomowe łączą cechy wysokiego i niskiego poziomu. Przykłady: C, C++, Rust.	Są identyczne z językami wysokopoziomowymi	Działają wyłącznie na systemach wbudowanych	Nie mogą być kompilowane	Łączą kontrolę nad sprzętem z pewną abstrakcją – np. C, C++, Rust	3	12026-03-15 16:08:10
41	Języki programowania	Czym są języki niskopoziomowe?	Języki niskopoziomowe mają minimalną abstrakcję i są bliskie kodowi maszynowemu. Przykład: Assembly.	Języki zbliżone do języka naturalnego	Języki bliskie kodowi maszynowemu z maksymalną kontrolą nad sprzętem – np. Assembly	Języki wyłącznie do baz danych	Języki interpretowane działające w przeglądarce	1	12026-03-15 16:08:10
42	Języki programowania	Co to jest TypeScript?	TypeScript to typowana wersja JavaScriptu używana w zaawansowanym web developmencie.	Nowy język do tworzenia aplikacji mobilnych	Język do tworzenia baz danych	Typowana wersja JavaScript do zaawansowanego web developmentu	Asembler dla procesorów ARM	2	1	2026-03-15 16:08:10
43	Języki programowania	Do czego służy Rust?	Rust to język do systemów operacyjnych, oprogramowania wbudowanego i aplikacji wymagających wydajności.	Systemy operacyjne, oprogramowanie wbudowane, aplikacje o wysokiej wydajności	Tworzenie stron internetowych i aplikacji webowych	Wyłącznie aplikacje mobilne Android	Data Science i analiza statystyczna	0	12026-03-15 16:08:10
44	Kompilacja i wykonanie	Co to jest kod źródłowy?	Kod źródłowy to tekst programu napisany przez programistę przed kompilacją.	Kod maszynowy wykonywany przez procesor	Skompilowany plik wykonywalny .exe	Zestaw instrukcji asemblerowych	Tekst programu napisany przez programistę przed kompilacją	3	1	2026-03-15 16:08:10
45	Kompilacja i wykonanie	Na czym polega kompilacja?	Kompilacja to proces tłumaczenia kodu źródłowego na kod maszynowy.	Tłumaczenie kodu w czasie rzeczywistym bez generowania pliku	Debugowanie i testowanie programu	Tłumaczenie kodu źródłowego na kod maszynowy – powstaje plik wykonywalny	Łączenie modułów i bibliotek w finalny plik	2	1	2026-03-15 16:08:10
46	Kompilacja i wykonanie	Czym różni się interpretacja od kompilacji?	Interpretacja polega na tłumaczeniu i wykonywaniu kodu w czasie rzeczywistym bez pliku wykonywalnego.	Interpretacja tworzy plik .exe, kompilacja nie	Oba procesy są identyczne	Interpretacja wykonuje kod na bieżąco bez pliku wykonywalnego; kompilacja tworzy plik	Interpretacja działa tylko na serwerach	2	1	2026-03-15 16:08:10
47	Kompilacja i wykonanie	Co robi Linker?	Linker to narzędzie łączące skompilowane moduły i biblioteki w finalny plik wykonywalny.	Kompiluje kod źródłowy na kod asemblerowy	Łączy skompilowane moduły i biblioteki w finalny plik wykonywalny	Debuguje błędy w kodzie źródłowym	Uruchamia program w środowisku wirtualnym	1	1	2026-03-15 16:08:10
48	Kompilacja i wykonanie	Na czym polega cykl pobierania-dekodowania-wykonania?	To podstawowy proces procesora: pobiera instrukcję z pamięci, dekoduje ją, a następnie wykonuje.	Metoda zarządzania pamięcią podręczną	Podstawowy cykl procesora: pobierz instrukcję → zdekoduj → wykonaj	Protokół komunikacji między rdzeniami procesora	Proces kompilacji kodu do pliku wykonywalnego	1	1	2026-03-15 16:08:10
49	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	TCP jest połączeniowy i gwarantuje dostarczenie danych. UDP jest bezpołączeniowy i szybszy.	TCP i UDP działają identycznie	UDP gwarantuje dostarczenie; TCP nie	TCP działa w warstwie fizycznej	TCP gwarantuje dostarczenie (połączeniowy); UDP nie gwarantuje	3	1	2026-03-15 16:08:10
50	Sieci komputerowe	Do której warstwy modelu OSI należy HTTP?	HTTP to warstwa 7 – aplikacji. Inne: HTTPS, FTP, SMTP, DNS.	Warstwa 4 – transportowa	Warstwa 7 – aplikacji	Warstwa 3 – sieciowa	Warstwa 2 – łącza danych	1	1	2026-03-15 16:08:10
51	Sieci komputerowe	Co to jest adres MAC?	Unikalny 48-bitowy identyfikator sprzętowy karty sieciowej. Działa w warstwie 2 OSI.	Adres logiczny przydzielany przez DHCP	Unikalny identyfikator sprzętowy karty sieciowej (warstwa 2)	Nazwa hosta w sieci lokalnej	Identyfikator sesji TCP	1	1	2026-03-15 16:08:10
52	Sieci komputerowe	Co to jest LAN?	LAN (Local Area Network) to sieć łącząca urządzenia na ograniczonym obszarze.	Sieć obejmująca cały kraj lub kontynent	Sieć łącząca miasta w kraju	Bezprzewodowa sieć rozległa	Sieć lokalna łącząca urządzenia na ograniczonym obszarze np. biuro	3	1	2026-03-15 16:08:10
53	Sieci komputerowe	Co to jest MAN?	MAN (Metropolitan Area Network) łączy wiele sieci LAN na obszarze miasta lub kampusu.	Sieć łącząca sieci LAN w obszarze miasta lub kampusu	Sieć lokalna w jednym budynku	Sieć globalna łącząca kontynenty	Bezprzewodowa sieć w zasięgu Bluetooth	0	1	2026-03-15 16:08:10
54	Sieci komputerowe	Do czego służy Router?	Router łączy różne sieci i kieruje ruchem między nimi na podstawie adresów IP.	Rozgłasza dane do wszystkich portów jednocześnie	Przydziela adresy IP w sieci	Łączy urządzenia w jednej sieci lokalnej na podstawie MAC	Łączy różne sieci i kieruje ruchem na podstawie adresów IP	3	1	2026-03-15 16:08:10
55	Sieci komputerowe	Czym się różni Switch od Hub?	Switch inteligentnie kieruje pakiety do właściwych portów na podstawie MAC. Hub rozsyła do wszystkich.	Switch kieruje dane do właściwego portu (MAC); Hub rozsyła do wszystkich portów	Switch jest wolniejszy, Hub szybszy	Oba działają identycznie	Switch działa w warstwie IP, Hub w warstwie fizycznej01	2026-03-15 16:08:10
56	Sieci komputerowe	Co to jest Firewall?	Firewall to zabezpieczenie kontrolujące ruch sieciowy i chroniące przed nieautoryzowanym dostępem.	Protokół szyfrowania połączeń VPN	Serwer zarządzający adresami IP	Urządzenie wzmacniające sygnał Wi-Fi	Zabezpieczenie kontrolujące ruch sieciowy i chroniące przed nieautoryzowanym dostępem	3	1	2026-03-15 16:08:10
57	Sieci komputerowe	Co to jest Ethernet?	Ethernet to technologia do tworzenia przewodowych połączeń w lokalnych sieciach komputerowych.	Bezprzewodowa technologia sieciowa	Protokół szyfrowania danych w sieci	Technologia przewodowych połączeń w sieciach lokalnych	System zarządzania adresami IP	2	1	2026-03-15 16:08:10
58	Sieci komputerowe	Czym jest Wi-Fi?	Wi-Fi to technologia umożliwiająca bezprzewodowe łączenie urządzeń z siecią.	Przewodowa technologia sieciowa standardu LAN	Protokół szyfrowania transmisji bezprzewodowej	System adresowania urządzeń w sieci	Technologia bezprzewodowego łączenia urządzeń z siecią	3	1	2026-03-15 16:08:10
59	Bezpieczeństwo IT	Co to jest Malware?	Malware (złośliwe oprogramowanie) to zbiorcza nazwa programów do atakowania systemów i kradzieży danych.	Legalne oprogramowanie antywirusowe	Zbiorcza nazwa złośliwych programów do atakowania systemów i kradzieży danych	Protokół zabezpieczeń sieciowych	System kopii zapasowych	1	1	2026-03-15 16:08:10
60	Bezpieczeństwo IT	Czym charakteryzują się wirusy komputerowe?	Wirusy dołączają się do plików i aktywują się po uruchomieniu, wymagają interakcji użytkownika.	Replikują się automatycznie przez sieć bez interakcji użytkownika	Szyfrują pliki i żądają okupu	Dołączają się do plików i aktywują po uruchomieniu – wymagają interakcji użytkownika	Służą do wyświetlania reklam	2	1	2026-03-15 16:08:10
61	Bezpieczeństwo IT	Jak robaki (Worms) różnią się od wirusów?	Robaki replikują się automatycznie przez sieć bez interakcji użytkownika, bez dołączania do plików.	Robaki i wirusy to to samo	Robaki replikują się automatycznie przez sieć bez interakcji użytkownika	Robaki tylko szyfrują pliki	Robaki wymagają uruchomienia pliku przez użytkownika	11	2026-03-15 16:08:10
62	Bezpieczeństwo IT	Co to jest Trojan (Trojan Horse)?	Trojan to oprogramowanie udające przydatną aplikację, które kradnie dane lub pozwala na zdalne przejęcie kontroli.	Wirus replikujący się przez e-mail	Program wyświetlający reklamy	Oprogramowanie szyfrujące pliki i żądające okupu	Oprogramowanie udające przydatną aplikację umożliwiające zdalne przejęcie kontroli	3	1	2026-03-15 16:08:10
63	Bezpieczeństwo IT	Co to jest Ransomware?	Ransomware blokuje dostęp do plików lub systemu i żąda okupu za ich odblokowanie.	Oprogramowanie szpiegujące aktywność użytkownika	Wirus sieciowy replikujący się automatycznie	Program wyświetlający niechciane reklamy	Złośliwe oprogramowanie blokujące pliki i żądające okupu	3	1	2026-03-15 16:08:10
64	Bezpieczeństwo IT	Do czego służy Spyware?	Spyware szpieguje aktywność użytkownika bez jego wiedzy, zbierając dane osobiste i informacje logowania.	Blokuje dostęp do systemu i żąda okupu	Replikuje się przez sieć atakując serwery	Wyświetla niechciane reklamy w przeglądarce	Szpieguje aktywność użytkownika i zbiera dane osobiste bez jego wiedzy3	1	2026-03-15 16:08:10
65	Bezpieczeństwo IT	Co to jest Rootkit?	Rootkit to trudne do wykrycia oprogramowanie maskujące swoją obecność, dające atakującemu pełną kontrolę.	Narzędzie do monitorowania ruchu sieciowego	Protokół szyfrowania dysku twardego	Oprogramowanie maskujące się w systemie i dające atakującemu pełną kontrolę	Program antywirusowy do usuwania wirusów	21	2026-03-15 16:08:10
66	Bezpieczeństwo IT	Co to jest Keylogger?	Keylogger to program monitorujący i zapisujący naciśnięcia klawiszy, służy do kradzieży haseł.	Oprogramowanie optymalizujące klawiaturę	Program zapisujący naciśnięcia klawiszy w celu kradzieży haseł i danych	Sterownik do obsługi klawiatury bezprzewodowej	Narzędzie do makr klawiszowych	1	1	2026-03-15 16:08:10
67	Bezpieczeństwo IT	Czym Adware różni się od zwykłego Malware?	Adware wyświetla reklamy i może prowadzić do dalszych infekcji; nie kradnie bezpośrednio danych.	Adware i Malware to synonimy	Adware jest bezpieczne i nie stanowi zagrożenia	Adware działa tylko na serwerach	Adware wyświetla reklamy i może prowadzić do dalszych infekcji; nie kradnie bezpośrednio danych	3	1	2026-03-15 16:08:10
68	Algorytmy	Czym jest algorytm?	Algorytm to skończony, jednoznaczny ciąg kroków prowadzących do rozwiązania problemu.	Program napisany w dowolnym języku programowania	Skończony, jednoznaczny ciąg kroków prowadzących do rozwiązania problemu	Dowolna procedura matematyczna	Schemat blokowy zapisany w pamięci komputera	1	1	2026-03-15 16:08:10
69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	Insertion sort buduje posortowaną tablicę element po elemencie, wstawiając każdy nowy element na właściwe miejsce.	Dzieli tablicę na pół i sortuje każdą połowę osobno	Wybiera zawsze najmniejszy element i zamienia z pierwszym niesortowanym	Buduje posortowaną tablicę element po elemencie, wstawiając każdy na właściwe miejsce	Używa kolejki priorytetowej do kolejkowania elementów	2	1	2026-03-15 16:08:10
70	Algorytmy	Co to jest rekurencja?	Rekurencja to technika, w której funkcja wywołuje samą siebie z uproszczonym problemem, aż do osiągnięcia przypadku bazowego.	Pętla iteracyjna wykonująca ten sam kod wielokrotnie	Technika, w której funkcja wywołuje samą siebie z uproszczonym problemem	Metoda optymalizacji algorytmów sortowania	Rodzaj struktury danych w języku C++	1	1	2026-03-15 16:08:10
71	Algorytmy	Czym różni się BFS od DFS w grafach?	BFS (przeszukiwanie wszerz) używa kolejki i przegląda warstwami. DFS (wgłąb) używa stosu i idzie jak najgłębiej.	BFS i DFS zawsze dają te same wyniki	BFS działa tylko na grafach skierowanych, DFS tylko na nieskierowanych	BFS zawsze jest szybszy od DFS	BFS używa kolejki i przegląda warstwami; DFS używa stosu i idzie jak najgłębiej	3	1	2026-03-15 16:08:10
72	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	Wyszukiwanie binarne w O(log n) znajduje element w POSORTOWANEJ tablicy, dzieląc zakres wyszukiwania na pół.	Do sortowania tablicy w czasie O(n log n)	Do wyszukiwania wzorca w tekście	Do szybkiego wyszukiwania w posortowanej tablicy w czasie O(log n)	Do znajdowania najkrótszej ścieżki w grafie	2	1	2026-03-15 16:08:10
73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	Algorytm Euklidesa oblicza NWD(a,b): jeśli b=0 zwraca a, w przeciwnym razie zwraca NWD(b, a mod b).	Oblicza silnię liczby metodą rekurencyjną	Wyznacza liczby pierwsze metodą sita	Oblicza NWD(a,b): jeśli b=0 zwróć a, inaczej NWD(b, a mod b)	Sortuje liczby całkowite od najmniejszej do największej	2	1	2026-03-15 16:08:10
74	Algorytmy	Co to jest programowanie dynamiczne?	Programowanie dynamiczne rozwiązuje problem rozkładając go na podproblemy i zapamiętując (memoizacja) wyniki.	Technika pisania kodu bez użycia pętli	Metoda dynamicznego przydzielania pamięci w trakcie działania programu	Algorytm do sortowania dużych zbiorów danych	Technika rozkładania problemu na podproblemy i zapamiętywania wyników (memoizacja)	3	1	2026-03-15 16:08:10
75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	Algorytm zachłanny w każdym kroku wybiera lokalnie optymalną decyzję, licząc że prowadzi do globalnego optimum.	Algorytm przeszukujący wszystkie możliwe rozwiązania metodą brute force	Algorytm zawsze dający optymalne rozwiązanie dla dowolnego problemu	W każdym kroku wybiera lokalnie optymalną decyzję licząc na globalne optimum	Technika podziału problemu na dwie równe części	2	1	2026-03-15 16:08:10
76	Złożoność obliczeniowa	Co oznacza notacja O(n)?	O(n) to złożoność liniowa – czas wykonania rośnie proporcjonalnie do rozmiaru danych wejściowych.	Czas wykonania jest stały i niezależny od danych	Czas wykonania rośnie kwadratowo wraz z rozmiarem danych	Czas wykonania rośnie proporcjonalnie do rozmiaru danych (złożoność liniowa)	Czas wykonania rośnie logarytmicznie	2	1	2026-03-15 16:08:10
77	Złożoność obliczeniowa	Jaka jest złożoność czasowa sortowania bąbelkowego (bubble sort)?	Bubble sort ma złożoność O(n²) w przypadku średnim i pesymistycznym.	O(n log n) w każdym przypadku	O(n) dla posortowanej tablicy, O(n²) dla odwrotnie posortowanej	O(n²) w przypadku średnim i pesymistycznym	O(log n) dla tablicy posortowanej	2	1	2026-03-15 16:08:10
78	Złożoność obliczeniowa	Jaka jest złożoność algorytmu merge sort?	Merge sort ma złożoność O(n log n) w każdym przypadku – pesymistycznym, średnim i optymistycznym.	O(n²) w pesymistycznym przypadku	O(n) dla posortowanej tablicy	O(n log n) w każdym przypadku – pesymistycznym, średnim i optymistycznym	O(log n) dla małych tablic	2	1	2026-03-15 16:08:10
79	Złożoność obliczeniowa	Co oznacza złożoność O(1)?	O(1) to złożoność stała – czas wykonania jest niezależny od rozmiaru danych wejściowych.	Czas wykonania rośnie z każdym elementem	Algorytm działa tylko dla jednego elementu	Złożoność stała – czas niezależny od rozmiaru danych	Czas wykonania równy liczbie elementów podzielonej przez 2	2	12026-03-15 16:08:10
80	Złożoność obliczeniowa	Dlaczego binary search ma złożoność O(log n)?	Binary search dzieli zakres wyszukiwania na pół w każdym kroku, więc potrzeba co najwyżej log₂(n) kroków.	Bo zawsze przeszukuje połowę tablicy niezależnie od danych	Bo implementacja używa rekurencji ogonowej	Bo działa tylko dla n będącego potęgą 2	Bo dzieli zakres wyszukiwania na pół w każdym kroku – potrzeba log₂(n) kroków	3	1	2026-03-15 16:08:10
81	Złożoność obliczeniowa	Jaka jest złożoność dostępu do elementu tablicy po indeksie?	Dostęp po indeksie to O(1) – komputer bezpośrednio oblicza adres w pamięci.	O(n) – trzeba przejść wszystkie elementy	O(log n) – używa wyszukiwania binarnego	O(1) – bezpośredni dostęp przez adres pamięci	O(n²) – zależy od rozmiaru tablicy kwadratowo	2	1	2026-03-15 16:08:10
82	Złożoność obliczeniowa	Co to jest złożoność pamięciowa algorytmu?	Złożoność pamięciowa opisuje ile dodatkowej pamięci algorytm potrzebuje w zależności od rozmiaru danych.	Liczba bitów potrzebnych do zapisania programu na dysku	Czas potrzebny do przydzielenia pamięci przez system operacyjny	Rozmiar danych wejściowych w bajtach	Ilość dodatkowej pamięci potrzebnej algorytmowi w zależności od rozmiaru danych	3	1	2026-03-15 16:08:10
83	Systemy liczbowe	Ile wynosi 1010₂ w systemie dziesiętnym?	1010₂ = 1×8 + 0×4 + 1×2 + 0×1 = 8 + 2 = 10₁₀	8	12	10	6	2	1	2026-03-15 16:08:10
84	Systemy liczbowe	Ile wynosi 255₁₀ w systemie szesnastkowym?	255₁₀ = 15×16 + 15 = FF₁₆	FE	FF	EF	100	1	1	2026-03-15 16:08:10
85	Systemy liczbowe	Ile cyfr używa system ósemkowy (oktalny)?	System ósemkowy używa cyfr 0–7 (osiem cyfr: 0, 1, 2, 3, 4, 5, 6, 7).	6 cyfr: 0–5	10 cyfr: 0–9	16 cyfr: 0–9 i A–F	8 cyfr: 0–7	3	1	2026-03-15 16:08:10
86	Systemy liczbowe	Jak przelicza się liczbę binarną na dziesiętną?	Mnożymy każdą cyfrę przez odpowiednią potęgę 2 (od prawej: 2⁰, 2¹, 2², ...) i sumujemy.	Dzielimy liczbę przez 2 wielokrotnie i czytamy reszty od dołu	Mnożymy każdą cyfrę przez odpowiednią potęgę 2 i sumujemy	Zamieniamy każde 4 bity na jedną cyfrę szesnastkową	Odczytujemy cyfrę po cyfrze i sumujemy	1	1	2026-03-15 16:08:10
87	Systemy liczbowe	Co to jest bit i co to jest bajt?	Bit to najmniejsza jednostka informacji (0 lub 1). Bajt = 8 bitów.	Bit to 8 cyfr binarnych; bajt to 1 cyfra binarna	Bit i bajt to to samo	Bit to 4 cyfry binarne; bajt to 2 bity	Bit to 0 lub 1 (najmniejsza jednostka); bajt = 8 bitów	3	1	2026-03-15 16:08:10
88	Systemy liczbowe	Ile wynosi A3₁₆ w systemie dziesiętnym?	A3₁₆ = 10×16 + 3 = 160 + 3 = 163₁₀	173	163	143	153	1	1	2026-03-15 16:08:10
89	Systemy liczbowe	Jak zapisujemy liczbę 13₁₀ w systemie binarnym?	13 = 8+4+1 = 1101₂	1110	1010	1100	1101	3	1	2026-03-15 16:08:10
90	Systemy liczbowe	Do czego służy system szesnastkowy (hex) w informatyce?	Hex jest zwięzłą reprezentacją danych binarnych – 1 cyfra hex = 4 bity. Używany m.in. do adresów pamięci i kolorów.	Do zapisywania dużych liczb dziesiętnych w mniejszej liczbie cyfr	Wyłącznie do zapisu adresów IPv6	Zwięzła reprezentacja danych binarnych: 1 cyfra hex = 4 bity; kolory, adresy pamięci	Do obliczeń zmiennoprzecinkowych w procesorze	2	1	2026-03-15 16:08:10
91	Bazy danych	Czym różni się DELETE od DROP?	DELETE usuwa wiersze (tabela istnieje). DROP TABLE usuwa całą tabelę.	DELETE usuwa tabelę; DROP usuwa wiersze	Są synonimami	DELETE działa na kolumnach	DELETE usuwa wiersze; DROP usuwa całą tabelę	3	1	2026-03-15 16:08:10
92	Bazy danych	Czym jest PRIMARY KEY?	PRIMARY KEY jednoznacznie identyfikuje rekord w tabeli – musi być unikalny i NOT NULL.	FK do innej tabeli	Indeks przyspieszający wyszukiwanie	Unikalny identyfikator rekordu (NOT NULL)	Pierwsza kolumna tabeli	2	1	2026-03-15 16:08:10
93	Bazy danych	Różnica między WHERE a HAVING?	WHERE filtruje wiersze PRZED GROUP BY. HAVING filtruje grupy PO GROUP BY.	Są synonimami	WHERE przed GROUP BY; HAVING po GROUP BY	HAVING szybsze od WHERE	WHERE na kolumnach; HAVING na wierszach	1	1	2026-03-15 16:08:10
94	Bazy danych	Co to jest indeks w bazie danych?	Indeks to struktura danych przyspieszająca wyszukiwanie rekordów (jak spis treści).	Unikalny ID wiersza	Kopia zapasowa tabeli	Ograniczenie NOT NULL	Struktura przyspieszająca wyszukiwanie	3	1	2026-03-15 16:08:10
95	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	FOREIGN KEY to kolumna wskazująca na PRIMARY KEY w innej tabeli, zapewniając integralność relacyjną.	Kolumna wskazująca na PRIMARY KEY w innej tabeli – zapewnia integralność relacyjną	Kolumna, której wartości nie mogą się powtarzać	Automatycznie generowany identyfikator rekordu	Indeks przyspieszający wyszukiwanie	0	1	2026-03-15 16:08:10
96	Bazy danych	Co to jest transakcja w bazie danych?	Transakcja to jednostka pracy w DB, która albo w całości się udaje (COMMIT) albo jest cofana (ROLLBACK).	Jednorazowe zapytanie SELECT do bazy danych	Przeniesienie danych między tabelami	Kopia zapasowa wybranej tabeli	Jednostka pracy albo w całości udana (COMMIT) albo cofnięta (ROLLBACK)	3	1	2026-03-15 16:08:10
97	Bazy danych	Co to jest JOIN w SQL?	JOIN łączy wiersze z dwóch lub więcej tabel na podstawie powiązanej kolumny.	Polecenie sortujące wyniki zapytania	Łączy wiersze z dwóch lub więcej tabel na podstawie powiązanej kolumny	Grupuje wiersze o identycznych wartościach	Usuwa duplikaty z wyników zapytania	1	1	2026-03-15 16:08:10
98	Bazy danych	Co robi polecenie GROUP BY?	GROUP BY grupuje wiersze z identyczną wartością w kolumnie do jednego wiersza podsumowania.	Sortuje wyniki według podanej kolumnyGrupuje wiersze o tej samej wartości w kolumnie do jednego podsumowania	Filtruje wyniki po warunku logicznym	Łączy dwie tabele w jedną	1	1	2026-03-15 16:08:10
99	Architektura komputera	Różnica RAM vs ROM?	RAM – ulotna, odczyt/zapis, traci dane po wyłączeniu. ROM – nieulotna, tylko odczyt, firmware/BIOS.	RAM nieulotna; ROM ulotna	RAM = BIOS; ROM = pamięć robocza	Oba to cache procesora	RAM ulotna RW; ROM nieulotna odczyt	3	1	2026-03-15 16:08:10
100	Architektura komputera	Co to jest ALU?	ALU (Arithmetic Logic Unit) – wykonuje operacje arytmetyczne (+,-,*,/) i logiczne (AND, OR, NOT, XOR).	Układ zarządzający cache	Jednostka arytmetyczno-logiczna procesora	Kontroler magistrali	Dekoder instrukcji	1	1	2026-03-15 16:08:10
101	Architektura komputera	Co to jest cache procesora?	Cache procesora to szybka pamięć podręczna (L1/L2/L3), która przechowuje często używane dane.	Szybka pamięć podręczna (L1/L2/L3)	Pamięć wirtualna na dysku	Bufor I/O	Pamięć BIOS	0	1	2026-03-15 16:08:10
102	Architektura komputera	Co to jest procesor wielordzeniowy?	Procesor wielordzeniowy zawiera dwa lub więcej niezależnych rdzeni obliczeniowych, co umożliwia równoległe przetwarzanie.	Procesor z bardzo dużą pamięcią cache	Procesor obsługujący wyłącznie wirtualizację	Jeden rdzeń obliczeniowy taktowany z dużą częstotliwością	Procesor z wieloma niezależnymi rdzeniami obliczeniowymi do równoległego przetwarzania	3	1	2026-03-15 16:08:10
103	Architektura komputera	Co to jest magistrala (bus) w komputerze?	Magistrala to zestaw linii komunikacyjnych przesyłających dane między komponentami komputera.	Pamięć podręczna procesora najwyższego poziomu	Zestaw linii komunikacyjnych przesyłających dane między komponentami	Protokół sieciowy do komunikacji w sieci LAN	Sterownik urządzeń wejścia/wyjścia	1	1	2026-03-15 16:08:10
104	Architektura komputera	Co to jest pamięć wirtualna?	Pamięć wirtualna rozszerza dostępną pamięć RAM używając przestrzeni dyskowej (swap/plik stronicowania).	Pamięć zainstalowana na karcie graficznej	Inna nazwa dla pamięci RAM	Rozszerzenie dostępnej pamięci RAM poprzez użycie przestrzeni dyskowej	Pamięć nieulotna przechowująca BIOS	2	1	2026-03-15 16:08:10
105	Prawo informatyczne	Co reguluje RODO?	RODO reguluje ochronę danych osobowych osób w UE. Zasady: minimalizacja, zgoda, prawo do bycia zapomnianym.	Handel elektroniczny	Tylko firmy IT w Polsce	Prawa autorskie	Ochrona danych osobowych w UE	3	1	2026-03-15 16:08:10
106	Prawo informatyczne	Co to jest licencja open source?	Licencja open source zezwala na używanie, modyfikację i dystrybucję z kodem źródłowym.	Freeware bez kodu	Shareware po 30 dniach	Public domain	Używanie + modyfikacja + dystrybucja z kodem	3	1	2026-03-15 16:08:10
107	Prawo informatyczne	Czym jest cyberprzestępstwo?	Cyberprzestępstwo to czyn zabroniony popełniany przy użyciu sieci komputerowych lub Internetu.	Każde przestępstwo zgłoszone przez Internet	Naruszenie praw autorskich wyłącznie w środowisku cyfrowym	Czyn zabroniony popełniany przy użyciu sieci komputerowych lub Internetu	Nieautoryzowany dostęp tylko do systemów rządowych	2	1	2026-03-15 16:08:10
108	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	Podpis elektroniczny to dane elektroniczne umożliwiające identyfikację sygnatariusza i weryfikację integralności dokumentu.	Zeskanowany własnoręczny podpis dołączony do e-maila	System szyfrowania całego dokumentu PDF	Dane elektroniczne umożliwiające identyfikację sygnatariusza i weryfikację integralności dokumentu	Hasło jednorazowe do logowania w banku	2	1	2026-03-15 16:08:10
109	Protokoły sieciowe	Do czego służy protokół HTTP?	HTTP (Hypertext Transfer Protocol) – protokół przesyłania stron internetowych.	Automatyczne przydzielanie adresów IP	Szyfrowane przesyłanie plików	Przesyłanie stron internetowych między przeglądarką a serwerem	Zdalny dostęp do komputera	2	1	2026-03-15 16:08:10
110	Protokoły sieciowe	Co to jest FTP i do czego służy?	FTP (File Transfer Protocol) – protokół służący do przesyłania plików między klientem a serwerem.	Tłumaczenie nazw domenowych na adresy IP	Przesyłanie plików między klientem a serwerem	Zarządzanie urządzeniami sieciowymi	Synchronizacja czasu systemowego	1	1	2026-03-15 16:08:10
111	Protokoły sieciowe	Czym HTTPS różni się od HTTP?	HTTPS to zabezpieczona wersja HTTP, wykorzystuje SSL/TLS do szyfrowania danych.	HTTPS działa wyłącznie w sieciach lokalnych	HTTPS jest wolniejszy, ale bardziej niezawodny	HTTPS używa innego portu i innego formatu pakietów	HTTPS szyfruje dane za pomocą SSL/TLS w odróżnieniu od HTTP	3	1	2026-03-15 16:08:10
112	Protokoły sieciowe	Co umożliwia technologia VoIP?	VoIP (Voice over Internet Protocol) umożliwia przesyłanie głosu przez Internet.	Szyfrowanie połączeń w sieci lokalnej	Prowadzenie rozmów głosowych przez Internet	Zdalny dostęp do plików na serwerze	Zarządzanie ruchem sieciowym	1	1	2026-03-15 16:08:10
113	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	TELNET przesyła dane (w tym hasła) w niezabezpieczonej formie tekstowej.	Przesyła dane w niezaszyfrowanej formie tekstowej	Działa tylko w sieciach IPv6	Nie obsługuje połączeń zdalnych	Wymaga instalacji dodatkowego sprzętu	0	1	2026-03-15 16:08:10
114	Protokoły sieciowe	W czym SSH jest lepszy od TELNET?	SSH (Secure Shell) używa szyfrowania danych, w przeciwieństwie do TELNET.	SSH jest szybszy i obsługuje więcej urządzeń	SSH działa tylko lokalnie, TELNET przez Internet	SSH nie wymaga uwierzytelniania	SSH szyfruje dane – TELNET przesyła je jako czysty tekst	3	1	2026-03-15 16:08:10
115	Protokoły sieciowe	Co robi protokół DHCP?	DHCP automatycznie przydziela adresy IP oraz inne parametry sieciowe urządzeniom.	Tłumaczy nazwy domen na adresy IP	Szyfruje połączenia w sieci lokalnej	Automatycznie przydziela adresy IP urządzeniom w sieci	Zarządza trasowaniem pakietów między sieciami	2	1	2026-03-15 16:08:10
116	Protokoły sieciowe	Za co odpowiada system DNS?	DNS (Domain Name System) tłumaczy nazwy domenowe na adresy IP.	Tłumaczy nazwy domenowe na adresy IP	Przydziela adresy IP w sieciach lokalnych	Zarządza bezpieczeństwem połączeń	Monitoruje ruch sieciowy	0	1	2026-03-15 16:08:10
117	Protokoły sieciowe	Co to jest NAT i po co się go używa?	NAT (Network Address Translation) mapuje wiele prywatnych adresów IP na jeden publiczny.	Metoda kompresji pakietów sieciowych	Protokół do szyfrowania transmisji danych	System synchronizacji zegarów sieciowych	Mapowanie wielu prywatnych IP na jeden publiczny	3	1	2026-03-15 16:08:10
118	Protokoły sieciowe	Do czego służy protokół SNMP?	SNMP (Simple Network Management Protocol) służy do zarządzania i monitorowania urządzeń sieciowych.	Przesyłanie poczty elektronicznej	Zarządzanie i monitorowanie urządzeń sieciowych	Szyfrowanie ruchu w sieci WAN	Synchronizacja czasu na urządzeniach sieciowych	1	1	2026-03-15 16:08:10
119	Protokoły sieciowe	Do czego służy protokół NTP?	NTP (Network Time Protocol) służy do synchronizacji czasu systemowego.	Przesyłania plików w sieci lokalnej	Synchronizacji czasu systemowego w sieci	Zarządzania adresami IP	Monitorowania przepustowości łącza	1	1	2026-03-15 16:08:10
120	Protokoły sieciowe	Jaka jest rola protokołu SMTP?	SMTP (Simple Mail Transfer Protocol) jest używany do wysyłania poczty elektronicznej.	Pobieranie poczty na urządzenie klienta	Zarządzanie skrzynką na wielu urządzeniach jednocześnie	Wysyłanie poczty elektronicznej między serwerami	Szyfrowanie wiadomości e-mail	2	1	2026-03-15 16:08:10
121	Protokoły sieciowe	Czym POP3 różni się od IMAP?	POP3 pobiera pocztę na urządzenie i usuwa ją z serwera. IMAP synchronizuje skrzynkę na wielu urządzeniach.	POP3 szyfruje pocztę, IMAP nie	POP3 pobiera i usuwa pocztę z serwera; IMAP synchronizuje ją na wielu urządzeniach	POP3 obsługuje tylko tekst, IMAP też załączniki	Oba protokoły działają identycznie	1	1	2026-03-15 16:08:10
122	Protokoły sieciowe	Czym jest protokół SSL?	SSL (Secure Sockets Layer) to protokół kryptograficzny zapewniający bezpieczne połączenia.	Protokół kryptograficzny szyfrujący dane między klientem a serwerem	Protokół do przesyłania plików multimedialnych	Protokół zarządzania adresami w sieci	System nazw domenowych	0	1	2026-03-15 16:08:10
123	Protokoły sieciowe	Jaka jest relacja między TLS a SSL?	TLS (Transport Layer Security) jest następcą SSL, zapewnia nowocześniejsze szyfrowanie.	TLS i SSL to dwie niezależne i równoważne technologie	TLS jest starszy i mniej bezpieczny niż SSL	TLS działa tylko w sieciach IPv6	TLS jest następcą SSL i zapewnia nowocześniejsze szyfrowanie	3	1	2026-03-15 16:08:10
124	Protokoły sieciowe	Do czego służy VPN?	VPN (Virtual Private Network) tworzy bezpieczny szyfrowany tunel przez Internet.	Przyspiesza pobieranie plików z Internetu	Zarządza domenami i adresami IP	Tworzy bezpieczny tunel przez Internet do sieci prywatnych	Monitoruje ruch w sieci lokalnej	2	1	2026-03-15 16:08:10
125	Protokoły sieciowe	Czym jest serwer Proxy?	Serwer Proxy działa jako pośrednik między klientem a serwerem, służy do filtrowania ruchu.	Pośrednik między klientem a serwerem filtrujący ruch	Urządzenie przydzielające adresy IP	System szyfrowania połączeń	Protokół do zdalnego zarządzania	0	1	2026-03-15 16:08:10
126	Protokoły sieciowe	Czym jest TCP/IP?	TCP/IP to zestaw protokołów stanowiący podstawę internetu. TCP dzieli dane na pakiety, IP adresuje je.	Jeden protokół do szyfrowania połączeń	Zestaw protokołów stanowiący podstawę internetu – TCP pakietuje dane, IP adresuje je	System nazw domenowych	Protokół zarządzania urządzeniami sieciowymi	1	1	2026-03-15 16:08:10
127	Licencje i prawo IT	Co gwarantuje licencja GNU GPL?	GNU GPL pozwala uruchamiać, modyfikować i dystrybuować oprogramowanie; zmiany muszą być na tej samej licencji.	Dowolne użycie bez obowiązku udostępniania zmian	Bezpłatne użycie tylko do celów osobistych	Uruchamianie, modyfikowanie i dystrybucję – zmiany muszą być na tej samej licencji	Używanie kodu tylko w projektach komercyjnych	2	1	2026-03-15 16:08:10
128	Licencje i prawo IT	Co to jest Adware?	Adware to darmowe oprogramowanie wyświetlające reklamy.	Złośliwe oprogramowanie blokujące pliki	Oprogramowanie wymagające subskrypcjiOprogramowanie szyfrujące dysk	Darmowe oprogramowanie finansowane przez wyświetlanie reklam	3	1	2026-03-15 16:08:10
129	Licencje i prawo IT	Co to jest Shareware?	Shareware to oprogramowanie dostępne bezpłatnie przez ograniczony czas lub z ograniczoną funkcjonalnością.	Oprogramowanie dostępne bezpłatnie przez ograniczony czas lub z ograniczoną funkcją	Oprogramowanie całkowicie darmowe na zawsze	Oprogramowanie open source z dostępem do kodu	Oprogramowanie wymagające opłaty miesięcznej	0	1	2026-03-15 16:08:10
130	Licencje i prawo IT	Czym jest Freeware?	Freeware to oprogramowanie całkowicie darmowe do użytku, bez możliwości modyfikacji.	Oprogramowanie na licencji GPL	Darmowe oprogramowanie, którego nie wolno modyfikować ani redystrybuować zmienionej wersji	Oprogramowanie open source z kodem źródłowym	Oprogramowanie dostępne przez 30-dniowy trial	1	1	2026-03-15 16:08:10
131	Licencje i prawo IT	Co charakteryzuje licencję MIT?	Licencja MIT jest bardzo liberalna – pozwala na dowolne użycie z zachowaniem informacji o autorze.	Wymaga udostępnienia kodu pochodnego na tej samej licencji	Dozwolona tylko do użytku niekomercyjnego	Zabrania dystrybucji bez zgody właściciela	Pozwala na dowolne użycie z zachowaniem informacji o autorze	3	1	2026-03-15 16:08:10
132	Licencje i prawo IT	Co to jest licencja LGPL?	LGPL pozwala na linkowanie do bibliotek bez konieczności udostępniania całego kodu na tej samej licencji.	Licencja zabraniająca komercyjnego użycia bibliotek	Pozwala linkować biblioteki bez wymogu udostępniania całego kodu na tej samej licencji	Wymaga pełnego open source całej aplikacji	Jest identyczna z GPL	1	1	2026-03-15 16:08:10
133	Licencje i prawo IT	Co to jest Proprietary License?	Licencja zastrzeżona zabrania kopiowania, modyfikowania lub dystrybucji bez zgody właściciela.	Licencja pozwalająca na dowolne modyfikacje	Licencja wymagająca publikacji kodu źródłowego	Licencja zastrzegająca wyłączne prawa właściciela – zakaz kopii i modyfikacji bez zgody	Licencja do użytku wyłącznie edukacyjnego	2	1	2026-03-15 16:08:10
134	Licencje i prawo IT	Czym jest licencja subskrypcyjna?	Model subskrypcyjny umożliwia korzystanie z oprogramowania w zamian za regularne opłaty.	Jednorazowy zakup oprogramowania na zawsze	Bezpłatne oprogramowanie finansowane reklamami	Licencja tylko dla instytucji edukacyjnych	Regularne opłaty za dostęp do oprogramowania i aktualizacji	3	12026-03-15 16:08:10
135	Licencje i prawo IT	Co to są licencje Creative Commons?	CC to zestaw licencji umożliwiających twórcom udostępnianie prac na określonych zasadach.	Licencje wyłącznie dla oprogramowania komercyjnego	Zestaw licencji do udostępniania prac twórczych na określonych zasadach	Protokół szyfrowania komunikacji	System zarządzania prawami autorskimi w UE	11	2026-03-15 16:08:10
136	Licencje i prawo IT	Kiedy powstaje ochrona praw autorskich?	Prawa autorskie chronią twórcę automatycznie od momentu stworzenia dzieła, bez żadnych formalności.	Po opublikowaniu w Internecie	Po zarejestrowaniu w urzędzie patentowym	Po upływie 70 lat od powstania	Automatycznie od momentu stworzenia dzieła – bez żadnych formalności	3	1	2026-03-15 16:08:10
137	Licencje i prawo IT	Na czym polega Prawo Cytatu?	Prawo Cytatu pozwala używać fragmentów treści chronionej w celach edukacji lub krytyki z podaniem autora.	Prawo do kopiowania całych dzieł w celach edukacyjnych	Prawo do używania fragmentów chronionej treści z podaniem autora i źródła	Prawo autora do wycofania dzieła z obiegu	Prawo do tłumaczenia dzieła bez zgody autora	1	1	2026-03-15 16:08:10
138	Licencje i prawo IT	Do czego służą Cookies (ciasteczka)?	Cookies to małe pliki tekstowe zapisywane przez strony WWW zapamiętujące preferencje i stan sesji.	Pliki złośliwego oprogramowania pobierane automatycznie	Protokół szyfrowania danych w przeglądarkach	Mechanizm blokowania reklam w przeglądarce	Małe pliki tekstowe zapamiętujące preferencje i stan sesji na stronach WWW	3	1	2026-03-15 16:08:10
139	Języki programowania	Co to jest język programowania?	Język programowania to formalny język z instrukcjami do tworzenia oprogramowania.	Formalny język z instrukcjami do tworzenia oprogramowania	Naturalny język do komunikacji z użytkownikiem	Protokół sieciowy do przesyłania kodu	System operacyjny do uruchamiania programów	0	1	2026-03-15 16:08:10
140	Języki programowania	Co to jest Python i gdzie się go stosuje?	Python to wysokopoziomowy język stosowany w Data Science, AI, automatyzacji oraz web developmencie.	Język niskopoziomowy do programowania układów FPGA	Język wyłącznie do tworzenia aplikacji mobilnych	Wysokopoziomowy język do AI, Data Science, automatyzacji i web developmentu	Język dedykowany systemom iOS i macOS	2	1	2026-03-15 16:08:10
141	Języki programowania	Do czego służy JavaScript?	JavaScript to język używany w web developmencie (front-end i back-end), aplikacjach mobilnych oraz serwerach.	Tworzenie sterowników i systemów operacyjnych	Web development (front-end i back-end), aplikacje mobilne i serwerowe	Projektowanie układów cyfrowych FPGA	Programowanie systemów wbudowanych	1	12026-03-15 16:08:10
142	Języki programowania	Do czego używa się języka Java?	Java to język do aplikacji webowych, mobilnych (Android), systemów wbudowanych i serwerowych.	Wyłącznie do gier komputerowych	Programowanie GPU i obliczeń równoległych	Tworzenie aplikacji wyłącznie na iOS	Aplikacje webowe, mobilne (Android), systemy wbudowane i serwerowe	3	1	2026-03-15 16:08:10
143	Języki programowania	Do czego stosuje się C#?	C# to język do aplikacji desktopowych, webowych, gier (Unity) oraz aplikacji mobilnych.	Aplikacje desktopowe, webowe, gry (Unity) i mobilne	Wyłącznie do aplikacji serwerowych Linux	Programowanie mikrokontrolerów Arduino	Projektowanie układów ASIC	0	1	2026-03-15 16:08:10
144	Języki programowania	Gdzie najczęściej stosuje się PHP?	PHP to język do tworzenia stron WWW, systemów CMS i aplikacji serwerowych.	Tworzenie gier 3D i silników graficznych	Strony WWW, systemy CMS i aplikacje serwerowe	Programowanie sterowników urządzeń	Aplikacje na systemy iOS i macOS	1	1	2026-03-15 16:08:10
145	Języki programowania	Co to jest Swift i gdzie się go używa?	Swift to język stworzony przez Apple, przeznaczony do tworzenia aplikacji na iOS i macOS.	Język do programowania aplikacji Android	Język do data science i analizy danych	Język Apple do tworzenia aplikacji na iOS i macOS	Język skryptowy do automatyzacji Windows	2	1	2026-03-15 16:08:10
146	Języki programowania	Czym jest SQL jako język?	SQL (Structured Query Language) to specjalistyczny język służący do zarządzania relacyjnymi bazami danych.	Język ogólnego przeznaczenia do aplikacji webowych	Język niskopoziomowy do programowania systemowego	Język skryptowy do automatyzacji zadań	Język specjalistyczny do zarządzania relacyjnymi bazami danych	3	1	2026-03-15 16:08:10
147	Języki programowania	Czym charakteryzują się języki wysokopoziomowe?	Języki wysokopoziomowe mają wysoką abstrakcję od sprzętu, zbliżone do języka naturalnego.	Dają bezpośrednią kontrolę nad sprzętem bez abstrakcji	Wymagają ręcznego zarządzania pamięcią	Są zbliżone do języka naturalnego, łatwe w nauce, mają bogate biblioteki	Działają tylko na jednej platformie	2	1	2026-03-15 16:08:10
148	Języki programowania	Co charakteryzuje języki średniopoziomowe?	Języki średniopoziomowe łączą cechy wysokiego i niskiego poziomu. Przykłady: C, C++, Rust.	Są identyczne z językami wysokopoziomowymi	Działają wyłącznie na systemach wbudowanych	Nie mogą być kompilowane	Łączą kontrolę nad sprzętem z pewną abstrakcją – np. C, C++, Rust	3	12026-03-15 16:08:10
149	Języki programowania	Czym są języki niskopoziomowe?	Języki niskopoziomowe mają minimalną abstrakcję i są bliskie kodowi maszynowemu. Przykład: Assembly.	Języki zbliżone do języka naturalnego	Języki bliskie kodowi maszynowemu z maksymalną kontrolą nad sprzętem – np. Assembly	Języki wyłącznie do baz danych	Języki interpretowane działające w przeglądarce	1	12026-03-15 16:08:10
150	Języki programowania	Co to jest TypeScript?	TypeScript to typowana wersja JavaScriptu używana w zaawansowanym web developmencie.	Nowy język do tworzenia aplikacji mobilnych	Język do tworzenia baz danych	Typowana wersja JavaScript do zaawansowanego web developmentu	Asembler dla procesorów ARM	2	1	2026-03-15 16:08:10
151	Języki programowania	Do czego służy Rust?	Rust to język do systemów operacyjnych, oprogramowania wbudowanego i aplikacji wymagających wydajności.	Systemy operacyjne, oprogramowanie wbudowane, aplikacje o wysokiej wydajności	Tworzenie stron internetowych i aplikacji webowych	Wyłącznie aplikacje mobilne Android	Data Science i analiza statystyczna	0	12026-03-15 16:08:10
152	Kompilacja i wykonanie	Co to jest kod źródłowy?	Kod źródłowy to tekst programu napisany przez programistę przed kompilacją.	Kod maszynowy wykonywany przez procesor	Skompilowany plik wykonywalny .exe	Zestaw instrukcji asemblerowych	Tekst programu napisany przez programistę przed kompilacją	3	1	2026-03-15 16:08:10
153	Kompilacja i wykonanie	Na czym polega kompilacja?	Kompilacja to proces tłumaczenia kodu źródłowego na kod maszynowy.	Tłumaczenie kodu w czasie rzeczywistym bez generowania pliku	Debugowanie i testowanie programu	Tłumaczenie kodu źródłowego na kod maszynowy – powstaje plik wykonywalny	Łączenie modułów i bibliotek w finalny plik	2	1	2026-03-15 16:08:10
154	Kompilacja i wykonanie	Czym różni się interpretacja od kompilacji?	Interpretacja polega na tłumaczeniu i wykonywaniu kodu w czasie rzeczywistym bez pliku wykonywalnego.	Interpretacja tworzy plik .exe, kompilacja nie	Oba procesy są identyczne	Interpretacja wykonuje kod na bieżąco bez pliku wykonywalnego; kompilacja tworzy plik	Interpretacja działa tylko na serwerach	2	1	2026-03-15 16:08:10
155	Kompilacja i wykonanie	Co robi Linker?	Linker to narzędzie łączące skompilowane moduły i biblioteki w finalny plik wykonywalny.	Kompiluje kod źródłowy na kod asemblerowy	Łączy skompilowane moduły i biblioteki w finalny plik wykonywalny	Debuguje błędy w kodzie źródłowym	Uruchamia program w środowisku wirtualnym	1	1	2026-03-15 16:08:10
156	Kompilacja i wykonanie	Na czym polega cykl pobierania-dekodowania-wykonania?	To podstawowy proces procesora: pobiera instrukcję z pamięci, dekoduje ją, a następnie wykonuje.	Metoda zarządzania pamięcią podręczną	Podstawowy cykl procesora: pobierz instrukcję → zdekoduj → wykonaj	Protokół komunikacji między rdzeniami procesora	Proces kompilacji kodu do pliku wykonywalnego	1	1	2026-03-15 16:08:10
157	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	TCP jest połączeniowy i gwarantuje dostarczenie danych. UDP jest bezpołączeniowy i szybszy.	TCP i UDP działają identycznie	UDP gwarantuje dostarczenie; TCP nie	TCP działa w warstwie fizycznej	TCP gwarantuje dostarczenie (połączeniowy); UDP nie gwarantuje	3	1	2026-03-15 16:08:10
158	Sieci komputerowe	Do której warstwy modelu OSI należy HTTP?	HTTP to warstwa 7 – aplikacji. Inne: HTTPS, FTP, SMTP, DNS.	Warstwa 4 – transportowa	Warstwa 7 – aplikacji	Warstwa 3 – sieciowa	Warstwa 2 – łącza danych	1	1	2026-03-15 16:08:10
159	Sieci komputerowe	Co to jest adres MAC?	Unikalny 48-bitowy identyfikator sprzętowy karty sieciowej. Działa w warstwie 2 OSI.	Adres logiczny przydzielany przez DHCP	Unikalny identyfikator sprzętowy karty sieciowej (warstwa 2)	Nazwa hosta w sieci lokalnej	Identyfikator sesji TCP	1	1	2026-03-15 16:08:10
160	Sieci komputerowe	Co to jest LAN?	LAN (Local Area Network) to sieć łącząca urządzenia na ograniczonym obszarze.	Sieć obejmująca cały kraj lub kontynent	Sieć łącząca miasta w kraju	Bezprzewodowa sieć rozległa	Sieć lokalna łącząca urządzenia na ograniczonym obszarze np. biuro	3	1	2026-03-15 16:08:10
161	Sieci komputerowe	Co to jest MAN?	MAN (Metropolitan Area Network) łączy wiele sieci LAN na obszarze miasta lub kampusu.	Sieć łącząca sieci LAN w obszarze miasta lub kampusu	Sieć lokalna w jednym budynku	Sieć globalna łącząca kontynenty	Bezprzewodowa sieć w zasięgu Bluetooth	0	1	2026-03-15 16:08:10
162	Sieci komputerowe	Do czego służy Router?	Router łączy różne sieci i kieruje ruchem między nimi na podstawie adresów IP.	Rozgłasza dane do wszystkich portów jednocześnie	Przydziela adresy IP w sieci	Łączy urządzenia w jednej sieci lokalnej na podstawie MAC	Łączy różne sieci i kieruje ruchem na podstawie adresów IP	3	1	2026-03-15 16:08:10
163	Sieci komputerowe	Czym się różni Switch od Hub?	Switch inteligentnie kieruje pakiety do właściwych portów na podstawie MAC. Hub rozsyła do wszystkich.	Switch kieruje dane do właściwego portu (MAC); Hub rozsyła do wszystkich portów	Switch jest wolniejszy, Hub szybszy	Oba działają identycznie	Switch działa w warstwie IP, Hub w warstwie fizycznej01	2026-03-15 16:08:10
164	Sieci komputerowe	Co to jest Firewall?	Firewall to zabezpieczenie kontrolujące ruch sieciowy i chroniące przed nieautoryzowanym dostępem.	Protokół szyfrowania połączeń VPN	Serwer zarządzający adresami IP	Urządzenie wzmacniające sygnał Wi-Fi	Zabezpieczenie kontrolujące ruch sieciowy i chroniące przed nieautoryzowanym dostępem	3	1	2026-03-15 16:08:10
165	Sieci komputerowe	Co to jest Ethernet?	Ethernet to technologia do tworzenia przewodowych połączeń w lokalnych sieciach komputerowych.	Bezprzewodowa technologia sieciowa	Protokół szyfrowania danych w sieci	Technologia przewodowych połączeń w sieciach lokalnych	System zarządzania adresami IP	2	1	2026-03-15 16:08:10
166	Sieci komputerowe	Czym jest Wi-Fi?	Wi-Fi to technologia umożliwiająca bezprzewodowe łączenie urządzeń z siecią.	Przewodowa technologia sieciowa standardu LAN	Protokół szyfrowania transmisji bezprzewodowej	System adresowania urządzeń w sieci	Technologia bezprzewodowego łączenia urządzeń z siecią	3	1	2026-03-15 16:08:10
167	Bezpieczeństwo IT	Co to jest Malware?	Malware (złośliwe oprogramowanie) to zbiorcza nazwa programów do atakowania systemów i kradzieży danych.	Legalne oprogramowanie antywirusowe	Zbiorcza nazwa złośliwych programów do atakowania systemów i kradzieży danych	Protokół zabezpieczeń sieciowych	System kopii zapasowych	1	1	2026-03-15 16:08:10
168	Bezpieczeństwo IT	Czym charakteryzują się wirusy komputerowe?	Wirusy dołączają się do plików i aktywują się po uruchomieniu, wymagają interakcji użytkownika.	Replikują się automatycznie przez sieć bez interakcji użytkownika	Szyfrują pliki i żądają okupu	Dołączają się do plików i aktywują po uruchomieniu – wymagają interakcji użytkownika	Służą do wyświetlania reklam	2	1	2026-03-15 16:08:10
169	Bezpieczeństwo IT	Jak robaki (Worms) różnią się od wirusów?	Robaki replikują się automatycznie przez sieć bez interakcji użytkownika, bez dołączania do plików.	Robaki i wirusy to to samo	Robaki replikują się automatycznie przez sieć bez interakcji użytkownika	Robaki tylko szyfrują pliki	Robaki wymagają uruchomienia pliku przez użytkownika	11	2026-03-15 16:08:10
170	Bezpieczeństwo IT	Co to jest Trojan (Trojan Horse)?	Trojan to oprogramowanie udające przydatną aplikację, które kradnie dane lub pozwala na zdalne przejęcie kontroli.	Wirus replikujący się przez e-mail	Program wyświetlający reklamy	Oprogramowanie szyfrujące pliki i żądające okupu	Oprogramowanie udające przydatną aplikację umożliwiające zdalne przejęcie kontroli	3	1	2026-03-15 16:08:10
171	Bezpieczeństwo IT	Co to jest Ransomware?	Ransomware blokuje dostęp do plików lub systemu i żąda okupu za ich odblokowanie.	Oprogramowanie szpiegujące aktywność użytkownika	Wirus sieciowy replikujący się automatycznie	Program wyświetlający niechciane reklamy	Złośliwe oprogramowanie blokujące pliki i żądające okupu	3	1	2026-03-15 16:08:10
172	Bezpieczeństwo IT	Do czego służy Spyware?	Spyware szpieguje aktywność użytkownika bez jego wiedzy, zbierając dane osobiste i informacje logowania.	Blokuje dostęp do systemu i żąda okupu	Replikuje się przez sieć atakując serwery	Wyświetla niechciane reklamy w przeglądarce	Szpieguje aktywność użytkownika i zbiera dane osobiste bez jego wiedzy3	1	2026-03-15 16:08:10
173	Bezpieczeństwo IT	Co to jest Rootkit?	Rootkit to trudne do wykrycia oprogramowanie maskujące swoją obecność, dające atakującemu pełną kontrolę.	Narzędzie do monitorowania ruchu sieciowego	Protokół szyfrowania dysku twardego	Oprogramowanie maskujące się w systemie i dające atakującemu pełną kontrolę	Program antywirusowy do usuwania wirusów	21	2026-03-15 16:08:10
174	Bezpieczeństwo IT	Co to jest Keylogger?	Keylogger to program monitorujący i zapisujący naciśnięcia klawiszy, służy do kradzieży haseł.	Oprogramowanie optymalizujące klawiaturę	Program zapisujący naciśnięcia klawiszy w celu kradzieży haseł i danych	Sterownik do obsługi klawiatury bezprzewodowej	Narzędzie do makr klawiszowych	1	1	2026-03-15 16:08:10
175	Bezpieczeństwo IT	Czym Adware różni się od zwykłego Malware?	Adware wyświetla reklamy i może prowadzić do dalszych infekcji; nie kradnie bezpośrednio danych.	Adware i Malware to synonimy	Adware jest bezpieczne i nie stanowi zagrożenia	Adware działa tylko na serwerach	Adware wyświetla reklamy i może prowadzić do dalszych infekcji; nie kradnie bezpośrednio danych	3	1	2026-03-15 16:08:10
176	Algorytmy	Czym jest algorytm?	Algorytm to skończony, jednoznaczny ciąg kroków prowadzących do rozwiązania problemu.	Program napisany w dowolnym języku programowania	Skończony, jednoznaczny ciąg kroków prowadzących do rozwiązania problemu	Dowolna procedura matematyczna	Schemat blokowy zapisany w pamięci komputera	1	1	2026-03-15 16:08:10
177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	Insertion sort buduje posortowaną tablicę element po elemencie, wstawiając każdy nowy element na właściwe miejsce.	Dzieli tablicę na pół i sortuje każdą połowę osobno	Wybiera zawsze najmniejszy element i zamienia z pierwszym niesortowanym	Buduje posortowaną tablicę element po elemencie, wstawiając każdy na właściwe miejsce	Używa kolejki priorytetowej do kolejkowania elementów	2	1	2026-03-15 16:08:10
178	Algorytmy	Co to jest rekurencja?	Rekurencja to technika, w której funkcja wywołuje samą siebie z uproszczonym problemem, aż do osiągnięcia przypadku bazowego.	Pętla iteracyjna wykonująca ten sam kod wielokrotnie	Technika, w której funkcja wywołuje samą siebie z uproszczonym problemem	Metoda optymalizacji algorytmów sortowania	Rodzaj struktury danych w języku C++	1	1	2026-03-15 16:08:10
179	Algorytmy	Czym różni się BFS od DFS w grafach?	BFS (przeszukiwanie wszerz) używa kolejki i przegląda warstwami. DFS (wgłąb) używa stosu i idzie jak najgłębiej.	BFS i DFS zawsze dają te same wyniki	BFS działa tylko na grafach skierowanych, DFS tylko na nieskierowanych	BFS zawsze jest szybszy od DFS	BFS używa kolejki i przegląda warstwami; DFS używa stosu i idzie jak najgłębiej	3	1	2026-03-15 16:08:10
180	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	Wyszukiwanie binarne w O(log n) znajduje element w POSORTOWANEJ tablicy, dzieląc zakres wyszukiwania na pół.	Do sortowania tablicy w czasie O(n log n)	Do wyszukiwania wzorca w tekście	Do szybkiego wyszukiwania w posortowanej tablicy w czasie O(log n)	Do znajdowania najkrótszej ścieżki w grafie	2	1	2026-03-15 16:08:10
181	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	Algorytm Euklidesa oblicza NWD(a,b): jeśli b=0 zwraca a, w przeciwnym razie zwraca NWD(b, a mod b).	Oblicza silnię liczby metodą rekurencyjną	Wyznacza liczby pierwsze metodą sita	Oblicza NWD(a,b): jeśli b=0 zwróć a, inaczej NWD(b, a mod b)	Sortuje liczby całkowite od najmniejszej do największej	2	1	2026-03-15 16:08:10
182	Algorytmy	Co to jest programowanie dynamiczne?	Programowanie dynamiczne rozwiązuje problem rozkładając go na podproblemy i zapamiętując (memoizacja) wyniki.	Technika pisania kodu bez użycia pętli	Metoda dynamicznego przydzielania pamięci w trakcie działania programu	Algorytm do sortowania dużych zbiorów danych	Technika rozkładania problemu na podproblemy i zapamiętywania wyników (memoizacja)	3	1	2026-03-15 16:08:10
183	Algorytmy	Czym jest algorytm zachłanny (greedy)?	Algorytm zachłanny w każdym kroku wybiera lokalnie optymalną decyzję, licząc że prowadzi do globalnego optimum.	Algorytm przeszukujący wszystkie możliwe rozwiązania metodą brute force	Algorytm zawsze dający optymalne rozwiązanie dla dowolnego problemu	W każdym kroku wybiera lokalnie optymalną decyzję licząc na globalne optimum	Technika podziału problemu na dwie równe części	2	1	2026-03-15 16:08:10
184	Złożoność obliczeniowa	Co oznacza notacja O(n)?	O(n) to złożoność liniowa – czas wykonania rośnie proporcjonalnie do rozmiaru danych wejściowych.	Czas wykonania jest stały i niezależny od danych	Czas wykonania rośnie kwadratowo wraz z rozmiarem danych	Czas wykonania rośnie proporcjonalnie do rozmiaru danych (złożoność liniowa)	Czas wykonania rośnie logarytmicznie	2	1	2026-03-15 16:08:10
185	Złożoność obliczeniowa	Jaka jest złożoność czasowa sortowania bąbelkowego (bubble sort)?	Bubble sort ma złożoność O(n²) w przypadku średnim i pesymistycznym.	O(n log n) w każdym przypadku	O(n) dla posortowanej tablicy, O(n²) dla odwrotnie posortowanej	O(n²) w przypadku średnim i pesymistycznym	O(log n) dla tablicy posortowanej	2	1	2026-03-15 16:08:10
186	Złożoność obliczeniowa	Jaka jest złożoność algorytmu merge sort?	Merge sort ma złożoność O(n log n) w każdym przypadku – pesymistycznym, średnim i optymistycznym.	O(n²) w pesymistycznym przypadku	O(n) dla posortowanej tablicy	O(n log n) w każdym przypadku – pesymistycznym, średnim i optymistycznym	O(log n) dla małych tablic	2	1	2026-03-15 16:08:10
187	Złożoność obliczeniowa	Co oznacza złożoność O(1)?	O(1) to złożoność stała – czas wykonania jest niezależny od rozmiaru danych wejściowych.	Czas wykonania rośnie z każdym elementem	Algorytm działa tylko dla jednego elementu	Złożoność stała – czas niezależny od rozmiaru danych	Czas wykonania równy liczbie elementów podzielonej przez 2	2	12026-03-15 16:08:10
188	Złożoność obliczeniowa	Dlaczego binary search ma złożoność O(log n)?	Binary search dzieli zakres wyszukiwania na pół w każdym kroku, więc potrzeba co najwyżej log₂(n) kroków.	Bo zawsze przeszukuje połowę tablicy niezależnie od danych	Bo implementacja używa rekurencji ogonowej	Bo działa tylko dla n będącego potęgą 2	Bo dzieli zakres wyszukiwania na pół w każdym kroku – potrzeba log₂(n) kroków	3	1	2026-03-15 16:08:10
189	Złożoność obliczeniowa	Jaka jest złożoność dostępu do elementu tablicy po indeksie?	Dostęp po indeksie to O(1) – komputer bezpośrednio oblicza adres w pamięci.	O(n) – trzeba przejść wszystkie elementy	O(log n) – używa wyszukiwania binarnego	O(1) – bezpośredni dostęp przez adres pamięci	O(n²) – zależy od rozmiaru tablicy kwadratowo	2	1	2026-03-15 16:08:10
190	Złożoność obliczeniowa	Co to jest złożoność pamięciowa algorytmu?	Złożoność pamięciowa opisuje ile dodatkowej pamięci algorytm potrzebuje w zależności od rozmiaru danych.	Liczba bitów potrzebnych do zapisania programu na dysku	Czas potrzebny do przydzielenia pamięci przez system operacyjny	Rozmiar danych wejściowych w bajtach	Ilość dodatkowej pamięci potrzebnej algorytmowi w zależności od rozmiaru danych	3	1	2026-03-15 16:08:10
191	Systemy liczbowe	Ile wynosi 1010₂ w systemie dziesiętnym?	1010₂ = 1×8 + 0×4 + 1×2 + 0×1 = 8 + 2 = 10₁₀	8	12	10	6	2	1	2026-03-15 16:08:10
192	Systemy liczbowe	Ile wynosi 255₁₀ w systemie szesnastkowym?	255₁₀ = 15×16 + 15 = FF₁₆	FE	FF	EF	100	1	1	2026-03-15 16:08:10
193	Systemy liczbowe	Ile cyfr używa system ósemkowy (oktalny)?	System ósemkowy używa cyfr 0–7 (osiem cyfr: 0, 1, 2, 3, 4, 5, 6, 7).	6 cyfr: 0–5	10 cyfr: 0–9	16 cyfr: 0–9 i A–F	8 cyfr: 0–7	3	1	2026-03-15 16:08:10
194	Systemy liczbowe	Jak przelicza się liczbę binarną na dziesiętną?	Mnożymy każdą cyfrę przez odpowiednią potęgę 2 (od prawej: 2⁰, 2¹, 2², ...) i sumujemy.	Dzielimy liczbę przez 2 wielokrotnie i czytamy reszty od dołu	Mnożymy każdą cyfrę przez odpowiednią potęgę 2 i sumujemy	Zamieniamy każde 4 bity na jedną cyfrę szesnastkową	Odczytujemy cyfrę po cyfrze i sumujemy	1	1	2026-03-15 16:08:10
195	Systemy liczbowe	Co to jest bit i co to jest bajt?	Bit to najmniejsza jednostka informacji (0 lub 1). Bajt = 8 bitów.	Bit to 8 cyfr binarnych; bajt to 1 cyfra binarna	Bit i bajt to to samo	Bit to 4 cyfry binarne; bajt to 2 bity	Bit to 0 lub 1 (najmniejsza jednostka); bajt = 8 bitów	3	1	2026-03-15 16:08:10
196	Systemy liczbowe	Ile wynosi A3₁₆ w systemie dziesiętnym?	A3₁₆ = 10×16 + 3 = 160 + 3 = 163₁₀	173	163	143	153	1	1	2026-03-15 16:08:10
197	Systemy liczbowe	Jak zapisujemy liczbę 13₁₀ w systemie binarnym?	13 = 8+4+1 = 1101₂	1110	1010	1100	1101	3	1	2026-03-15 16:08:10
198	Systemy liczbowe	Do czego służy system szesnastkowy (hex) w informatyce?	Hex jest zwięzłą reprezentacją danych binarnych – 1 cyfra hex = 4 bity. Używany m.in. do adresów pamięci i kolorów.	Do zapisywania dużych liczb dziesiętnych w mniejszej liczbie cyfr	Wyłącznie do zapisu adresów IPv6	Zwięzła reprezentacja danych binarnych: 1 cyfra hex = 4 bity; kolory, adresy pamięci	Do obliczeń zmiennoprzecinkowych w procesorze	2	1	2026-03-15 16:08:10
199	Bazy danych	Czym różni się DELETE od DROP?	DELETE usuwa wiersze (tabela istnieje). DROP TABLE usuwa całą tabelę.	DELETE usuwa tabelę; DROP usuwa wiersze	Są synonimami	DELETE działa na kolumnach	DELETE usuwa wiersze; DROP usuwa całą tabelę	3	1	2026-03-15 16:08:10
200	Bazy danych	Czym jest PRIMARY KEY?	PRIMARY KEY jednoznacznie identyfikuje rekord w tabeli – musi być unikalny i NOT NULL.	FK do innej tabeli	Indeks przyspieszający wyszukiwanie	Unikalny identyfikator rekordu (NOT NULL)	Pierwsza kolumna tabeli	2	1	2026-03-15 16:08:10
201	Bazy danych	Różnica między WHERE a HAVING?	WHERE filtruje wiersze PRZED GROUP BY. HAVING filtruje grupy PO GROUP BY.	Są synonimami	WHERE przed GROUP BY; HAVING po GROUP BY	HAVING szybsze od WHERE	WHERE na kolumnach; HAVING na wierszach	1	1	2026-03-15 16:08:10
202	Bazy danych	Co to jest indeks w bazie danych?	Indeks to struktura danych przyspieszająca wyszukiwanie rekordów (jak spis treści).	Unikalny ID wiersza	Kopia zapasowa tabeli	Ograniczenie NOT NULL	Struktura przyspieszająca wyszukiwanie	3	1	2026-03-15 16:08:10
203	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	FOREIGN KEY to kolumna wskazująca na PRIMARY KEY w innej tabeli, zapewniając integralność relacyjną.	Kolumna wskazująca na PRIMARY KEY w innej tabeli – zapewnia integralność relacyjną	Kolumna, której wartości nie mogą się powtarzać	Automatycznie generowany identyfikator rekordu	Indeks przyspieszający wyszukiwanie	0	1	2026-03-15 16:08:10
204	Bazy danych	Co to jest transakcja w bazie danych?	Transakcja to jednostka pracy w DB, która albo w całości się udaje (COMMIT) albo jest cofana (ROLLBACK).	Jednorazowe zapytanie SELECT do bazy danych	Przeniesienie danych między tabelami	Kopia zapasowa wybranej tabeli	Jednostka pracy albo w całości udana (COMMIT) albo cofnięta (ROLLBACK)	3	1	2026-03-15 16:08:10
205	Bazy danych	Co to jest JOIN w SQL?	JOIN łączy wiersze z dwóch lub więcej tabel na podstawie powiązanej kolumny.	Polecenie sortujące wyniki zapytania	Łączy wiersze z dwóch lub więcej tabel na podstawie powiązanej kolumny	Grupuje wiersze o identycznych wartościach	Usuwa duplikaty z wyników zapytania	1	1	2026-03-15 16:08:10
206	Bazy danych	Co robi polecenie GROUP BY?	GROUP BY grupuje wiersze z identyczną wartością w kolumnie do jednego wiersza podsumowania.	Sortuje wyniki według podanej kolumnyGrupuje wiersze o tej samej wartości w kolumnie do jednego podsumowania	Filtruje wyniki po warunku logicznym	Łączy dwie tabele w jedną	1	1	2026-03-15 16:08:10
207	Architektura komputera	Różnica RAM vs ROM?	RAM – ulotna, odczyt/zapis, traci dane po wyłączeniu. ROM – nieulotna, tylko odczyt, firmware/BIOS.	RAM nieulotna; ROM ulotna	RAM = BIOS; ROM = pamięć robocza	Oba to cache procesora	RAM ulotna RW; ROM nieulotna odczyt	3	1	2026-03-15 16:08:10
208	Architektura komputera	Co to jest ALU?	ALU (Arithmetic Logic Unit) – wykonuje operacje arytmetyczne (+,-,*,/) i logiczne (AND, OR, NOT, XOR).	Układ zarządzający cache	Jednostka arytmetyczno-logiczna procesora	Kontroler magistrali	Dekoder instrukcji	1	1	2026-03-15 16:08:10
209	Architektura komputera	Co to jest cache procesora?	Cache procesora to szybka pamięć podręczna (L1/L2/L3), która przechowuje często używane dane.	Szybka pamięć podręczna (L1/L2/L3)	Pamięć wirtualna na dysku	Bufor I/O	Pamięć BIOS	0	1	2026-03-15 16:08:10
210	Architektura komputera	Co to jest procesor wielordzeniowy?	Procesor wielordzeniowy zawiera dwa lub więcej niezależnych rdzeni obliczeniowych, co umożliwia równoległe przetwarzanie.	Procesor z bardzo dużą pamięcią cache	Procesor obsługujący wyłącznie wirtualizację	Jeden rdzeń obliczeniowy taktowany z dużą częstotliwością	Procesor z wieloma niezależnymi rdzeniami obliczeniowymi do równoległego przetwarzania	3	1	2026-03-15 16:08:10
211	Architektura komputera	Co to jest magistrala (bus) w komputerze?	Magistrala to zestaw linii komunikacyjnych przesyłających dane między komponentami komputera.	Pamięć podręczna procesora najwyższego poziomu	Zestaw linii komunikacyjnych przesyłających dane między komponentami	Protokół sieciowy do komunikacji w sieci LAN	Sterownik urządzeń wejścia/wyjścia	1	1	2026-03-15 16:08:10
212	Architektura komputera	Co to jest pamięć wirtualna?	Pamięć wirtualna rozszerza dostępną pamięć RAM używając przestrzeni dyskowej (swap/plik stronicowania).	Pamięć zainstalowana na karcie graficznej	Inna nazwa dla pamięci RAM	Rozszerzenie dostępnej pamięci RAM poprzez użycie przestrzeni dyskowej	Pamięć nieulotna przechowująca BIOS	2	1	2026-03-15 16:08:10
213	Prawo informatyczne	Co reguluje RODO?	RODO reguluje ochronę danych osobowych osób w UE. Zasady: minimalizacja, zgoda, prawo do bycia zapomnianym.	Handel elektroniczny	Tylko firmy IT w Polsce	Prawa autorskie	Ochrona danych osobowych w UE	3	1	2026-03-15 16:08:10
214	Prawo informatyczne	Co to jest licencja open source?	Licencja open source zezwala na używanie, modyfikację i dystrybucję z kodem źródłowym.	Freeware bez kodu	Shareware po 30 dniach	Public domain	Używanie + modyfikacja + dystrybucja z kodem	3	1	2026-03-15 16:08:10
215	Prawo informatyczne	Czym jest cyberprzestępstwo?	Cyberprzestępstwo to czyn zabroniony popełniany przy użyciu sieci komputerowych lub Internetu.	Każde przestępstwo zgłoszone przez Internet	Naruszenie praw autorskich wyłącznie w środowisku cyfrowym	Czyn zabroniony popełniany przy użyciu sieci komputerowych lub Internetu	Nieautoryzowany dostęp tylko do systemów rządowych	2	1	2026-03-15 16:08:10
216	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	Podpis elektroniczny to dane elektroniczne umożliwiające identyfikację sygnatariusza i weryfikację integralności dokumentu.	Zeskanowany własnoręczny podpis dołączony do e-maila	System szyfrowania całego dokumentu PDF	Dane elektroniczne umożliwiające identyfikację sygnatariusza i weryfikację integralności dokumentu	Hasło jednorazowe do logowania w banku	2	1	2026-03-15 16:08:10
217	Kryptografia	Jaka jest rola liczby n w algorytmie RSA?	Jest używana jako moduł w obliczeniach	Jest kluczem prywatnym	Jest używana jako moduł w obliczeniach	Służy do obliczania φ(n) tylko	Jest liczbą pierwszą	1	1	2026-03-18 19:57:58
218	Kryptografia	Dlaczego liczba n = p * q musi być duża?	Żeby utrudnić rozkład na czynniki pierwsze	Żeby przyspieszyć obliczenia	Żeby zmniejszyć klucz	Żeby utrudnić rozkład na czynniki pierwsze	Żeby uprościć wzory	2	1	2026-03-18 19:57:58
219	Kryptografia	Co by się stało, gdyby ktoś poznał liczby p i q?	Mógłby wyliczyć klucz prywatny	Nic istotnego	Mógłby tylko szyfrować	Mógłby wyliczyć klucz prywatny	System działałby szybciej	2	1	2026-03-18 19:57:58
220	Kryptografia	Dlaczego φ(n) = (p-1)(q-1)?	Wynika z własności liczb pierwszych	To definicja dla dowolnych liczb	Wynika z własności liczb pierwszych	Jest to przybliżenie	Nie ma znaczenia	1	1	2026-03-18 19:57:58
221	Kryptografia	Co oznacza warunek: gcd(e, φ(n)) = 1?	e i φ(n) są względnie pierwsze	e musi być liczbą pierwszą	e i φ(n) są względnie pierwsze	e < φ(n)	e = φ(n)	11	2026-03-18 19:57:58
222	Kryptografia	Dlaczego potrzebujemy liczby d w RSA?	Do odszyfrowania wiadomości	Do szyfrowania	Do obliczania n	Do odszyfrowania wiadomości	Do generowania p	2	12026-03-18 19:57:58
223	Kryptografia	Jak matematycznie powiązane są e i d w RSA?	e * d ≡ 1 mod φ(n)	e + d = n	e * d ≡ 1 mod φ(n)	e = d	e - d = 1	1	1	2026-03-18 19:57:58
224	Kryptografia	Dlaczego znajomość tylko e i n nie wystarcza do odszyfrowania?	Bo brakuje φ(n), a więc i d	Bo e jest za małe	Bo brakuje φ(n), a więc i d	Bo n jest parzyste	Bo potrzeba hasła	1	1	2026-03-18 19:57:58
225	Kryptografia	Co jest najtrudniejszym problemem matematycznym stojącym za RSA?	Faktoryzacja dużych liczb	Potęgowanie	Dodawanie modulo	Faktoryzacja dużych liczb	Mnożenie	2	1	2026-03-18 19:57:58
226	Kryptografia	Dlaczego w RSA używa się modulo?	Żeby liczby były mniejsze	Żeby liczby były mniejsze	Żeby zwiększyć bezpieczeństwo wizualne	Żeby uniknąć dzieleniaŻeby uprościć zapis	0	1	2026-03-18 19:57:58
227	Kryptografia	Co oznacza operacja M^e mod n?	Szyfrowanie wiadomości	Dzielenie	Szyfrowanie wiadomości	Odszyfrowanie	Kompresję	1	1	2026-03-18 19:57:58
228	Kryptografia	Co oznacza operacja C^d mod n?	Odszyfrowanie	Szyfrowanie	Odszyfrowanie	Skracanie danych	Generowanie klucza	1	1	2026-03-18 19:57:58
229	Kryptografia	Dlaczego RSA jest wolniejszy niż szyfry symetryczne?	Bo operuje na dużych liczbach i potęgach	Bo używa tekstu	Bo operuje na dużych liczbach i potęgach	Bo ma więcej użytkowników	Bo używa jednego klucza	1	1	2026-03-18 19:57:58
230	Kryptografia	Do czego w praktyce używa się RSA?	Do wymiany kluczy i podpisów	Do szyfrowania całych plików	Do wymiany kluczy i podpisów	Do kompresji	Do przechowywania danych	1	1	2026-03-18 19:57:58
231	Kryptografia	Dlaczego RSA nie szyfruje całych wiadomości w praktyce?	Bo jest zbyt wolny	Bo jest niebezpieczny	Bo jest zbyt wolny	Bo nie działa na tekstach	Bo wymaga internetu	1	1	2026-03-18 19:57:58
232	Kryptografia	Co się stanie, jeśli wybierzemy e nie względnie pierwsze z φ(n)?	Nie da się poprawnie odszyfrować	Szyfr będzie szybszy	Nie da się poprawnie odszyfrować	Nic się nie zmieni	Zwiększy się bezpieczeństwo	1	1	2026-03-18 19:57:58
233	Kryptografia	Dlaczego wybór małych liczb p i q jest niebezpieczny?	Bo łatwo je rozłożyć i złamać szyfr	Bo są trudniejsze do zapisania	Bo łatwo je rozłożyć i złamać szyfr	Bo spowalniają system	Bo nie działają w modulo	1	1	2026-03-18 19:57:58
234	Kryptografia	Co jest kluczem publicznym w RSA?	(e, n)	(d, n)	(e, n)	(p, q)	(φ(n), d)	1	1	2026-03-18 19:57:58
235	Kryptografia	Co jest kluczem prywatnym w RSA?	(d, n)	(e, n)	(p, q)	(d, n)	(φ(n), e)	2	1	2026-03-18 19:57:58
236	Kryptografia	Dlaczego nie ujawnia się wartości d w RSA?	Bo pozwala odszyfrować wiadomości	Bo jest za duża	Bo pozwala odszyfrować wiadomości	Bo nie jest potrzebnaBo jest publiczna	1	1	2026-03-18 19:57:58
237	Kryptografia	Dlaczego szyfr Cezara jest uznawany za słaby?	Bo ma małą liczbę możliwych kluczy	Bo jest wolny	Bo używa dużych liczb	Bo ma małą liczbę możliwych kluczy	Bo nie używa modulo	2	1	2026-03-18 19:57:58
238	Kryptografia	Ile maksymalnie kluczy ma szyfr Cezara (alfabet 26 liter)?	25	13	25	26	Nieskończenie wiele	1	1	2026-03-18 19:57:58
239	Kryptografia	Co jest główną wadą szyfrów symetrycznych?	Trudno przekazać klucz	Są wolne	Trudno przekazać klucz	Są łatwe do złamania matematycznie	Nie używają liczb	1	1	2026-03-18 19:57:58
240	Kryptografia	W szyfrze afinicznym warunek dla liczby a wynika z:	Konieczności istnienia odwrotności modulo	Potrzeby szybszego działania	Konieczności istnienia odwrotności modulo	Ograniczenia długości tekstu	Liczby liter w alfabecie	1	1	2026-03-18 19:57:58
241	Kryptografia	Co się stanie, jeśli a i 26 nie są względnie pierwsze w szyfrze afinicznym?	Nie można odszyfrować wiadomości	Szyfr działa szybciej	Nie można odszyfrować wiadomości	Szyfr staje się silniejszy	Nic się nie zmienia	1	1	2026-03-18 19:57:58
242	Kryptografia	Dlaczego w RSA wybiera się liczby pierwsze p i q?	Bo zapewniają trudność faktoryzacji	Bo są łatwe do zapamiętania	Bo przyspieszają szyfrowanie	Bo zapewniają trudność faktoryzacji	Bo są małe	2	1	2026-03-18 19:57:58
243	Kryptografia	Na czym polega bezpieczeństwo algorytmu RSA?	Na trudności rozkładu liczby n na czynniki pierwsze	Na tajności wzorów	Na trudności rozkładu liczby n na czynniki pierwsze	Na długości wiadomości	Na liczbie użytkowników	1	1	2026-03-18 19:57:58
244	Kryptografia	Dlaczego nie ujawnia się wartości φ(n) w RSA?	Bo umożliwia znalezienie klucza prywatnego	Bo jest niepotrzebna	Bo umożliwia znalezienie klucza prywatnego	Bo jest za duża	Bo nie istnieje	1	1	2026-03-18 19:57:58
245	Kryptografia	Co musi spełniać liczba e w RSA?	Musi być względnie pierwsza z φ(n)	Musi być parzysta	Musi być względnie pierwsza z φ(n)	Musi być większa od nMusi być liczbą pierwszą	1	1	2026-03-18 19:57:58
246	Kryptografia	Dlaczego w RSA stosuje się potęgowanie modulo?	Żeby ograniczyć wielkość liczb	Żeby uprościć zapis	Żeby ograniczyć wielkość liczb	Żeby zwiększyć długość kluczaŻeby przyspieszyć komputer	1	1	2026-03-18 19:57:58
247	Kryptografia	Co by się stało, gdyby klucz prywatny w RSA był publiczny?	Każdy mógłby odszyfrować wiadomości	Nic	Tylko szyfrowanie byłoby wolniejsze	Każdy mógłby odszyfrować wiadomości	System działałby szybciej	2	1	2026-03-18 19:57:58
248	Kryptografia	Dlaczego używa się funkcji skrótu przed podpisem cyfrowym?	Żeby zmniejszyć ilość danych do podpisania	Żeby zaszyfrować wiadomość	Żeby zmniejszyć ilość danych do podpisania	Żeby ukryć klucz	Żeby przyspieszyć internet	1	1	2026-03-18 19:57:58
249	Kryptografia	Co gwarantuje podpis cyfrowy?	Autentyczność i integralność	Poufność	Szybkość	Autentyczność i integralność	Kompresję	2	1	2026-03-18 19:57:58
250	Kryptografia	Dlaczego funkcja skrótu musi być nieodwracalna?	Żeby nie można było odzyskać danych	Żeby była szybsza	Żeby nie można było odzyskać danych	Żeby była krótka	Żeby była popularna	1	1	2026-03-18 19:57:58
251	Kryptografia	Dlaczego analiza częstotliwości działa na szyfrach klasycznych?	Bo zachowują strukturę języka	Bo są losowe	Bo zachowują strukturę języka	Bo są matematyczne	Bo są krótkie	1	1	2026-03-18 19:57:58
252	Kryptografia	Co jest główną różnicą między szyfrem Cezara a afinicznym?	Użycie mnożenia i dodawania	Brak klucza	Użycie mnożenia i dodawania	Brak modulo	Długość tekstu	1	1	2026-03-18 19:57:58
253	Kryptografia	Dlaczego szyfr afiniczny jest silniejszy od Cezara?	Bo ma więcej możliwych kluczy	Bo jest szybszy	Bo ma więcej możliwych kluczy	Bo nie używa alfabetu	Bo nie da się go złamać	1	1	2026-03-18 19:57:58
254	Kryptografia	Co oznacza, że algorytm jest asymetryczny?	Używa dwóch różnych kluczy	Używa jednego klucza	Używa dwóch różnych kluczy	Działa tylko na liczbach	Jest wolny	1	1	2026-03-18 19:57:58
255	Kryptografia	Dlaczego szyfry asymetryczne są wolniejsze?	Bo operują na dużych liczbach	Bo używają tekstu	Bo operują na dużych liczbach	Bo są stare	Bo są proste	11	2026-03-18 19:57:58
256	Kryptografia	Dlaczego w praktyce łączy się szyfry symetryczne i asymetryczne?	Dla szybkości i bezpieczeństwa	Dla wygody	Dla szybkości i bezpieczeństwa	Dla kompatybilności	Bez powodu	1	1	2026-03-18 19:57:58
257	Kryptografia	Czym jest kryptografia?	Ukrywaniem informacji	Kompresją danych	Ukrywaniem informacji	Usuwaniem danych	Szyfrowaniem tylko haseł	1	1	2026-03-18 19:57:58
258	Kryptografia	Co to jest tekst jawny?	Wiadomość przed szyfrowaniem	Zaszyfrowana wiadomość	Klucz szyfrujący	Wiadomość przed szyfrowaniem	Hasło	2	1	2026-03-18 19:57:58
259	Kryptografia	Do czego służy klucz publiczny?	Do szyfrowania	Do odszyfrowania	Do szyfrowania	Do usuwania danych	Do łamania szyfrów	1	1	2026-03-18 19:57:58
260	Kryptografia	Kto zna klucz prywatny?	Tylko odbiorca	Każdy użytkownik	Tylko odbiorca	Tylko nadawca	Nikt	1	1	2026-03-18 19:57:58
261	Kryptografia	Co oznacza 29 mod 26?	3	1	2	3	4	2	1	2026-03-18 19:57:58
262	Kryptografia	Szyfr Cezara polega na:	Przesuwaniu liter	Zamianie liter na liczby	Przesuwaniu liter	Mnożeniu liter	Usuwaniu liter	1	1	2026-03-18 19:57:58
263	Kryptografia	W szyfrze Cezara kluczem jest:	Liczba przesunięcia	Liczba przesunięcia	Tekst	Hasło	Tabela	0	1	2026-03-18 19:57:58
264	Kryptografia	Który zapis jest poprawny dla szyfru Cezara?	C = (P + k) mod 26	C = P × k	C = (P + k) mod 26	C = P - k	C = k²	1	1	2026-03-18 19:57:58
265	Kryptografia	W szyfrze afinicznym wymagane jest, aby:	a było względnie pierwsze z 26	a = 0	a było parzyste	a było względnie pierwsze z 26	b = 1	2	1	2026-03-18 19:57:58
266	Kryptografia	Co to jest odwrotność modulo?	Liczba, która daje 1 w modulo	Liczba ujemna	Liczba odwrotna (1/x)	Liczba, która daje 1 w modulo	Reszta z dzielenia	2	12026-03-18 19:57:58
267	Kryptografia	W RSA liczba n to:	p × q	p + q	p × q	p - q	p²	1	1	2026-03-18 19:57:58
268	Kryptografia	Funkcja φ(n) w RSA to:	(p-1)(q-1)	p + q	p × q	(p-1)(q-1)	p²	2	1	2026-03-18 19:57:58
269	Kryptografia	Co robi funkcja skrótu (hash)?	Tworzy skrót danych	Szyfruje tekst	Kompresuje dane	Tworzy skrót danych	Usuwa dane	2	1	2026-03-18 19:57:58
270	Kryptografia	Funkcja hash jest:	Nieodwracalna	Odwracalna	Częściowo odwracalna	Nieodwracalna	Losowa	2	1	2026-03-18 19:57:58
271	Kryptografia	Podpis cyfrowy służy do:	Potwierdzania tożsamości	Szyfrowania plików	Usuwania danych	Potwierdzania tożsamości	Kompresji	2	1	2026-03-18 19:57:58
272	Kryptografia	W podpisie cyfrowym używa się:	Obu kluczy	Tylko klucza publicznego	Tylko klucza prywatnego	Obu kluczy	Żadnego	2	1	2026-03-18 19:57:58
273	Kryptografia	Co oznacza brute force?	Sprawdzanie wszystkich możliwości	Zgadywanie losowe	Sprawdzanie wszystkich możliwości	Łamanie hasła jednym kliknięciem	Szyfrowanie	1	1	2026-03-18 19:57:58
274	Kryptografia	Atak słownikowy polega na:	Sprawdzaniu popularnych haseł	Losowaniu znaków	Analizie częstotliwości	Sprawdzaniu popularnych haseł	Szyfrowaniu danych	21	2026-03-18 19:57:58
275	Kryptografia	HTTPS służy do:	Bezpiecznego połączenia	Przyspieszania internetu	Bezpiecznego połączenia	Kompresji danych	Zapisu plików	1	1	2026-03-18 19:57:58
276	Kryptografia	Certyfikat zawiera:	Klucz publiczny	Hasło użytkownika	Klucz publiczny	Klucz prywatny	Pliki	1	1	2026-03-18 19:57:58
277	Operacje logiczne	Jaki jest wynik operacji: 1 AND 0?	0	0	1	2	Nieokreslony	0	1	2026-03-18 20:13:50
278	Operacje logiczne	Jaki jest wynik operacji: 1 OR 0?	1	0	1	Nieokreslony	2	1	1	2026-03-18 20:13:50
279	Operacje logiczne	Jaki jest wynik operacji: NOT 1?	0	0	1	2	Nieokreslony	0	1	2026-03-18 20:13:50
280	Operacje logiczne	Jaki jest wynik operacji: 0 XOR 0?	0	0	1	2	Nieokreslony	0	1	2026-03-18 20:13:50
281	Operacje logiczne	Jaki jest wynik operacji: 1 XOR 1?	0	0	1	2	Nieokreslony	0	1	2026-03-18 20:13:50
282	Operacje logiczne	Jaki jest wynik operacji: 1 XOR 0?	1	0	1	2	Nieokreslony	1	1	2026-03-18 20:13:50
283	Operacje logiczne	Operacja AND zwraca 1 tylko wtedy, gdy:	Oba argumenty wynosa 1	Chociaz jeden argument wynosi 1	Oba argumenty wynosa 1	Argumenty sa rozne	Chociaz jeden argument wynosi 0	1	1	2026-03-18 20:13:50
284	Operacje logiczne	Operacja OR zwraca 0 tylko wtedy, gdy:	Oba argumenty wynosa 0	Chociaz jeden argument wynosi 0	Oba argumenty wynosa 0	Argumenty sa rozne	Chociaz jeden argument wynosi 1	1	1	2026-03-18 20:13:50
285	Operacje logiczne	Operacja XOR zwraca 1 wtedy, gdy:	Argumenty sa rozne	Oba argumenty wynosa 1	Oba argumenty wynosa 0	Argumenty sa rozne	Chociaz jeden wynosi 12	1	2026-03-18 20:13:50
286	Operacje logiczne	Ktora z bramek logicznych realizuje funkcje NOT?	Inwerter	Inwerter	Bramka AND	Bramka OR	Bramka XOR	0	1	2026-03-18 20:13:50
287	Operacje logiczne	Ile wynosi: (1 AND 1) OR 0?	1	0	1	2	Nieokreslony	1	1	2026-03-18 20:13:50
288	Operacje logiczne	Ile wynosi: NOT (1 AND 0)?	1	0	1	2	Nieokreslony	1	1	2026-03-18 20:13:50
289	Operacje logiczne	Ile wynosi: (0 OR 0) AND 1?	0	0	1	2	Nieokreslony	0	1	2026-03-18 20:13:50
290	Operacje logiczne	Ile wynosi: 1 NAND 1?	0	0	1	Nieokreslony	2	0	1	2026-03-18 20:13:50
291	Operacje logiczne	Ile wynosi: 0 NOR 0?	1	0	1	2	Nieokreslony	1	1	2026-03-18 20:13:50
292	Operacje logiczne	Operacja NAND to skrot od:	NOT AND	NOT AND	NO AND	NEGATIVE AND	NEVER AND	0	1	2026-03-18 20:13:50
293	Operacje logiczne	Prawa De Morgana mowia, ze NOT (A AND B) jest rowne:	NOT A OR NOT B	NOT A AND NOT B	NOT A OR NOT B	A OR B	NOT A XOR NOT B	1	1	2026-03-18 20:13:50
294	Operacje logiczne	Prawa De Morgana mowia, ze NOT (A OR B) jest rowne:	NOT A AND NOT B	NOT A OR NOT B	NOT A AND NOT B	A AND B	NOT A XOR NOT B	1	1	2026-03-18 20:13:50
295	Operacje logiczne	W tablicy prawdy dla AND z dwoma argumentami, ile wierszy daje wynik 1?	1	1	2	3	4	0	1	2026-03-18 20:13:50
296	Operacje logiczne	Ktora operacja logiczna jest podstawa szyfrowania XOR?	XOR (alternatywa wykluczajaca)	AND	OR	XOR (alternatywa wykluczajaca)	NOT	2	1	2026-03-18 20:13:50
297	Grafika komputerowa	Z czego zbudowany jest obraz rastrowy?	Z pikseli	Z wektorow	Z pikseli	Z ksztalow geometrycznych	Z rownan matematycznych	1	1	2026-03-18 20:13:50
298	Grafika komputerowa	Jaka jest glowna wada grafiki rastrowej przy powiekszaniu?	Traci jakosc i staje sie pikselowa	Zwieksza sie rozmiar pliku	Traci jakosc i staje sie pikselowa	Zmienia sie kolor	Spowalnia komputer	1	1	2026-03-18 20:13:50
299	Grafika komputerowa	Grafika wektorowa zbudowana jest z:	Rownan matematycznych i ksztaltow geometrycznych	Pikseli	Kolorow RGB	Rownan matematycznych i ksztaltow geometrycznych	Bitow	2	1	2026-03-18 20:13:50
300	Grafika komputerowa	Ktory format jest typowy dla grafiki wektorowej?	SVG	JPG	PNG	BMP	SVG	3	1	2026-03-18 20:13:50
301	Grafika komputerowa	Co oznacza skrot RGB?	Red, Green, Blue	Red, Green, Blue	Red, Gray, Black	Raster, Grid, Bitmap	Resolution, Gamma, Brightness	0	12026-03-18 20:13:50
302	Grafika komputerowa	Model barw RGB jest modelem:	Addytywnym (swiatlem)	Subtraktywnym (farba)	Addytywnym (swiatlem)	Mieszanym	Monochromatycznym	1	1	2026-03-18 20:13:50
303	Grafika komputerowa	Model CMYK stosowany jest glownie w:	Druku	Monitorach	Druku	Skanowaniu	Grach komputerowych	1	1	2026-03-18 20:13:50
304	Grafika komputerowa	Co oznacza litera K w skrocie CMYK?	Czarny (black)	Kolor	Kontrast	Czarny (black)	Keystone	2	1	2026-03-18 20:13:50
305	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (255, 0, 0)?	Czerwony	Czerwony	Zielony	Niebieski	Bialy	0	1	2026-03-18 20:13:50
306	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (255, 255, 255)?	Bialy	Czarny	Bialy	Szary	Zolty	1	1	2026-03-18 20:13:50
307	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (0, 0, 0)?	Czarny	Czarny	Bialy	Szary	Przezroczysty	0	1	2026-03-18 20:13:50
308	Grafika komputerowa	Co oznacza DPI w grafice komputerowej?	Liczba punktow na cal (dots per inch)	Digital Picture Index	Liczba punktow na cal (dots per inch)	Display Pixel Information	Data Processing Interface	1	1	2026-03-18 20:13:50
309	Grafika komputerowa	Co oznacza PPI?	Liczba pikseli na cal (pixels per inch)	Liczba punktow na cal	Liczba pikseli na cal (pixels per inch)	Przenosny format obrazu	Protokol przetwarzania obrazu	1	1	2026-03-18 20:13:50
310	Grafika komputerowa	Czym jest kanal alfa w grafice komputerowej?	Kanalem przezroczystosci	Kanalem czerwonym	Kanalem zielonym	Kanalem przezroczystosci	Kanalem jasnosci	2	1	2026-03-18 20:13:50
311	Grafika komputerowa	Ile kolorow opisuje 24-bitowy model RGB?	16 777 216	256	65 536	1 048 576	16 777 216	3	1	2026-03-18 20:13:50
312	Grafika komputerowa	Model HSB/HSV opisuje kolory za pomoca:	Odcieniu, nasyceniu i jasnosci	Czerwonego, zielonego i niebieskiego	Cyan, Magenta i Yellow	Odcieniu, nasyceniu i jasnosci	Jasnosci, kontrastu i nasycenia	2	1	2026-03-18 20:13:50
313	Grafika komputerowa	Ktory model barw najlepiej odpowiada widzeniu ludzkiego oka?	HSB/HSL	RGB	CMYK	HSB/HSL	CMY	2	1	2026-03-18 20:13:50
314	Grafika komputerowa	Kompresja bezstratna oznacza, ze:	Zadne dane nie sa tracone przy kompresji	Obraz traci jakosc	Zadne dane nie sa tracone przy kompresji	Plik jest mniejszy o polowe	Kolor jest uproszczony	1	1	2026-03-18 20:13:50
315	Grafika komputerowa	Ktory program jest przykladem edytora grafiki rastrowej?	Adobe Photoshop	Adobe Illustrator	CorelDRAW	Adobe Photoshop	Inkscape	2	12026-03-18 20:13:50
316	Grafika komputerowa	Rozdzielczosc obrazu 1920x1080 oznacza:	Liczbe pikseli w poziomie i pionie	Rozmiar pliku	Liczbe kolorow	Liczbe pikseli w poziomie i pionie	Gestosc wydruku	2	1	2026-03-18 20:13:50
317	Formaty plikow	Ktory format graficzny stosuje kompresje stratna?	JPG/JPEG	PNG	BMP	JPG/JPEG	TIFF	2	1	2026-03-18 20:13:50
318	Formaty plikow	Ktory format graficzny obsluguje przezroczystosc?	PNG	JPG	PNG	BMP	GIF tylko dla animacji	1	1	2026-03-18 20:13:50
319	Formaty plikow	Format BMP charakteryzuje sie:	Brakiem kompresji i duzym rozmiarem pliku	Mala waga pliku	Brakiem kompresji i duzym rozmiarem pliku	Obsluga animacji	Stratna kompresja	1	1	2026-03-18 20:13:50
320	Formaty plikow	Do czego sluzy format PDF?	Do prezentacji dokumentow niezaleznie od systemu	Do edycji tekstu	Do przechowywania bazy danych	Do prezentacji dokumentow niezaleznie od systemu	Do zapisu wideo	2	1	2026-03-18 20:13:50
321	Formaty plikow	Ktory format plikow audio jest bezstratny?	WAV/FLAC	MP3	AAC	OGG	WAV/FLAC	3	1	2026-03-18 20:13:50
322	Formaty plikow	Format MP3 to format:	Dzwiekowy ze stratna kompresja	Graficzny	Wideo	Dzwiekowy ze stratna kompresja	Tekstowy	2	1	2026-03-18 20:13:50
323	Formaty plikow	Format MP4 sluzy do zapisu:	Wideo i audio	Tylko wideo	Tylko audio	Wideo i audio	Grafiki	2	1	2026-03-18 20:13:50
324	Formaty plikow	Format DOCX to format plikow:	Dokumentow tekstowych (Microsoft Word)	Dokumentow tekstowych (Microsoft Word)	Arkuszy kalkulacyjnych	Prezentacji	Baz danych	01	2026-03-18 20:13:50
325	Formaty plikow	Format XLSX to format plikow:	Arkuszy kalkulacyjnych (Microsoft Excel)	Dokumentow tekstowych	Arkuszy kalkulacyjnych (Microsoft Excel)	Prezentacji	Grafiki	1	1	2026-03-18 20:13:50
326	Formaty plikow	Format ZIP sluzy do:	Kompresji i archiwizacji plikow	Szyfrowania danych	Kompresji i archiwizacji plikow	Tworzenia kopii zapasowych	Edycji plikow	1	12026-03-18 20:13:50
327	Formaty plikow	Co to jest format SVG?	Wektorowy format grafiki oparty na XML	Wektorowy format grafiki oparty na XML	Rastrowy format fotografii	Format wideo	Format dzwiekowy	0	1	2026-03-18 20:13:50
328	Formaty plikow	Ktory format jest otwarty i powszechnie stosowany do dokumentow?	ODF (Open Document Format)	DOCX	ODF (Open Document Format)	PDF	TXT	1	12026-03-18 20:13:50
329	Formaty plikow	Format GIF obsluguje:	Animacje i przezroczystosc (256 kolorow)	Pelna pale barw bez animacji	Stratna kompresje fotografii	Animacje i przezroczystosc (256 kolorow)	Tylko statyczne obrazy	2	1	2026-03-18 20:13:50
330	Formaty plikow	Ktory format pliku tekstowego jest najprostszy i nie zawiera formatowania?	TXT	TXT	DOCX	RTF	HTML	0	1	2026-03-18 20:13:50
331	Formaty plikow	Format HTML sluzy do:	Tworzenia stron internetowych	Zapisu danych bazy danych	Tworzenia stron internetowych	Kompresji plikow	Edycji grafiki	1	12026-03-18 20:13:50
332	Prawa autorskie	Od kiedy dzielo jest chronione prawem autorskim?	Od chwili jego powstania	Od chwili rejestracji	Od chwili jego powstania	Od momentu publikacjiOd daty przyznania certyfikatu	1	1	2026-03-18 20:13:50
333	Prawa autorskie	Jak dlugo trwaja majatkowe prawa autorskie po smierci autora?	70 lat	10 lat	50 lat	70 lat	100 lat	2	1	2026-03-18 20:13:50
334	Prawa autorskie	Autorskie prawa osobiste sa:	Niezbywalne i wieczyste	Zbywalne po smierci	Niezbywalne i wieczyste	Wygasaja po 70 latach	Mozliwe do przekazania notarialnie	11	2026-03-18 20:13:50
335	Prawa autorskie	Co oznacza prawo do ojcostwa utworu?	Prawo autora do oznaczenia dziela swoim nazwiskiem	Prawo do sprzedazy dziela	Prawo do kopiowania dziela	Prawo autora do oznaczenia dziela swoim nazwiskiem	Prawo do zmiany tresci dziela	2	1	2026-03-18 20:13:50
336	Prawa autorskie	Co reguluje prawo autorskie w Polsce?	Ustawa z dnia 4 lutego 1994 r. o prawie autorskim i prawach pokrewnych	Kodeks karny	Ustawa z dnia 4 lutego 1994 r. o prawie autorskim i prawach pokrewnych	Kodeks cywilny	Konstytucja RP	1	1	2026-03-18 20:13:50
337	Prawa autorskie	Czy program komputerowy jest chroniony prawem autorskim?	Tak, od momentu powstania	Nie, wymaga patentu	Tak, od momentu powstania	Tylko jesli jest zarejestrowany	Tylko komercyjny	1	1	2026-03-18 20:13:50
338	Prawa autorskie	Czym jest dozwolony uzytek?	Prawem do korzystania z utworu na wlasny uzytek bez zgody autora	Mozliwoscia kopiowania na sprzedaz	Prawem do korzystania z utworu na wlasny uzytek bez zgody autora	Zgoda na publiczne wyswietlanie	Mozliwoscia modyfikacji chronionych programow	1	1	2026-03-18 20:13:50
339	Prawa autorskie	Czy mozna legalnie zrobic kopie zapasowa legalnie zakupionego programu?	Tak, jesli jest niezbedna do korzystania z programu	Tak, bez ograniczen	Nie, to naruszenie praw autorskich	Tak, jesli jest niezbedna do korzystania z programu	Tylko za zgoda producenta	2	1	2026-03-18 20:13:50
340	Prawa autorskie	Czym jest domena publiczna?	Zbiorem utworow, do ktorych wygasly prawa majatkowe	Stronami internetowymi bez wlasciciela	Zbiorem utworow, do ktorych wygasly prawa majatkowe	Darmowymi programami	Zasobami rzadowymi	1	1	2026-03-18 20:13:50
341	Prawa autorskie	Czy usuniecie znaku wodnego ze zdjeciaw zamieswiedzie w sieci jest legalne?	Nie, to naruszenie autorskich praw osobistych	Tak, jesli zdjecie jest darmowe	Nie, to naruszenie autorskich praw osobistych	Tak, jesli nie jest sprzedawane	Tylko w celach edukacyjnych	1	1	2026-03-18 20:13:50
342	Prawa autorskie	Majatkowe prawa autorskie mozna:	Przeniesc na inna osobe lub udzielic licencji	Przeniesc, ale nie mozna udzielic licencji	Przeniesc na inna osobe lub udzielic licencji	Zbyc tylko posmiertnie	Sprzedac tylko instytucjom	1	1	2026-03-18 20:13:50
343	Licencje	Co oznacza licencja Freeware?	Program darmowy, ale bez dostepu do kodu zrodlowego	Program darmowy z kodem zrodlowym	Program darmowy, ale bez dostepu do kodu zrodlowego	Program platny z bezplatnym okresem probnym	Program na licencji GNU GPL	1	1	2026-03-18 20:13:50
344	Licencje	Co oznacza licencja Shareware?	Program w wersji probnej z ograniczeniami	Program calkowicie darmowy	Program z otwartym kodem	Program w wersji probnej z ograniczeniami	Program bez zadnych ograniczen	2	1	2026-03-18 20:13:50
345	Licencje	Co charakteryzuje licencje GNU GPL?	Mozliwosc korzystania, modyfikowania i dystrybucji z udostepnieniem kodu zrodlowego	Mozliwosc korzystania bez udostepniania zrodel	Mozliwosc korzystania, modyfikowania i dystrybucji z udostepnieniem kodu zrodlowego	Ograniczone korzystanie tylko do celow niekomercyjnych	Calkowity zakaz modyfikacji	11	2026-03-18 20:13:50
346	Licencje	Open source oznacza, ze:	Kod zrodlowy jest dostepny publicznie	Program jest darmowy	Program dziala w przegladarce	Kod zrodlowy jest dostepny publicznieNikt nie ma praw autorskich	2	1	2026-03-18 20:13:50
347	Licencje	Licencja Creative Commons (CC) dotyczy glownie:	Tresci kreatywnych (muzyki, grafiki, tekstow)	Tylko oprogramowania	Tylko fotografii	Tresci kreatywnych (muzyki, grafiki, tekstow)	Tylko baz danych	2	1	2026-03-18 20:13:50
348	Licencje	Co oznacza licencja CC BY?	Mozna uzywac dziela pod warunkiem podania autorstwa	Mozna uzywac dziela bez zadnych warunkow	Mozna uzywac dziela pod warunkiem podania autorstwa	Mozna uzywac dziela tylko niekomercyjnie	Nie mozna modyfikowac dziela	1	1	2026-03-18 20:13:50
349	Licencje	Co oznacza klauzula SA (ShareAlike) w licencji Creative Commons?	Modyfikacje musza byc na tej samej licencji	Dzelo mozna udostepniac tylko nieodplatnie	Modyfikacje musza byc na tej samej licencji	Nie mozna tworzyc dziel zaleznych	Nalezy podac autora	1	1	2026-03-18 20:13:50
350	Licencje	Co oznacza licencja Adware?	Program darmowy finansowany reklama	Program platny bez reklam	Program darmowy finansowany reklama	Program z otwartym kodem	Program na licencji GPL	1	1	2026-03-18 20:13:50
351	Licencje	Ktora licencja najczesciej chroni systemy Linux?	GNU GPL	MIT	BSD	GNU GPL	Apache	2	1	2026-03-18 20:13:50
352	Licencje	Czym rozni sie licencja Open Source od Freeware?	Open source udostepnia kod zrodlowy, Freeware nie	Freeware jest droższy	Open source jest platny, Freeware nie	Open source udostepnia kod zrodlowy, Freeware nie	Nie ma roznicy	2	1	2026-03-18 20:13:50
353	Dane osobowe	Co to sa dane osobowe?	Informacje umozliwiajace identyfikacje konkretnej osoby fizycznej	Tylko imie i nazwisko	Tylko numer PESEL	Informacje umozliwiajace identyfikacje konkretnej osoby fizycznej	Tylko dane medyczne	2	1	2026-03-18 20:13:50
354	Dane osobowe	Skrot RODO oznacza:	Rozporzadzenie o Ochronie Danych Osobowych (unijne)	Rejestr Osob Danych Osobowych	Rozporzadzenie o Ochronie Danych Osobowych (unijne)	Regulamin Ochrony Danych Osobowych	Rejestr Ochrony Danych Osobistych	1	1	2026-03-18 20:13:50
355	Dane osobowe	W ktorym roku weszlo w zycie RODO?	2018	2014	2016	2018	2020	2	1	2026-03-18 20:13:50
356	Dane osobowe	Ktory organ nadzoruje ochrone danych osobowych w Polsce?	UODO (Urzad Ochrony Danych Osobowych)	GUS	UODO (Urzad Ochrony Danych Osobowych)	NIK	KNF	11	2026-03-18 20:13:50
357	Dane osobowe	Czy adres e-mail jest dana osobowa?	Tak, jesli pozwala zidentyfikowac osobe	Nie, to tylko adres techniczny	Tak, jesli pozwala zidentyfikowac osobe	Tylko firmowy adres e-mail	Tylko jesli zawiera nazwisko	1	1	2026-03-18 20:13:50
358	Dane osobowe	Jakie jest prawo do bycia zapomnianym?	Prawo do zadania usuniecia swoich danych osobowych	Prawo do zachowania prywatnosci w internecie	Prawo do usuniecia konta bankowego	Prawo do zadania usuniecia swoich danych osobowych	Prawo do anonimowosci w sieci	2	1	2026-03-18 20:13:50
359	Dane osobowe	Kto jest administratorem danych osobowych?	Podmiot decydujacy o celach i sposobach przetwarzania danych	Podmiot decydujacy o celach i sposobach przetwarzania danych	Osoba, ktora wprowadza dane do systemu	Organ panstwowy nadzorujacy bazy danych	Uzytkownik przekazujacy dane	0	1	2026-03-18 20:13:50
360	Dane osobowe	Co to jest zgoda na przetwarzanie danych osobowych?	Dobrowolne, swiadome wyrazenie zgody na przetwarzanie danych	Automatyczna zgoda przy rejestracji	Dobrowolne, swiadome wyrazenie zgody na przetwarzanie danych	Zgoda wymagana tylko dla danych medycznych	Milczaca akceptacja regulaminu	1	1	2026-03-18 20:13:50
361	Dane osobowe	Czy numer IP komputera moze byc dana osobowa?	Tak, w polaczeniu z innymi danymi	Nie, to tylko adres techniczny	Tak, w polaczeniu z innymi danymi	Tylko statyczny adres IP	Tylko w przypadku firm	1	1	2026-03-18 20:13:50
362	Dane osobowe	Dane wrazliwe (szczegolne kategorie danych) obejmuja m.in.:	Dane o zdrowiu, przekonaniach religijnych, orientacji seksualnej	Imie i nazwisko oraz adres	Dane o zdrowiu, przekonaniach religijnych, orientacji seksualnej	Numer telefonu i adres e-mail	Dane konta bankowego	1	1	2026-03-18 20:13:50
363	Piractwo	Co to jest piractwo komputerowe?	Nielegalne kopiowanie i dystrybucja oprogramowania lub tresci chronionych	Wlamywanie sie do komputerow	Nielegalne kopiowanie i dystrybucja oprogramowania lub tresci chronionych	Kradziez sprzetu komputerowego	Uzywanie programow bez internetu	1	1	2026-03-18 20:13:50
364	Piractwo	Jakie sa konsekwencje prawne piractwa komputerowego w Polsce?	Kara grzywny lub pozbawienia wolnosci	Tylko upomnienie	Kara grzywny lub pozbawienia wolnosciTylko zakaz korzystania z komputera	Brak konsekwencji przy wlasnym uzyciu	1	1	2026-03-18 20:13:50
365	Piractwo	Czy sciaganie plikow z nielegalnych zrodel jest przestepstwem?	Tak, narusza prawa autorskie	Nie, pobieranie jest legalne	Tylko jesli sie udostepnia dalej	Tak, narusza prawa autorskie	Tylko jesli pliki sa komercyjne	2	1	2026-03-18 20:13:50
366	Piractwo	Co to jest warez?	Nielegalne oprogramowanie dystrybuowane z pominiecia licencji	Legalne oprogramowanie demonstracyjne	Nielegalne oprogramowanie dystrybuowane z pominiecia licencji	Otwarty kod zrodlowy	Oprogramowanie edukacyjne	1	1	2026-03-18 20:13:50
367	Piractwo	Krakowanie oprogramowania polega na:	Usuwaniu lub obchodzeniu zabezpieczen licencyjnych	Optymalizacji kodu programu	Usuwaniu lub obchodzeniu zabezpieczen licencyjnych	Tworzeniu kopii zapasowej	Aktualizacji oprogramowania	1	1	2026-03-18 20:13:50
368	Piractwo	Jakie szkody powoduje piractwo dla tworcow oprogramowania?	Utrate przychodow ze sprzedazy i brak srodkow na rozwoj	Utrate przychodow ze sprzedazy i brak srodkow na rozwoj	Tylko reputacyjne	Zadnych, bo i tak uzytkownik by nie kupil	Tylko jesli jest na duza skale	0	1	2026-03-18 20:13:50
369	Piractwo	Torrenty same w sobie sa:	Technologia transferu plikow, legalna lub nielegalna zalezna od tresci	Zawsze nielegalne	Technologia transferu plikow, legalna lub nielegalna zalezna od tresci	Zawsze legalne	Zabronione przez prawo polskie	1	1	2026-03-18 20:13:50
370	Piractwo	Czym jest keygen?	Programem generujacym nielegalne klucze seryjne	Oficjalnym generatorem kluczy producenta	Programem generujacym nielegalne klucze seryjne	Narzedziem do zarzadzania licencjami	Programem szyfrujacym dane	1	1	2026-03-18 20:13:50
371	Piractwo	Czy udostepnianie zakupionego ebooka znajomym bez zgody wydawcy jest legalne?	Nie, narusza majatkowe prawa autorskie	Tak, to dozwolony uzytek osobisty	Nie, narusza majatkowe prawa autorskie	Tak, jesli nie jest pobierana oplata	Tylko wersji papierowej	1	1	2026-03-18 20:13:50
372	Piractwo	Programy DRM (Digital Rights Management) sluza do:	Ochrony tresci cyfrowych przed nieautoryzowanym kopiowaniem	Zarzadzania danymi osobowymi	Ochrony tresci cyfrowych przed nieautoryzowanym kopiowaniem	Kompresji plikow multimedialnych	Szyfrowania komunikacji	1	1	2026-03-18 20:13:50

=== DANE: quiz_results ===
id	session_id	question_id	category	question_text	is_correct	time_ms	answered_at
89	sess_1773858814644_bxxtcfy	63	Bezpieczeństwo IT	Co to jest Ransomware?	0	8952	2026-03-18 19:34:23
90	sess_1773858814644_bxxtcfy	66	Bezpieczeństwo IT	Co to jest Keylogger?	1	6401	2026-03-18 19:34:31
91	sess_1773858814644_bxxtcfy	185	Złożoność obliczeniowa	Jaka jest złożoność czasowa sortowania bąbelkowego (bubble sort)?	1	5529	2026-03-18 19:34:38
92	sess_1773858814644_bxxtcfy	64	Bezpieczeństwo IT	Do czego służy Spyware?	1	7307	2026-03-18 19:34:47
93	sess_1773858814644_bxxtcfy	68	Algorytmy	Czym jest algorytm?	1	6648	2026-03-18 19:34:55
94	sess_1773858814644_bxxtcfy	89	Systemy liczbowe	Jak zapisujemy liczbę 13₁₀ w systemie binarnym?	1	8900	2026-03-18 19:35:06
95	sess_1773858814644_bxxtcfy	97	Bazy danych	Co to jest JOIN w SQL?	1	9196	2026-03-18 19:35:16
96	sess_1773858814644_bxxtcfy	101	Architektura komputera	Co to jest cache procesora?	1	4765	2026-03-18 19:35:23
97	sess_1773858814644_bxxtcfy	82	Złożoność obliczeniowa	Co to jest złożoność pamięciowa algorytmu?	0	12135	2026-03-18 19:35:37
98	sess_1773858814644_bxxtcfy	15	Protokoły sieciowe	Jaka jest relacja między TLS a SSL?	0	12648	2026-03-18 19:35:51
99	sess_1773858814644_bxxtcfy	70	Algorytmy	Co to jest rekurencja?	1	7432	2026-03-18 19:36:00
100	sess_1773858814644_bxxtcfy	211	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	6596	2026-03-18 19:36:08
101	sess_1773858814644_bxxtcfy	65	Bezpieczeństwo IT	Co to jest Rootkit?	1	10048	2026-03-18 19:36:20
102	sess_1773485427401_dkig00i	149	Języki programowania	Czym są języki niskopoziomowe?	0	15000	2026-03-18 20:57:13
103	sess_1773485427401_dkig00i	59	Bezpieczeństwo IT	Co to jest Malware?	0	1450	2026-03-18 20:57:34
104	sess_1773485427401_dkig00i	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	0	15000	2026-03-18 21:21:45
105	sess_1773485427401_dkig00i	237	Kryptografia	Dlaczego szyfr Cezara jest uznawany za słaby?	0	15000	2026-03-18 21:22:01
106	sess_1773485427401_dkig00i	199	Bazy danych	Czym różni się DELETE od DROP?	0	2591	2026-03-18 21:30:37
107	sess_1773485427401_dkig00i	356	Dane osobowe	Ktory organ nadzoruje ochrone danych osobowych w Polsce?	0	2214	2026-03-18 21:30:40
108	sess_1773858814644_bxxtcfy	177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	0	10827	2026-03-18 21:40:41
109	sess_1773858814644_bxxtcfy	193	Systemy liczbowe	Ile cyfr używa system ósemkowy (oktalny)?	1	8918	2026-03-18 21:40:51
110	sess_1773858814644_bxxtcfy	198	Systemy liczbowe	Do czego służy system szesnastkowy (hex) w informatyce?	0	13010	2026-03-18 21:41:06
111	sess_1773858814644_bxxtcfy	371	Piractwo	Czy udostepnianie zakupionego ebooka znajomym bez zgody wydawcy jest legalne?	1	8165	2026-03-18 21:41:16
112	sess_1773858814644_bxxtcfy	161	Sieci komputerowe	Co to jest MAN?	1	7489	2026-03-18 21:41:25
113	sess_1773858814644_bxxtcfy	176	Algorytmy	Czym jest algorytm?	1	5004	2026-03-18 21:41:32
114	sess_1773858814644_bxxtcfy	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	8126	2026-03-18 21:41:42
115	sess_1773858814644_bxxtcfy	101	Architektura komputera	Co to jest cache procesora?	1	5216	2026-03-18 21:41:48
116	sess_1773858814644_bxxtcfy	370	Piractwo	Czym jest keygen?	0	6382	2026-03-18 21:41:56
117	sess_1773858814644_bxxtcfy	49	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	1	8320	2026-03-18 21:42:06
118	sess_1773858814644_bxxtcfy	211	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	8162	2026-03-18 21:42:16
119	sess_1773858814644_bxxtcfy	107	Prawo informatyczne	Czym jest cyberprzestępstwo?	1	6331	2026-03-18 21:42:24
120	sess_1773858814644_bxxtcfy	372	Piractwo	Programy DRM (Digital Rights Management) sluza do:	1	7295	2026-03-18 21:42:33
121	sess_1773858814644_bxxtcfy	163	Sieci komputerowe	Czym się różni Switch od Hub?	1	11505	2026-03-18 21:42:46
122	sess_1773858814644_bxxtcfy	68	Algorytmy	Czym jest algorytm?	1	4658	2026-03-18 21:42:52
123	sess_1773858814644_bxxtcfy	125	Protokoły sieciowe	Czym jest serwer Proxy?	1	6782	2026-03-18 21:43:01
124	sess_1773858814644_bxxtcfy	364	Piractwo	Jakie sa konsekwencje prawne piractwa komputerowego w Polsce?	1	9665	2026-03-18 21:43:12
125	sess_1773858814644_bxxtcfy	99	Architektura komputera	Różnica RAM vs ROM?	0	10232	2026-03-18 21:43:24
126	sess_1773858814644_bxxtcfy	209	Architektura komputera	Co to jest cache procesora?	1	3782	2026-03-18 21:43:29
127	sess_1773858814644_bxxtcfy	188	Złożoność obliczeniowa	Dlaczego binary search ma złożoność O(log n)?	1	10273	2026-03-18 21:43:41
128	sess_1773870315518_mtnp5xp	322	Formaty plikow	Format MP3 to format:	1	6970	2026-03-18 21:45:31
129	sess_1773870315518_mtnp5xp	176	Algorytmy	Czym jest algorytm?	0	3313	2026-03-18 21:45:36
130	sess_1773870315518_mtnp5xp	302	Grafika komputerowa	Model barw RGB jest modelem:	0	5392	2026-03-18 21:45:43
131	sess_1773870315518_mtnp5xp	178	Algorytmy	Co to jest rekurencja?	1	3675	2026-03-18 21:45:49
132	sess_1773870315518_mtnp5xp	179	Algorytmy	Czym różni się BFS od DFS w grafach?	1	9161	2026-03-18 21:46:01
133	sess_1773870315518_mtnp5xp	319	Formaty plikow	Format BMP charakteryzuje sie:	1	7035	2026-03-18 21:46:08
134	sess_1773870315518_mtnp5xp	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	8156	2026-03-18 21:46:18
135	sess_1773870315518_mtnp5xp	68	Algorytmy	Czym jest algorytm?	1	5011	2026-03-18 21:46:26
136	sess_1773870315518_mtnp5xp	328	Formaty plikow	Ktory format jest otwarty i powszechnie stosowany do dokumentow?	1	4285	2026-03-18 21:46:30
137	sess_1773870315518_mtnp5xp	74	Algorytmy	Co to jest programowanie dynamiczne?	1	7410	2026-03-18 21:46:39
138	sess_1773870315518_mtnp5xp	304	Grafika komputerowa	Co oznacza litera K w skrocie CMYK?	0	12099	2026-03-18 21:46:53
139	sess_1773870315518_mtnp5xp	356	Dane osobowe	Ktory organ nadzoruje ochrone danych osobowych w Polsce?	1	7431	2026-03-18 21:47:02
140	sess_1773870315518_mtnp5xp	177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	6332	2026-03-18 21:47:10
141	sess_1773870315518_mtnp5xp	72	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	1	8048	2026-03-18 21:47:25
142	sess_1773870315518_mtnp5xp	326	Formaty plikow	Format ZIP sluzy do:	1	2309	2026-03-18 21:47:26
143	sess_1773870315518_mtnp5xp	181	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	8859	2026-03-18 21:47:34
144	sess_1773870315518_mtnp5xp	70	Algorytmy	Co to jest rekurencja?	1	7951	2026-03-18 21:47:44
145	sess_1773870315518_mtnp5xp	327	Formaty plikow	Co to jest format SVG?	1	5612	2026-03-18 21:47:51
146	sess_1773870315518_mtnp5xp	183	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	6225	2026-03-18 21:47:59
147	sess_1773870315518_mtnp5xp	180	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	1	7840	2026-03-18 21:48:08
148	sess_1773870315518_mtnp5xp	182	Algorytmy	Co to jest programowanie dynamiczne?	1	4588	2026-03-18 21:48:14
149	sess_1773870315518_mtnp5xp	321	Formaty plikow	Ktory format plikow audio jest bezstratny?	0	4442	2026-03-18 21:48:20
150	sess_1773870315518_mtnp5xp	324	Formaty plikow	Format DOCX to format plikow:	1	3708	2026-03-18 21:48:26
151	sess_1773870315518_mtnp5xp	317	Formaty plikow	Ktory format graficzny stosuje kompresje stratna?	0	3576	2026-03-18 21:48:31
152	sess_1773870315518_mtnp5xp	71	Algorytmy	Czym różni się BFS od DFS w grafach?	1	4652	2026-03-18 21:48:37
153	sess_1773870315518_mtnp5xp	75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	9108	2026-03-18 21:48:48
154	sess_1773870315518_mtnp5xp	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	3089	2026-03-18 21:48:52
155	sess_1773870315518_mtnp5xp	100	Architektura komputera	Co to jest ALU?	1	4575	2026-03-18 21:48:59
156	sess_1773870315518_mtnp5xp	101	Architektura komputera	Co to jest cache procesora?	1	2861	2026-03-18 21:49:03
157	sess_1773870315518_mtnp5xp	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	3539	2026-03-18 21:49:08
158	sess_1773870315518_mtnp5xp	99	Architektura komputera	Różnica RAM vs ROM?	1	6857	2026-03-18 21:49:17
159	sess_1773870315518_mtnp5xp	104	Architektura komputera	Co to jest pamięć wirtualna?	1	7302	2026-03-18 21:49:26
160	sess_1773870315518_mtnp5xp	357	Dane osobowe	Czy adres e-mail jest dana osobowa?	0	8922	2026-03-18 21:49:36
161	sess_1773870315518_mtnp5xp	207	Architektura komputera	Różnica RAM vs ROM?	1	3978	2026-03-18 21:49:42
162	sess_1773870315518_mtnp5xp	103	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	6825	2026-03-18 21:49:50
163	sess_1773870315518_mtnp5xp	208	Architektura komputera	Co to jest ALU?	1	1891	2026-03-18 21:49:54
164	sess_1773870315518_mtnp5xp	325	Formaty plikow	Format XLSX to format plikow:	1	2144	2026-03-18 21:49:58
165	sess_1773870315518_mtnp5xp	211	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	2525	2026-03-18 21:50:02
166	sess_1773870315518_mtnp5xp	358	Dane osobowe	Jakie jest prawo do bycia zapomnianym?	1	10138	2026-03-18 21:50:13
167	sess_1773870315518_mtnp5xp	91	Bazy danych	Czym różni się DELETE od DROP?	1	5544	2026-03-18 21:50:21
168	sess_1773870315518_mtnp5xp	298	Grafika komputerowa	Jaka jest glowna wada grafiki rastrowej przy powiekszaniu?	1	6641	2026-03-18 21:50:29
169	sess_1773870315518_mtnp5xp	355	Dane osobowe	W ktorym roku weszlo w zycie RODO?	0	3141	2026-03-18 21:50:34
170	sess_1773870315518_mtnp5xp	210	Architektura komputera	Co to jest procesor wielordzeniowy?	1	6217	2026-03-18 21:50:41
171	sess_1773870315518_mtnp5xp	361	Dane osobowe	Czy numer IP komputera moze byc dana osobowa?	0	10944	2026-03-18 21:50:54
172	sess_1773870315518_mtnp5xp	323	Formaty plikow	Format MP4 sluzy do zapisu:	0	6005	2026-03-18 21:51:02
173	sess_1773870315518_mtnp5xp	212	Architektura komputera	Co to jest pamięć wirtualna?	1	4623	2026-03-18 21:51:08
174	sess_1773870315518_mtnp5xp	209	Architektura komputera	Co to jest cache procesora?	1	3816	2026-03-18 21:51:13
175	sess_1773870315518_mtnp5xp	92	Bazy danych	Czym jest PRIMARY KEY?	1	3931	2026-03-18 21:51:19
176	sess_1773870315518_mtnp5xp	94	Bazy danych	Co to jest indeks w bazie danych?	1	6962	2026-03-18 21:51:27
177	sess_1773870315518_mtnp5xp	93	Bazy danych	Różnica między WHERE a HAVING?	1	7857	2026-03-18 21:51:37
178	sess_1773870315518_mtnp5xp	359	Dane osobowe	Kto jest administratorem danych osobowych?	1	10804	2026-03-18 21:51:49
179	sess_1773870315518_mtnp5xp	204	Bazy danych	Co to jest transakcja w bazie danych?	1	6958	2026-03-18 21:51:58
180	sess_1773870315518_mtnp5xp	64	Bezpieczeństwo IT	Do czego służy Spyware?	1	6258	2026-03-18 21:52:06
181	sess_1773870315518_mtnp5xp	206	Bazy danych	Co robi polecenie GROUP BY?	1	7325	2026-03-18 21:52:15
182	sess_1773870315518_mtnp5xp	66	Bezpieczeństwo IT	Co to jest Keylogger?	1	2902	2026-03-18 21:52:19
183	sess_1773870315518_mtnp5xp	65	Bezpieczeństwo IT	Co to jest Rootkit?	0	14232	2026-03-18 21:52:35
184	sess_1773870315518_mtnp5xp	205	Bazy danych	Co to jest JOIN w SQL?	1	8398	2026-03-18 21:52:45
185	sess_1773870315518_mtnp5xp	199	Bazy danych	Czym różni się DELETE od DROP?	1	2817	2026-03-18 21:52:49
186	sess_1773870315518_mtnp5xp	201	Bazy danych	Różnica między WHERE a HAVING?	1	2335	2026-03-18 21:52:53
187	sess_1773870315518_mtnp5xp	318	Formaty plikow	Ktory format graficzny obsluguje przezroczystosc?	0	6282	2026-03-18 21:53:01
188	sess_1773870315518_mtnp5xp	331	Formaty plikow	Format HTML sluzy do:	1	5452	2026-03-18 21:53:08
189	sess_1773870315518_mtnp5xp	330	Formaty plikow	Ktory format pliku tekstowego jest najprostszy i nie zawiera formatowania?	0	5905	2026-03-18 21:53:16
190	sess_1773870315518_mtnp5xp	360	Dane osobowe	Co to jest zgoda na przetwarzanie danych osobowych?	1	7624	2026-03-18 21:53:25
191	sess_1773870315518_mtnp5xp	203	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	0	4659	2026-03-18 21:53:31
192	sess_1773870315518_mtnp5xp	329	Formaty plikow	Format GIF obsluguje:	1	8336	2026-03-18 21:53:41
193	sess_1773870315518_mtnp5xp	303	Grafika komputerowa	Model CMYK stosowany jest glownie w:	1	4970	2026-03-18 21:53:48
194	sess_1773870315518_mtnp5xp	200	Bazy danych	Czym jest PRIMARY KEY?	1	4284	2026-03-18 21:53:54
195	sess_1773870315518_mtnp5xp	96	Bazy danych	Co to jest transakcja w bazie danych?	0	15000	2026-03-18 21:54:10
196	test	148	Języki programowania	Co charakteryzuje języki średniopoziomowe?	0	746	2026-03-18 22:29:04
197	test	70	Algorytmy	Co to jest rekurencja?	0	525	2026-03-18 22:29:06
198	test	266	Kryptografia	Co to jest odwrotność modulo?	0	249	2026-03-18 22:29:08
199	test	30	Licencje i prawo IT	Do czego służą Cookies (ciasteczka)?	0	229	2026-03-18 22:29:10
200	szymon	324	Formaty plikow	Format DOCX to format plikow:	1	4107	2026-03-18 22:58:41
201	szymon	147	Języki programowania	Czym charakteryzują się języki wysokopoziomowe?	1	7011	2026-03-18 22:58:50
202	szymon	307	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (0, 0, 0)?	1	5801	2026-03-18 22:58:57
203	szymon	23	Licencje i prawo IT	Co charakteryzuje licencję MIT?	0	7112	2026-03-18 22:59:06
204	szymon	322	Formaty plikow	Format MP3 to format:	1	3342	2026-03-18 22:59:11
205	szymon	100	Architektura komputera	Co to jest ALU?	1	3119	2026-03-18 22:59:15
206	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	4494	2026-03-18 22:59:21
207	szymon	148	Języki programowania	Co charakteryzuje języki średniopoziomowe?	1	4055	2026-03-18 22:59:27
208	szymon	70	Algorytmy	Co to jest rekurencja?	1	3958	2026-03-18 22:59:33
209	szymon	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	0	11009	2026-03-19 07:53:23
210	szymon	296	Operacje logiczne	Ktora operacja logiczna jest podstawa szyfrowania XOR?	1	9841	2026-03-19 07:53:34
211	szymon	68	Algorytmy	Czym jest algorytm?	1	9621	2026-03-19 07:53:45
212	szymon	70	Algorytmy	Co to jest rekurencja?	1	6700	2026-03-19 07:53:54
213	szymon	71	Algorytmy	Czym różni się BFS od DFS w grafach?	1	6766	2026-03-19 07:54:02
214	szymon	72	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	0	13763	2026-03-19 07:54:18
215	szymon	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	8420	2026-03-19 07:54:28
216	szymon	14	Protokoły sieciowe	Czym jest protokół SSL?	0	15000	2026-03-19 07:54:44
217	szymon	75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	12902	2026-03-19 07:55:00
218	szymon	74	Algorytmy	Co to jest programowanie dynamiczne?	1	5470	2026-03-19 07:55:06
219	szymon	177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	2971	2026-03-19 07:55:11
220	szymon	111	Protokoły sieciowe	Czym HTTPS różni się od HTTP?	1	7048	2026-03-19 07:55:20
221	szymon	183	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	12088	2026-03-19 07:55:34
222	szymon	180	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	1	6219	2026-03-19 07:55:41
223	szymon	179	Algorytmy	Czym różni się BFS od DFS w grafach?	1	6704	2026-03-19 07:55:50
224	szymon	365	Piractwo	Czy sciaganie plikow z nielegalnych zrodel jest przestepstwem?	1	5330	2026-03-19 07:55:57
225	szymon	12	Protokoły sieciowe	Jaka jest rola protokołu SMTP?	0	8137	2026-03-19 07:56:06
226	szymon	178	Algorytmy	Co to jest rekurencja?	1	4379	2026-03-19 07:56:12
227	szymon	176	Algorytmy	Czym jest algorytm?	1	3189	2026-03-19 07:56:17
228	szymon	181	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	4587	2026-03-19 07:56:23
229	szymon	182	Algorytmy	Co to jest programowanie dynamiczne?	1	3058	2026-03-19 07:56:28
230	szymon	109	Protokoły sieciowe	Do czego służy protokół HTTP?	1	5201	2026-03-19 07:56:35
231	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	3785	2026-03-19 07:56:40
232	szymon	100	Architektura komputera	Co to jest ALU?	1	2916	2026-03-19 07:56:45
233	szymon	110	Protokoły sieciowe	Co to jest FTP i do czego służy?	1	4732	2026-03-19 07:56:51
234	szymon	210	Architektura komputera	Co to jest procesor wielordzeniowy?	1	3427	2026-03-19 07:56:56
235	szymon	112	Protokoły sieciowe	Co umożliwia technologia VoIP?	1	3491	2026-03-19 07:57:02
236	szymon	99	Architektura komputera	Różnica RAM vs ROM?	1	4266	2026-03-19 07:57:07
237	szymon	212	Architektura komputera	Co to jest pamięć wirtualna?	1	6844	2026-03-19 07:57:16
238	szymon	363	Piractwo	Co to jest piractwo komputerowe?	1	4197	2026-03-19 07:57:21
239	szymon	211	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	5188	2026-03-19 07:57:28
240	szymon	101	Architektura komputera	Co to jest cache procesora?	1	2254	2026-03-19 07:57:32
241	szymon	333	Prawa autorskie	Jak dlugo trwaja majatkowe prawa autorskie po smierci autora?	1	9129	2026-03-19 07:57:43
242	szymon	209	Architektura komputera	Co to jest cache procesora?	1	5162	2026-03-19 07:57:49
243	szymon	8	Protokoły sieciowe	Za co odpowiada system DNS?	0	6663	2026-03-19 07:57:58
244	szymon	104	Architektura komputera	Co to jest pamięć wirtualna?	1	2332	2026-03-19 07:58:02
245	szymon	364	Piractwo	Jakie sa konsekwencje prawne piractwa komputerowego w Polsce?	1	4169	2026-03-19 07:58:08
246	szymon	103	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	4111	2026-03-19 07:58:13
247	szymon	92	Bazy danych	Czym jest PRIMARY KEY?	1	4845	2026-03-19 07:58:20
248	szymon	4	Protokoły sieciowe	Co umożliwia technologia VoIP?	1	2606	2026-03-19 07:58:24
249	szymon	91	Bazy danych	Czym różni się DELETE od DROP?	1	3498	2026-03-19 07:58:29
250	szymon	207	Architektura komputera	Różnica RAM vs ROM?	1	4133	2026-03-19 07:58:35
251	szymon	208	Architektura komputera	Co to jest ALU?	1	1634	2026-03-19 07:58:38
252	szymon	114	Protokoły sieciowe	W czym SSH jest lepszy od TELNET?	1	8522	2026-03-19 07:58:48
253	szymon	113	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	1	4910	2026-03-19 07:58:55
254	szymon	94	Bazy danych	Co to jest indeks w bazie danych?	0	7289	2026-03-19 07:59:03
255	szymon	93	Bazy danych	Różnica między WHERE a HAVING?	1	5712	2026-03-19 07:59:11
256	szymon	63	Bezpieczeństwo IT	Co to jest Ransomware?	0	99464	2026-03-19 08:00:52
257	szymon	11	Protokoły sieciowe	Do czego służy protokół NTP?	0	10041	2026-03-19 08:01:04
258	szymon	97	Bazy danych	Co to jest JOIN w SQL?	1	5665	2026-03-19 08:01:11
259	szymon	13	Protokoły sieciowe	Czym POP3 różni się od IMAP?	1	13412	2026-03-19 08:01:26
260	szymon	370	Piractwo	Czym jest keygen?	0	4178	2026-03-19 08:01:32
261	szymon	64	Bezpieczeństwo IT	Do czego służy Spyware?	1	5027	2026-03-19 08:01:38
262	szymon	95	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	0	9362	2026-03-19 08:01:49
263	szymon	65	Bezpieczeństwo IT	Co to jest Rootkit?	0	10598	2026-03-19 08:02:01
264	szymon	66	Bezpieczeństwo IT	Co to jest Keylogger?	1	4470	2026-03-19 08:02:07
265	szymon	62	Bezpieczeństwo IT	Co to jest Trojan (Trojan Horse)?	1	7607	2026-03-19 08:02:17
266	szymon	67	Bezpieczeństwo IT	Czym Adware różni się od zwykłego Malware?	1	10868	2026-03-19 08:02:29
267	szymon	368	Piractwo	Jakie szkody powoduje piractwo dla tworcow oprogramowania?	1	13589	2026-03-19 08:02:44
268	szymon	17	Protokoły sieciowe	Czym jest serwer Proxy?	1	3538	2026-03-19 08:02:50
269	szymon	98	Bazy danych	Co robi polecenie GROUP BY?	1	3760	2026-03-19 08:02:55
270	szymon	60	Bezpieczeństwo IT	Czym charakteryzują się wirusy komputerowe?	1	5395	2026-03-19 08:03:02
271	szymon	16	Protokoły sieciowe	Do czego służy VPN?	1	6834	2026-03-19 08:03:10
272	szymon	366	Piractwo	Co to jest warez?	1	10226	2026-03-19 08:03:22
273	szymon	167	Bezpieczeństwo IT	Co to jest Malware?	1	6748	2026-03-19 08:03:31
274	szymon	115	Protokoły sieciowe	Co robi protokół DHCP?	0	6554	2026-03-19 08:03:39
275	szymon	367	Piractwo	Krakowanie oprogramowania polega na:	1	8893	2026-03-19 08:03:49
276	szymon	18	Protokoły sieciowe	Czym jest TCP/IP?	1	6510	2026-03-19 08:03:58
277	szymon	369	Piractwo	Torrenty same w sobie sa:	1	5220	2026-03-19 08:04:04
278	szymon	15	Protokoły sieciowe	Jaka jest relacja między TLS a SSL?	0	8770	2026-03-19 08:04:14
279	szymon	168	Bezpieczeństwo IT	Czym charakteryzują się wirusy komputerowe?	1	7804	2026-03-19 08:04:24
280	szymon	96	Bazy danych	Co to jest transakcja w bazie danych?	1	4536	2026-03-19 08:04:30
281	szymon	335	Prawa autorskie	Co oznacza prawo do ojcostwa utworu?	1	227205	2026-03-19 08:08:19
282	szymon	5	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	1	4557	2026-03-19 08:08:25
283	szymon	116	Protokoły sieciowe	Za co odpowiada system DNS?	0	6922	2026-03-19 08:08:34
284	szymon	118	Protokoły sieciowe	Do czego służy protokół SNMP?	1	6519	2026-03-19 08:08:42
285	szymon	169	Bezpieczeństwo IT	Jak robaki (Worms) różnią się od wirusów?	1	7454	2026-03-19 08:08:51
286	szymon	175	Bezpieczeństwo IT	Czym Adware różni się od zwykłego Malware?	1	12419	2026-03-19 08:09:05
287	szymon	336	Prawa autorskie	Co reguluje prawo autorskie w Polsce?	1	5113	2026-03-19 08:09:11
288	szymon	59	Bezpieczeństwo IT	Co to jest Malware?	1	3530	2026-03-19 08:09:17
289	szymon	353	Dane osobowe	Co to sa dane osobowe?	1	4994	2026-03-19 08:09:23
290	szymon	354	Dane osobowe	Skrot RODO oznacza:	1	5699	2026-03-19 08:09:31
291	szymon	117	Protokoły sieciowe	Co to jest NAT i po co się go używa?	0	8135	2026-03-19 08:09:40
292	szymon	174	Bezpieczeństwo IT	Co to jest Keylogger?	1	3794	2026-03-19 08:09:46
293	szymon	120	Protokoły sieciowe	Jaka jest rola protokołu SMTP?	1	4960	2026-03-19 08:09:52
294	szymon	170	Bezpieczeństwo IT	Co to jest Trojan (Trojan Horse)?	1	7846	2026-03-19 08:10:02
295	szymon	3	Protokoły sieciowe	Czym HTTPS różni się od HTTP?	1	5129	2026-03-19 08:10:08
296	szymon	172	Bezpieczeństwo IT	Do czego służy Spyware?	1	8769	2026-03-19 08:10:19
297	szymon	200	Bazy danych	Czym jest PRIMARY KEY?	1	2471	2026-03-19 08:10:23
298	szymon	119	Protokoły sieciowe	Do czego służy protokół NTP?	1	3844	2026-03-19 08:10:28
299	szymon	125	Protokoły sieciowe	Czym jest serwer Proxy?	1	3122	2026-03-19 09:08:42
300	szymon	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	6820	2026-03-19 09:08:50
301	szymon	68	Algorytmy	Czym jest algorytm?	1	5906	2026-03-19 09:08:58
302	szymon	70	Algorytmy	Co to jest rekurencja?	1	2004	2026-03-19 09:09:01
303	szymon	337	Prawa autorskie	Czy program komputerowy jest chroniony prawem autorskim?	1	4102	2026-03-19 09:09:07
304	szymon	363	Piractwo	Co to jest piractwo komputerowe?	1	4323	2026-03-19 09:09:13
305	szymon	126	Protokoły sieciowe	Czym jest TCP/IP?	1	2100	2026-03-19 09:09:17
306	szymon	208	Architektura komputera	Co to jest ALU?	1	2438	2026-03-19 09:09:21
307	szymon	338	Prawa autorskie	Czym jest dozwolony uzytek?	1	7423	2026-03-19 09:09:30
308	szymon	339	Prawa autorskie	Czy mozna legalnie zrobic kopie zapasowa legalnie zakupionego programu?	0	5349	2026-03-19 09:09:37
309	szymon	49	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	1	9157	2026-03-19 09:09:47
310	szymon	340	Prawa autorskie	Czym jest domena publiczna?	0	8282	2026-03-19 09:09:57
311	szymon	309	Grafika komputerowa	Co oznacza PPI?	1	5916	2026-03-19 09:10:05
312	szymon	306	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (255, 255, 255)?	1	8499	2026-03-19 09:10:15
313	szymon	355	Dane osobowe	W ktorym roku weszlo w zycie RODO?	1	2682	2026-03-19 09:10:19
314	szymon	296	Operacje logiczne	Ktora operacja logiczna jest podstawa szyfrowania XOR?	1	1829	2026-03-19 09:10:23
315	szymon	307	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (0, 0, 0)?	1	10428	2026-03-19 09:10:35
316	szymon	50	Sieci komputerowe	Do której warstwy modelu OSI należy HTTP?	0	9042	2026-03-19 09:10:45
317	szymon	342	Prawa autorskie	Majatkowe prawa autorskie mozna:	1	8843	2026-03-19 09:10:56
318	szymon	308	Grafika komputerowa	Co oznacza DPI w grafice komputerowej?	0	10746	2026-03-19 09:11:08
319	szymon	100	Architektura komputera	Co to jest ALU?	1	7666	2026-03-19 09:11:17
320	szymon	364	Piractwo	Jakie sa konsekwencje prawne piractwa komputerowego w Polsce?	1	7145	2026-03-19 09:11:26
321	szymon	104	Architektura komputera	Co to jest pamięć wirtualna?	1	8403	2026-03-19 09:11:36
322	szymon	357	Dane osobowe	Czy adres e-mail jest dana osobowa?	0	7379	2026-03-19 09:11:46
323	szymon	312	Grafika komputerowa	Model HSB/HSV opisuje kolory za pomoca:	0	9320	2026-03-19 09:11:56
324	szymon	365	Piractwo	Czy sciaganie plikow z nielegalnych zrodel jest przestepstwem?	1	6894	2026-03-19 09:12:05
325	szymon	366	Piractwo	Co to jest warez?	0	6962	2026-03-19 09:12:13
326	szymon	51	Sieci komputerowe	Co to jest adres MAC?	0	9705	2026-03-19 09:12:24
327	szymon	311	Grafika komputerowa	Ile kolorow opisuje 24-bitowy model RGB?	0	14914	2026-03-19 09:12:41
328	szymon	103	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	5013	2026-03-19 09:12:48
329	szymon	52	Sieci komputerowe	Co to jest LAN?	1	7419	2026-03-19 09:12:57
330	szymon	359	Dane osobowe	Kto jest administratorem danych osobowych?	1	6419	2026-03-19 09:13:05
331	szymon	54	Sieci komputerowe	Do czego służy Router?	0	8071	2026-03-19 09:13:14
332	szymon	341	Prawa autorskie	Czy usuniecie znaku wodnego ze zdjeciaw zamieswiedzie w sieci jest legalne?	1	6577	2026-03-19 09:13:23
333	szymon	367	Piractwo	Krakowanie oprogramowania polega na:	1	5633	2026-03-19 09:13:30
334	szymon	207	Architektura komputera	Różnica RAM vs ROM?	1	10474	2026-03-19 09:13:42
335	szymon	53	Sieci komputerowe	Co to jest MAN?	1	8919	2026-03-19 09:13:52
336	szymon	56	Sieci komputerowe	Co to jest Firewall?	1	8963	2026-03-19 09:14:03
337	szymon	356	Dane osobowe	Ktory organ nadzoruje ochrone danych osobowych w Polsce?	1	3894	2026-03-19 09:14:08
338	szymon	57	Sieci komputerowe	Co to jest Ethernet?	1	3761	2026-03-19 09:14:14
339	szymon	55	Sieci komputerowe	Czym się różni Switch od Hub?	1	7511	2026-03-19 09:14:23
340	szymon	310	Grafika komputerowa	Czym jest kanal alfa w grafice komputerowej?	1	4468	2026-03-19 09:14:29
341	szymon	368	Piractwo	Jakie szkody powoduje piractwo dla tworcow oprogramowania?	1	7621	2026-03-19 09:14:38
342	szymon	58	Sieci komputerowe	Czym jest Wi-Fi?	1	4704	2026-03-19 09:14:44
343	szymon	105	Prawo informatyczne	Co reguluje RODO?	1	2854	2026-03-19 09:14:49
344	szymon	157	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	1	9286	2026-03-19 09:15:00
345	szymon	106	Prawo informatyczne	Co to jest licencja open source?	1	5271	2026-03-19 09:15:07
346	szymon	159	Sieci komputerowe	Co to jest adres MAC?	0	10763	2026-03-19 09:15:19
347	szymon	358	Dane osobowe	Jakie jest prawo do bycia zapomnianym?	1	4158	2026-03-19 09:15:25
348	szymon	213	Prawo informatyczne	Co reguluje RODO?	1	2826	2026-03-19 09:15:30
349	szymon	71	Algorytmy	Czym różni się BFS od DFS w grafach?	1	8162	2026-03-19 09:15:40
350	szymon	369	Piractwo	Torrenty same w sobie sa:	1	8837	2026-03-19 09:15:50
351	szymon	313	Grafika komputerowa	Ktory model barw najlepiej odpowiada widzeniu ludzkiego oka?	0	8188	2026-03-19 09:15:59
352	szymon	360	Dane osobowe	Co to jest zgoda na przetwarzanie danych osobowych?	1	4430	2026-03-19 09:16:06
353	szymon	158	Sieci komputerowe	Do której warstwy modelu OSI należy HTTP?	0	14119	2026-03-19 09:16:21
354	szymon	108	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	1	9770	2026-03-19 09:16:33
355	szymon	107	Prawo informatyczne	Czym jest cyberprzestępstwo?	1	6045	2026-03-19 09:16:40
356	szymon	362	Dane osobowe	Dane wrazliwe (szczegolne kategorie danych) obejmuja m.in.:	0	13186	2026-03-19 09:16:55
357	szymon	334	Prawa autorskie	Autorskie prawa osobiste sa:	0	14649	2026-03-19 09:17:11
358	szymon	101	Architektura komputera	Co to jest cache procesora?	1	11518	2026-03-19 09:17:24
359	szymon	160	Sieci komputerowe	Co to jest LAN?	1	8287	2026-03-19 09:17:34
360	szymon	166	Sieci komputerowe	Czym jest Wi-Fi?	1	4366	2026-03-19 09:17:40
361	szymon	75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	7833	2026-03-19 09:17:50
362	szymon	332	Prawa autorskie	Od kiedy dzielo jest chronione prawem autorskim?	1	5712	2026-03-19 09:17:57
363	szymon	361	Dane osobowe	Czy numer IP komputera moze byc dana osobowa?	1	14107	2026-03-19 09:18:13
364	szymon	335	Prawa autorskie	Co oznacza prawo do ojcostwa utworu?	0	14460	2026-03-19 09:18:29
365	szymon	84	Systemy liczbowe	Ile wynosi 255₁₀ w systemie szesnastkowym?	0	15000	2026-03-19 09:18:46
366	szymon	83	Systemy liczbowe	Ile wynosi 1010₂ w systemie dziesiętnym?	1	12027	2026-03-19 09:19:00
367	szymon	318	Formaty plikow	Ktory format graficzny obsluguje przezroczystosc?	1	6145	2026-03-19 09:19:08
368	szymon	99	Architektura komputera	Różnica RAM vs ROM?	1	3094	2026-03-19 09:19:12
369	szymon	214	Prawo informatyczne	Co to jest licencja open source?	1	2995	2026-03-19 09:19:17
370	szymon	317	Formaty plikow	Ktory format graficzny stosuje kompresje stratna?	1	4462	2026-03-19 09:19:23
371	szymon	372	Piractwo	Programy DRM (Digital Rights Management) sluza do:	0	8980	2026-03-19 09:19:33
372	szymon	72	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	1	5402	2026-03-19 09:19:40
373	szymon	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	2903	2026-03-19 09:19:45
374	szymon	165	Sieci komputerowe	Co to jest Ethernet?	1	7316	2026-03-19 09:19:54
375	szymon	34	Języki programowania	Do czego używa się języka Java?	1	5534	2026-03-19 09:20:01
376	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	5810	2026-03-19 09:20:08
377	szymon	161	Sieci komputerowe	Co to jest MAN?	1	2379	2026-03-19 09:20:12
378	szymon	162	Sieci komputerowe	Do czego służy Router?	1	3656	2026-03-19 09:20:18
379	szymon	2	Protokoły sieciowe	Co to jest FTP i do czego służy?	1	4442	2026-03-19 09:20:24
380	szymon	32	Języki programowania	Co to jest Python i gdzie się go stosuje?	1	5373	2026-03-19 09:20:31
381	szymon	1	Protokoły sieciowe	Do czego służy protokół HTTP?	1	5069	2026-03-19 09:20:37
382	szymon	163	Sieci komputerowe	Czym się różni Switch od Hub?	1	3729	2026-03-19 09:20:43
383	szymon	319	Formaty plikow	Format BMP charakteryzuje sie:	1	4805	2026-03-19 09:20:49
384	szymon	74	Algorytmy	Co to jest programowanie dynamiczne?	1	3950	2026-03-19 09:20:55
385	szymon	164	Sieci komputerowe	Co to jest Firewall?	1	4390	2026-03-19 09:21:01
386	szymon	216	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	1	4369	2026-03-19 09:21:07
387	szymon	91	Bazy danych	Czym różni się DELETE od DROP?	1	3178	2026-03-19 09:21:11
388	szymon	320	Formaty plikow	Do czego sluzy format PDF?	1	4220	2026-03-19 09:21:17
389	szymon	182	Algorytmy	Co to jest programowanie dynamiczne?	1	3852	2026-03-19 09:21:23
390	szymon	178	Algorytmy	Co to jest rekurencja?	0	4780	2026-03-19 09:21:29
391	szymon	322	Formaty plikow	Format MP3 to format:	1	8778	2026-03-19 09:21:39
392	szymon	85	Systemy liczbowe	Ile cyfr używa system ósemkowy (oktalny)?	1	10761	2026-03-19 09:21:52
393	szymon	179	Algorytmy	Czym różni się BFS od DFS w grafach?	1	3295	2026-03-19 09:21:57
394	szymon	321	Formaty plikow	Ktory format plikow audio jest bezstratny?	1	5449	2026-03-19 09:22:04
395	szymon	176	Algorytmy	Czym jest algorytm?	1	3578	2026-03-19 09:22:09
396	szymon	86	Systemy liczbowe	Jak przelicza się liczbę binarną na dziesiętną?	1	11492	2026-03-19 09:22:22
397	szymon	177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	8747	2026-03-19 09:22:32
398	szymon	94	Bazy danych	Co to jest indeks w bazie danych?	1	6959	2026-03-19 09:22:41
399	szymon	215	Prawo informatyczne	Czym jest cyberprzestępstwo?	1	7730	2026-03-19 09:22:50
400	szymon	210	Architektura komputera	Co to jest procesor wielordzeniowy?	1	12267	2026-03-19 09:23:04
401	szymon	370	Piractwo	Czym jest keygen?	1	6038	2026-03-19 09:23:12
402	szymon	371	Piractwo	Czy udostepnianie zakupionego ebooka znajomym bez zgody wydawcy jest legalne?	1	5316	2026-03-19 09:23:19
403	szymon	101	Architektura komputera	Co to jest cache procesora?	1	2316	2026-03-19 22:21:38
404	szymon	189	Złożoność obliczeniowa	Jaka jest złożoność dostępu do elementu tablicy po indeksie?	0	2930	2026-03-19 22:21:43
405	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	2968	2026-03-19 22:21:47
406	szymon	209	Architektura komputera	Co to jest cache procesora?	1	3511	2026-03-19 22:21:52
407	szymon	372	Piractwo	Programy DRM (Digital Rights Management) sluza do:	1	7948	2026-03-19 22:22:02
408	szymon	68	Algorytmy	Czym jest algorytm?	1	1899	2026-03-19 22:22:05
409	szymon	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	7015	2026-03-19 22:22:14
410	szymon	71	Algorytmy	Czym różni się BFS od DFS w grafach?	1	6745	2026-03-19 22:22:22
411	szymon	70	Algorytmy	Co to jest rekurencja?	1	4754	2026-03-19 22:22:29
412	szymon	210	Architektura komputera	Co to jest procesor wielordzeniowy?	1	1794	2026-03-19 22:22:32
413	szymon	52	Sieci komputerowe	Co to jest LAN?	1	5130	2026-03-19 22:22:39
414	szymon	334	Prawa autorskie	Autorskie prawa osobiste sa:	1	9544	2026-03-20 20:31:32
415	szymon	207	Architektura komputera	Różnica RAM vs ROM?	1	10859	2026-03-20 20:31:45
416	szymon	303	Grafika komputerowa	Model CMYK stosowany jest glownie w:	1	7955	2026-03-20 20:31:54
417	szymon	306	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (255, 255, 255)?	1	5769	2026-03-20 20:32:02
418	szymon	208	Architektura komputera	Co to jest ALU?	1	1842	2026-03-20 20:32:05
419	szymon	68	Algorytmy	Czym jest algorytm?	1	4011	2026-03-20 20:32:11
420	szymon	309	Grafika komputerowa	Co oznacza PPI?	1	3287	2026-03-20 20:32:16
421	szymon	176	Algorytmy	Czym jest algorytm?	1	4409	2026-03-20 20:32:22
422	szymon	5	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	1	4892	2026-03-20 20:32:29
423	szymon	4	Protokoły sieciowe	Co umożliwia technologia VoIP?	1	2462	2026-03-20 20:32:33
424	szymon	101	Architektura komputera	Co to jest cache procesora?	1	2265	2026-03-20 20:32:37
425	szymon	96	Bazy danych	Co to jest transakcja w bazie danych?	1	4566	2026-03-20 20:32:43
426	szymon	214	Prawo informatyczne	Co to jest licencja open source?	1	4281	2026-03-20 20:32:49
427	szymon	371	Piractwo	Czy udostepnianie zakupionego ebooka znajomym bez zgody wydawcy jest legalne?	1	4818	2026-03-20 20:32:55
428	szymon	6	Protokoły sieciowe	W czym SSH jest lepszy od TELNET?	1	3675	2026-03-20 20:33:00
429	szymon	308	Grafika komputerowa	Co oznacza DPI w grafice komputerowej?	0	9668	2026-03-20 20:33:12
430	szymon	356	Dane osobowe	Ktory organ nadzoruje ochrone danych osobowych w Polsce?	1	3867	2026-03-20 20:33:17
431	szymon	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	7393	2026-03-20 20:33:27
432	szymon	3	Protokoły sieciowe	Czym HTTPS różni się od HTTP?	1	13816	2026-03-20 20:33:42
433	szymon	305	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (255, 0, 0)?	1	8078	2026-03-20 20:33:52
434	szymon	7	Protokoły sieciowe	Co robi protokół DHCP?	0	3948	2026-03-20 20:33:57
435	szymon	95	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	1	9558	2026-03-20 20:34:08
436	szymon	302	Grafika komputerowa	Model barw RGB jest modelem:	0	4616	2026-03-20 20:34:15
437	szymon	365	Piractwo	Czy sciaganie plikow z nielegalnych zrodel jest przestepstwem?	1	6511	2026-03-20 20:34:23
438	szymon	8	Protokoły sieciowe	Za co odpowiada system DNS?	0	6039	2026-03-20 20:34:30
439	szymon	364	Piractwo	Jakie sa konsekwencje prawne piractwa komputerowego w Polsce?	1	1676847	2026-03-20 21:02:29
440	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	5398	2026-03-20 21:02:36
441	szymon	10	Protokoły sieciowe	Do czego służy protokół SNMP?	0	7113	2026-03-20 21:02:45
442	szymon	296	Operacje logiczne	Ktora operacja logiczna jest podstawa szyfrowania XOR?	1	1396	2026-03-20 21:02:48
443	szymon	304	Grafika komputerowa	Co oznacza litera K w skrocie CMYK?	0	5048	2026-03-20 21:02:54
444	szymon	97	Bazy danych	Co to jest JOIN w SQL?	1	4731	2026-03-20 21:03:01
445	szymon	9	Protokoły sieciowe	Co to jest NAT i po co się go używa?	1	7034	2026-03-20 21:03:09
446	szymon	98	Bazy danych	Co robi polecenie GROUP BY?	1	4665	2026-03-20 21:03:16
447	szymon	363	Piractwo	Co to jest piractwo komputerowe?	1	4814	2026-03-20 21:03:22
448	szymon	12	Protokoły sieciowe	Jaka jest rola protokołu SMTP?	1	9119	2026-03-20 21:03:33
449	szymon	13	Protokoły sieciowe	Czym POP3 różni się od IMAP?	1	7628	2026-03-20 21:03:42
450	szymon	326	Formaty plikow	Format ZIP sluzy do:	1	2269	2026-03-20 21:03:46
451	szymon	199	Bazy danych	Czym różni się DELETE od DROP?	1	4480	2026-03-20 21:03:52
452	szymon	38	Języki programowania	Czym jest SQL jako język?	1	9477	2026-03-20 21:04:03
453	szymon	99	Architektura komputera	Różnica RAM vs ROM?	1	4732	2026-03-20 21:04:10
454	szymon	11	Protokoły sieciowe	Do czego służy protokół NTP?	1	8762	2026-03-20 21:04:20
455	szymon	340	Prawa autorskie	Czym jest domena publiczna?	0	11645	2026-03-20 21:04:33
456	szymon	367	Piractwo	Krakowanie oprogramowania polega na:	1	6936	2026-03-20 21:04:42
457	szymon	14	Protokoły sieciowe	Czym jest protokół SSL?	1	7716	2026-03-20 21:04:51
458	szymon	18	Protokoły sieciowe	Czym jest TCP/IP?	1	2348	2026-03-20 21:04:55
459	szymon	355	Dane osobowe	W ktorym roku weszlo w zycie RODO?	1	2598	2026-03-20 21:04:59
460	szymon	307	Grafika komputerowa	Jaki kolor uzyskamy w modelu RGB przy wartosciach (0, 0, 0)?	1	2783	2026-03-20 21:05:04
461	szymon	357	Dane osobowe	Czy adres e-mail jest dana osobowa?	1	4797	2026-03-20 21:05:10
462	szymon	200	Bazy danych	Czym jest PRIMARY KEY?	1	3315	2026-03-20 21:05:15
463	szymon	16	Protokoły sieciowe	Do czego służy VPN?	1	7432	2026-03-20 21:05:24
464	szymon	341	Prawa autorskie	Czy usuniecie znaku wodnego ze zdjeciaw zamieswiedzie w sieci jest legalne?	1	6995	2026-03-20 21:05:33
465	szymon	202	Bazy danych	Co to jest indeks w bazie danych?	1	4049	2026-03-20 21:05:38
466	szymon	17	Protokoły sieciowe	Czym jest serwer Proxy?	1	5165	2026-03-20 21:05:45
467	szymon	201	Bazy danych	Różnica między WHERE a HAVING?	1	297175	2026-03-20 21:10:44
468	szymon	299	Grafika komputerowa	Grafika wektorowa zbudowana jest z:	1	2363	2026-03-20 21:10:48
469	szymon	333	Prawa autorskie	Jak dlugo trwaja majatkowe prawa autorskie po smierci autora?	1	3913	2026-03-20 21:10:54
470	szymon	335	Prawa autorskie	Co oznacza prawo do ojcostwa utworu?	1	3780	2026-03-20 21:10:59
471	szymon	15	Protokoły sieciowe	Jaka jest relacja między TLS a SSL?	1	5622	2026-03-20 21:11:06
472	szymon	71	Algorytmy	Czym różni się BFS od DFS w grafach?	1	3336	2026-03-20 21:11:11
473	szymon	100	Architektura komputera	Co to jest ALU?	1	2165	2026-03-20 21:11:15
474	szymon	298	Grafika komputerowa	Jaka jest glowna wada grafiki rastrowej przy powiekszaniu?	1	4554	2026-03-20 21:11:21
475	szymon	112	Protokoły sieciowe	Co umożliwia technologia VoIP?	1	2565	2026-03-20 21:11:25
476	szymon	336	Prawa autorskie	Co reguluje prawo autorskie w Polsce?	1	2128	2026-03-20 21:11:29
477	szymon	111	Protokoły sieciowe	Czym HTTPS różni się od HTTP?	1	5320	2026-03-20 21:11:36
478	szymon	215	Prawo informatyczne	Czym jest cyberprzestępstwo?	1	7427	2026-03-20 21:11:45
479	szymon	327	Formaty plikow	Co to jest format SVG?	0	3508	2026-03-20 21:11:50
480	szymon	113	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	1	3848	2026-03-20 21:11:56
481	szymon	61	Bezpieczeństwo IT	Jak robaki (Worms) różnią się od wirusów?	1	8006	2026-03-20 21:12:05
482	szymon	1	Protokoły sieciowe	Do czego służy protokół HTTP?	1	4849	2026-03-20 21:12:12
483	szymon	368	Piractwo	Jakie szkody powoduje piractwo dla tworcow oprogramowania?	1	7181	2026-03-20 21:12:20
484	szymon	109	Protokoły sieciowe	Do czego służy protokół HTTP?	1	2081	2026-03-20 21:12:24
485	szymon	110	Protokoły sieciowe	Co to jest FTP i do czego służy?	1	1981	2026-03-20 21:12:28
486	szymon	372	Piractwo	Programy DRM (Digital Rights Management) sluza do:	1	3946	2026-03-20 21:12:33
487	szymon	203	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	1	6767	2026-03-20 21:12:42
488	szymon	115	Protokoły sieciowe	Co robi protokół DHCP?	1	5931	2026-03-20 21:12:49
489	szymon	310	Grafika komputerowa	Czym jest kanal alfa w grafice komputerowej?	1	3165	2026-03-20 21:12:54
490	szymon	114	Protokoły sieciowe	W czym SSH jest lepszy od TELNET?	1	5665	2026-03-20 21:13:01
491	szymon	358	Dane osobowe	Jakie jest prawo do bycia zapomnianym?	1	5547	2026-03-20 21:13:08
492	szymon	337	Prawa autorskie	Czy program komputerowy jest chroniony prawem autorskim?	1	8487	2026-03-20 21:13:18
493	szymon	116	Protokoły sieciowe	Za co odpowiada system DNS?	0	6949	2026-03-20 21:13:27
494	szymon	177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	6673	2026-03-20 21:13:35
495	szymon	370	Piractwo	Czym jest keygen?	1	5045	2026-03-20 21:13:42
496	szymon	332	Prawa autorskie	Od kiedy dzielo jest chronione prawem autorskim?	1	4106	2026-03-20 21:13:48
497	szymon	366	Piractwo	Co to jest warez?	1	4098	2026-03-20 21:13:53
498	szymon	59	Bezpieczeństwo IT	Co to jest Malware?	1	1938	2026-03-20 21:13:57
499	szymon	103	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	2105	2026-03-20 21:14:01
500	szymon	118	Protokoły sieciowe	Do czego służy protokół SNMP?	0	8565	2026-03-20 21:14:11
501	szymon	119	Protokoły sieciowe	Do czego służy protokół NTP?	1	5881	2026-03-20 21:14:18
502	szymon	60	Bezpieczeństwo IT	Czym charakteryzują się wirusy komputerowe?	1	4438	2026-03-20 21:14:24
503	szymon	117	Protokoły sieciowe	Co to jest NAT i po co się go używa?	0	5631	2026-03-20 21:14:32
504	szymon	41	Języki programowania	Czym są języki niskopoziomowe?	1	4626	2026-03-20 21:14:38
505	szymon	120	Protokoły sieciowe	Jaka jest rola protokołu SMTP?	1	4982	2026-03-20 21:14:44
506	szymon	359	Dane osobowe	Kto jest administratorem danych osobowych?	1	2840	2026-03-20 21:14:49
507	szymon	105	Prawo informatyczne	Co reguluje RODO?	1	4725	2026-03-20 21:14:55
508	szymon	369	Piractwo	Torrenty same w sobie sa:	1	3882	2026-03-20 21:15:01
509	szymon	362	Dane osobowe	Dane wrazliwe (szczegolne kategorie danych) obejmuja m.in.:	1	8852	2026-03-20 21:15:11
510	szymon	122	Protokoły sieciowe	Czym jest protokół SSL?	1	3148	2026-03-20 21:15:16
511	szymon	106	Prawo informatyczne	Co to jest licencja open source?	1	5229	2026-03-20 21:15:23
512	szymon	121	Protokoły sieciowe	Czym POP3 różni się od IMAP?	1	5684	2026-03-20 21:15:30
513	szymon	338	Prawa autorskie	Czym jest dozwolony uzytek?	1	6478	2026-03-20 21:15:38
514	szymon	338	Prawa autorskie	Czym jest dozwolony uzytek?	1	283386	2026-03-20 21:20:15
515	szymon	339	Prawa autorskie	Czy mozna legalnie zrobic kopie zapasowa legalnie zakupionego programu?	0	4426	2026-03-20 21:20:21
516	szymon	205	Bazy danych	Co to jest JOIN w SQL?	1	6830	2026-03-20 21:20:30
517	szymon	204	Bazy danych	Co to jest transakcja w bazie danych?	1	4147	2026-03-20 21:20:35
518	szymon	107	Prawo informatyczne	Czym jest cyberprzestępstwo?	1	7687	2026-03-20 21:20:45
519	szymon	104	Architektura komputera	Co to jest pamięć wirtualna?	0	7010	2026-03-20 21:20:53
520	szymon	123	Protokoły sieciowe	Jaka jest relacja między TLS a SSL?	1	3711	2026-03-20 21:20:59
521	szymon	124	Protokoły sieciowe	Do czego służy VPN?	1	5400	2026-03-20 21:21:06
522	szymon	216	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	1	3244	2026-03-20 21:21:11
523	szymon	300	Grafika komputerowa	Ktory format jest typowy dla grafiki wektorowej?	1	3161	2026-03-20 21:21:15
524	szymon	213	Prawo informatyczne	Co reguluje RODO?	1	3557	2026-03-20 21:21:21
525	szymon	108	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	1	2187	2026-03-20 21:21:25
526	szymon	36	Języki programowania	Gdzie najczęściej stosuje się PHP?	1	6339	2026-03-20 21:21:33
527	szymon	342	Prawa autorskie	Majatkowe prawa autorskie mozna:	1	7002	2026-03-20 21:21:41
528	szymon	212	Architektura komputera	Co to jest pamięć wirtualna?	1	3880	2026-03-20 21:21:47
529	szymon	2	Protokoły sieciowe	Co to jest FTP i do czego służy?	1	4265	2026-03-20 21:21:53
530	szymon	161	Sieci komputerowe	Co to jest MAN?	1	6515	2026-03-20 21:22:01
531	szymon	162	Sieci komputerowe	Do czego służy Router?	1	7312	2026-03-20 21:22:10
532	szymon	125	Protokoły sieciowe	Czym jest serwer Proxy?	1	3397	2026-03-20 21:22:15
533	szymon	163	Sieci komputerowe	Czym się różni Switch od Hub?	1	5578	2026-03-20 21:22:22
534	szymon	360	Dane osobowe	Co to jest zgoda na przetwarzanie danych osobowych?	1	6612	2026-03-20 21:22:30
535	szymon	50	Sieci komputerowe	Do której warstwy modelu OSI należy HTTP?	1	4421	2026-03-20 21:22:36
536	szymon	179	Algorytmy	Czym różni się BFS od DFS w grafach?	1	3466	2026-03-20 21:22:41
537	szymon	49	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	1	6344	2026-03-20 21:22:49
538	szymon	164	Sieci komputerowe	Co to jest Firewall?	1	2547	2026-03-20 21:22:54
539	szymon	206	Bazy danych	Co robi polecenie GROUP BY?	1	2883	2026-03-20 21:22:58
540	szymon	361	Dane osobowe	Czy numer IP komputera moze byc dana osobowa?	1	8528	2026-03-20 21:23:08
541	szymon	165	Sieci komputerowe	Co to jest Ethernet?	1	2766	2026-03-20 21:23:13
542	szymon	126	Protokoły sieciowe	Czym jest TCP/IP?	1	5662	2026-03-20 21:23:20
543	szymon	51	Sieci komputerowe	Co to jest adres MAC?	1	9680	2026-03-20 21:23:31
544	szymon	318	Formaty plikow	Ktory format graficzny obsluguje przezroczystosc?	0	5382	2026-03-20 21:23:38
545	szymon	166	Sieci komputerowe	Czym jest Wi-Fi?	1	5848	2026-03-20 21:23:46
546	szymon	317	Formaty plikow	Ktory format graficzny stosuje kompresje stratna?	1	5211	2026-03-20 21:23:52
547	szymon	301	Grafika komputerowa	Co oznacza skrot RGB?	1	2663	2026-03-20 21:23:57
548	szymon	70	Algorytmy	Co to jest rekurencja?	1	4885	2026-03-20 21:24:03
549	szymon	84	Systemy liczbowe	Ile wynosi 255₁₀ w systemie szesnastkowym?	0	9514	2026-03-20 21:24:14
550	szymon	311	Grafika komputerowa	Ile kolorow opisuje 24-bitowy model RGB?	0	3916	2026-03-20 21:24:20
551	szymon	83	Systemy liczbowe	Ile wynosi 1010₂ w systemie dziesiętnym?	0	4593	2026-03-20 21:24:26
552	szymon	62	Bezpieczeństwo IT	Co to jest Trojan (Trojan Horse)?	1	3298	2026-03-20 21:24:31
553	szymon	52	Sieci komputerowe	Co to jest LAN?	1	4831	2026-03-20 21:24:38
554	szymon	178	Algorytmy	Co to jest rekurencja?	1	2716	2026-03-20 21:24:42
555	szymon	89	Systemy liczbowe	Jak zapisujemy liczbę 13₁₀ w systemie binarnym?	1	4543	2026-03-20 21:24:48
556	szymon	53	Sieci komputerowe	Co to jest MAN?	1	2501	2026-03-20 21:24:52
557	szymon	191	Systemy liczbowe	Ile wynosi 1010₂ w systemie dziesiętnym?	1	3832	2026-03-20 21:24:58
558	szymon	54	Sieci komputerowe	Do czego służy Router?	1	3718	2026-03-20 21:25:03
559	szymon	210	Architektura komputera	Co to jest procesor wielordzeniowy?	1	4417	2026-03-20 21:25:09
560	szymon	65	Bezpieczeństwo IT	Co to jest Rootkit?	1	6018	2026-03-20 21:25:17
561	szymon	320	Formaty plikow	Do czego sluzy format PDF?	1	2878	2026-03-20 21:25:21
562	szymon	86	Systemy liczbowe	Jak przelicza się liczbę binarną na dziesiętną?	1	11181	2026-03-20 21:25:34
563	szymon	157	Sieci komputerowe	Jaka jest główna różnica między TCP a UDP?	1	5636	2026-03-20 21:25:41
564	szymon	64	Bezpieczeństwo IT	Do czego służy Spyware?	1	3611	2026-03-20 21:25:46
565	szymon	158	Sieci komputerowe	Do której warstwy modelu OSI należy HTTP?	1	4121	2026-03-20 21:25:52
566	szymon	312	Grafika komputerowa	Model HSB/HSV opisuje kolory za pomoca:	0	8633	2026-03-20 21:26:02
567	szymon	39	Języki programowania	Czym charakteryzują się języki wysokopoziomowe?	1	7831	2026-03-20 21:26:12
568	szymon	159	Sieci komputerowe	Co to jest adres MAC?	1	2893	2026-03-20 21:26:16
569	szymon	66	Bezpieczeństwo IT	Co to jest Keylogger?	1	2240	2026-03-20 21:26:20
570	szymon	56	Sieci komputerowe	Co to jest Firewall?	1	3621	2026-03-20 21:26:26
571	szymon	93	Bazy danych	Różnica między WHERE a HAVING?	1	3894	2026-03-20 21:26:31
572	szymon	160	Sieci komputerowe	Co to jest LAN?	1	2765	2026-03-20 21:26:36
573	szymon	313	Grafika komputerowa	Ktory model barw najlepiej odpowiada widzeniu ludzkiego oka?	0	5170	2026-03-20 21:26:43
574	szymon	63	Bezpieczeństwo IT	Co to jest Ransomware?	0	4715	2026-03-20 21:26:49
575	szymon	325	Formaty plikow	Format XLSX to format plikow:	1	2896	2026-03-20 21:26:54
576	szymon	314	Grafika komputerowa	Kompresja bezstratna oznacza, ze:	1	5819	2026-03-20 21:27:01
577	szymon	55	Sieci komputerowe	Czym się różni Switch od Hub?	1	5370	2026-03-20 21:27:08
578	szymon	37	Języki programowania	Co to jest Swift i gdzie się go używa?	0	13582	2026-03-20 21:27:23
579	szymon	85	Systemy liczbowe	Ile cyfr używa system ósemkowy (oktalny)?	1	3898	2026-03-20 21:27:29
580	szymon	319	Formaty plikow	Format BMP charakteryzuje sie:	1	6838	2026-03-20 21:27:37
581	szymon	321	Formaty plikow	Ktory format plikow audio jest bezstratny?	1	3598	2026-03-20 21:27:42
582	szymon	322	Formaty plikow	Format MP3 to format:	1	3682	2026-03-20 21:27:48
583	szymon	88	Systemy liczbowe	Ile wynosi A3₁₆ w systemie dziesiętnym?	1	7066	2026-03-20 21:27:56
584	szymon	315	Grafika komputerowa	Ktory program jest przykladem edytora grafiki rastrowej?	0	8535	2026-03-20 21:28:07
585	szymon	182	Algorytmy	Co to jest programowanie dynamiczne?	1	5766	2026-03-20 21:28:14
586	szymon	40	Języki programowania	Co charakteryzuje języki średniopoziomowe?	1	5664	2026-03-20 21:28:21
587	szymon	328	Formaty plikow	Ktory format jest otwarty i powszechnie stosowany do dokumentow?	1	5698	2026-03-20 21:28:29
588	szymon	57	Sieci komputerowe	Co to jest Ethernet?	0	2752	2026-03-20 21:28:33
589	szymon	324	Formaty plikow	Format DOCX to format plikow:	1	3400	2026-03-20 21:28:38
590	szymon	192	Systemy liczbowe	Ile wynosi 255₁₀ w systemie szesnastkowym?	1	2735	2026-03-20 21:28:42
591	szymon	323	Formaty plikow	Format MP4 sluzy do zapisu:	1	3761	2026-03-20 21:28:48
592	szymon	42	Języki programowania	Co to jest TypeScript?	1	3023	2026-03-20 21:28:52
593	szymon	209	Architektura komputera	Co to jest cache procesora?	1	2636	2026-03-20 21:28:57
594	szymon	58	Sieci komputerowe	Czym jest Wi-Fi?	1	4267	2026-03-20 21:29:03
595	szymon	316	Grafika komputerowa	Rozdzielczosc obrazu 1920x1080 oznacza:	1	4259	2026-03-20 21:29:09
596	szymon	330	Formaty plikow	Ktory format pliku tekstowego jest najprostszy i nie zawiera formatowania?	1	3705	2026-03-20 21:29:14
597	szymon	74	Algorytmy	Co to jest programowanie dynamiczne?	1	2210	2026-03-20 21:29:18
598	szymon	67	Bezpieczeństwo IT	Czym Adware różni się od zwykłego Malware?	1	4548	2026-03-20 21:29:24
599	szymon	329	Formaty plikow	Format GIF obsluguje:	1	3886	2026-03-20 21:29:29
600	szymon	87	Systemy liczbowe	Co to jest bit i co to jest bajt?	1	9934	2026-03-20 21:29:41
601	szymon	90	Systemy liczbowe	Do czego służy system szesnastkowy (hex) w informatyce?	1	5437	2026-03-20 21:29:48
602	szymon	167	Bezpieczeństwo IT	Co to jest Malware?	1	4810	2026-03-20 21:29:55
603	szymon	168	Bezpieczeństwo IT	Czym charakteryzują się wirusy komputerowe?	1	2948	2026-03-20 21:29:59
604	szymon	91	Bazy danych	Czym różni się DELETE od DROP?	1	4435	2026-03-20 21:30:05
605	szymon	195	Systemy liczbowe	Co to jest bit i co to jest bajt?	0	11478	2026-03-20 21:30:18
606	szymon	194	Systemy liczbowe	Jak przelicza się liczbę binarną na dziesiętną?	1	8080	2026-03-20 21:30:28
607	szymon	72	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	1	3515	2026-03-20 21:30:33
608	szymon	193	Systemy liczbowe	Ile cyfr używa system ósemkowy (oktalny)?	1	3062	2026-03-20 21:30:38
609	szymon	196	Systemy liczbowe	Ile wynosi A3₁₆ w systemie dziesiętnym?	1	3619	2026-03-20 21:30:43
610	szymon	297	Grafika komputerowa	Z czego zbudowany jest obraz rastrowy?	1	3078	2026-03-20 21:30:48
611	szymon	31	Języki programowania	Co to jest język programowania?	1	5583	2026-03-20 21:30:55
612	szymon	169	Bezpieczeństwo IT	Jak robaki (Worms) różnią się od wirusów?	1	2983	2026-03-20 21:31:00
613	szymon	354	Dane osobowe	Skrot RODO oznacza:	1	4897	2026-03-20 21:31:06
614	szymon	77	Złożoność obliczeniowa	Jaka jest złożoność czasowa sortowania bąbelkowego (bubble sort)?	1	7223	2026-03-20 21:31:15
615	szymon	75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	0	8935	2026-03-20 21:31:26
616	szymon	198	Systemy liczbowe	Do czego służy system szesnastkowy (hex) w informatyce?	1	4733	2026-03-20 21:31:32
617	szymon	197	Systemy liczbowe	Jak zapisujemy liczbę 13₁₀ w systemie binarnym?	1	2625	2026-03-20 21:31:36
618	szymon	76	Złożoność obliczeniowa	Co oznacza notacja O(n)?	1	7762	2026-03-20 21:31:46
619	szymon	43	Języki programowania	Do czego służy Rust?	0	3820	2026-03-20 21:31:51
620	szymon	331	Formaty plikow	Format HTML sluzy do:	1	4728	2026-03-20 21:31:57
621	szymon	79	Złożoność obliczeniowa	Co oznacza złożoność O(1)?	1	2147	2026-03-20 21:32:01
622	szymon	139	Języki programowania	Co to jest język programowania?	0	4383	2026-03-20 21:32:07
623	szymon	78	Złożoność obliczeniowa	Jaka jest złożoność algorytmu merge sort?	1	7014	2026-03-20 21:32:16
624	szymon	80	Złożoność obliczeniowa	Dlaczego binary search ma złożoność O(log n)?	1	9792	2026-03-20 21:32:27
625	szymon	81	Złożoność obliczeniowa	Jaka jest złożoność dostępu do elementu tablicy po indeksie?	1	6741	2026-03-20 21:32:36
626	szymon	172	Bezpieczeństwo IT	Do czego służy Spyware?	1	2835	2026-03-20 21:32:40
627	szymon	184	Złożoność obliczeniowa	Co oznacza notacja O(n)?	1	4410	2026-03-20 21:32:46
628	szymon	92	Bazy danych	Czym jest PRIMARY KEY?	1	4158	2026-03-20 21:32:52
629	szymon	185	Złożoność obliczeniowa	Jaka jest złożoność czasowa sortowania bąbelkowego (bubble sort)?	1	7674	2026-03-20 21:33:01
630	szymon	82	Złożoność obliczeniowa	Co to jest złożoność pamięciowa algorytmu?	1	10733	2026-03-20 21:33:13
631	szymon	141	Języki programowania	Do czego służy JavaScript?	1	2864	2026-03-20 21:33:18
632	szymon	140	Języki programowania	Co to jest Python i gdzie się go stosuje?	1	4316	2026-03-20 21:33:24
633	szymon	186	Złożoność obliczeniowa	Jaka jest złożoność algorytmu merge sort?	0	7537	2026-03-20 21:33:33
634	szymon	142	Języki programowania	Do czego używa się języka Java?	1	5914	2026-03-20 21:33:41
635	szymon	188	Złożoność obliczeniowa	Dlaczego binary search ma złożoność O(log n)?	1	7352	2026-03-20 21:33:50
636	szymon	189	Złożoność obliczeniowa	Jaka jest złożoność dostępu do elementu tablicy po indeksie?	1	3972	2026-03-20 21:33:55
637	szymon	143	Języki programowania	Do czego stosuje się C#?	1	5191	2026-03-20 21:34:02
638	szymon	33	Języki programowania	Do czego służy JavaScript?	1	7304	2026-03-20 21:34:11
639	szymon	187	Złożoność obliczeniowa	Co oznacza złożoność O(1)?	1	3147	2026-03-20 21:34:16
640	szymon	180	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	1	3741	2026-03-20 21:34:21
641	szymon	211	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	2430	2026-03-20 21:34:25
642	szymon	190	Złożoność obliczeniowa	Co to jest złożoność pamięciowa algorytmu?	1	3532	2026-03-20 21:34:30
643	szymon	144	Języki programowania	Gdzie najczęściej stosuje się PHP?	1	5915	2026-03-20 21:34:38
644	szymon	94	Bazy danych	Co to jest indeks w bazie danych?	1	2718	2026-03-20 21:34:42
645	szymon	171	Bezpieczeństwo IT	Co to jest Ransomware?	1	4828	2026-03-20 21:34:49
646	szymon	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	2287	2026-03-20 21:34:53
647	szymon	34	Języki programowania	Do czego używa się języka Java?	1	3608	2026-03-20 21:34:58
648	szymon	170	Bezpieczeństwo IT	Co to jest Trojan (Trojan Horse)?	1	2379	2026-03-20 21:35:02
649	szymon	181	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	4316	2026-03-20 21:35:08
650	szymon	32	Języki programowania	Co to jest Python i gdzie się go stosuje?	1	3283	2026-03-20 21:35:13
651	szymon	353	Dane osobowe	Co to sa dane osobowe?	1	3020	2026-03-20 21:35:17
652	szymon	35	Języki programowania	Do czego stosuje się C#?	1	1807	2026-03-20 21:35:21
653	szymon	145	Języki programowania	Co to jest Swift i gdzie się go używa?	1	2909	2026-03-20 21:35:25
654	szymon	146	Języki programowania	Czym jest SQL jako język?	1	4661	2026-03-20 21:35:32
655	szymon	183	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	3595	2026-03-20 21:35:37
656	szymon	175	Bezpieczeństwo IT	Czym Adware różni się od zwykłego Malware?	1	2149	2026-03-20 21:35:41
657	szymon	173	Bezpieczeństwo IT	Co to jest Rootkit?	1	2889	2026-03-20 21:35:45
658	szymon	174	Bezpieczeństwo IT	Co to jest Keylogger?	1	2574	2026-03-20 21:35:49
659	szymon	222	Kryptografia	Dlaczego potrzebujemy liczby d w RSA?	1	6580	2026-03-20 21:35:58
660	szymon	221	Kryptografia	Co oznacza warunek: gcd(e, φ(n)) = 1?	0	3931	2026-03-20 21:36:03
661	szymon	234	Kryptografia	Co jest kluczem publicznym w RSA?	0	5530	2026-03-20 21:36:10
662	szymon	237	Kryptografia	Dlaczego szyfr Cezara jest uznawany za słaby?	1	5034	2026-03-20 21:36:17
663	szymon	235	Kryptografia	Co jest kluczem prywatnym w RSA?	0	4519	2026-03-20 21:36:23
664	szymon	225	Kryptografia	Co jest najtrudniejszym problemem matematycznym stojącym za RSA?	1	6780	2026-03-20 21:36:31
665	szymon	149	Języki programowania	Czym są języki niskopoziomowe?	1	3930	2026-03-20 21:36:37
666	szymon	148	Języki programowania	Co charakteryzuje języki średniopoziomowe?	1	2664	2026-03-20 21:36:41
667	szymon	223	Kryptografia	Jak matematycznie powiązane są e i d w RSA?	1	4095	2026-03-20 21:36:47
668	szymon	236	Kryptografia	Dlaczego nie ujawnia się wartości d w RSA?	1	3639	2026-03-20 21:36:52
669	szymon	147	Języki programowania	Czym charakteryzują się języki wysokopoziomowe?	1	2426	2026-03-20 21:36:56
670	szymon	150	Języki programowania	Co to jest TypeScript?	1	1597	2026-03-20 21:36:59
671	szymon	238	Kryptografia	Ile maksymalnie kluczy ma szyfr Cezara (alfabet 26 liter)?	1	2847	2026-03-20 21:37:04
672	szymon	251	Kryptografia	Dlaczego analiza częstotliwości działa na szyfrach klasycznych?	0	8347	2026-03-20 21:37:14
673	szymon	224	Kryptografia	Dlaczego znajomość tylko e i n nie wystarcza do odszyfrowania?	1	4962	2026-03-20 21:37:20
674	szymon	44	Kompilacja i wykonanie	Co to jest kod źródłowy?	1	3970	2026-03-20 21:37:26
675	szymon	218	Kryptografia	Dlaczego liczba n = p * q musi być duża?	1	4157	2026-03-20 21:37:32
676	szymon	240	Kryptografia	W szyfrze afinicznym warunek dla liczby a wynika z:	1	3916	2026-03-20 21:37:37
677	szymon	258	Kryptografia	Co to jest tekst jawny?	0	8196	2026-03-20 21:37:47
678	szymon	239	Kryptografia	Co jest główną wadą szyfrów symetrycznych?	0	7708	2026-03-20 21:37:56
679	szymon	45	Kompilacja i wykonanie	Na czym polega kompilacja?	1	7927	2026-03-20 21:38:06
680	szymon	151	Języki programowania	Do czego służy Rust?	1	3563	2026-03-20 21:38:11
681	szymon	220	Kryptografia	Dlaczego φ(n) = (p-1)(q-1)?	0	2463	2026-03-20 21:38:15
682	szymon	46	Kompilacja i wykonanie	Czym różni się interpretacja od kompilacji?	1	5268	2026-03-20 21:38:22
683	szymon	219	Kryptografia	Co by się stało, gdyby ktoś poznał liczby p i q?	1	3094	2026-03-20 21:38:27
684	szymon	241	Kryptografia	Co się stanie, jeśli a i 26 nie są względnie pierwsze w szyfrze afinicznym?	0	528	2026-03-20 21:38:29
685	szymon	48	Kompilacja i wykonanie	Na czym polega cykl pobierania-dekodowania-wykonania?	0	1485	2026-03-20 21:38:32
686	szymon	244	Kryptografia	Dlaczego nie ujawnia się wartości φ(n) w RSA?	0	1279	2026-03-20 21:38:35
687	szymon	243	Kryptografia	Na czym polega bezpieczeństwo algorytmu RSA?	0	1341	2026-03-20 21:38:38
688	szymon	96	Bazy danych	Co to jest transakcja w bazie danych?	1	2549	2026-03-22 14:29:04
689	szymon	149	Języki programowania	Czym są języki niskopoziomowe?	1	2065	2026-03-22 14:29:08
690	szymon	176	Algorytmy	Czym jest algorytm?	1	2142	2026-03-22 14:29:12
691	szymon	244	Kryptografia	Dlaczego nie ujawnia się wartości φ(n) w RSA?	1	7396	2026-03-22 14:29:21
692	szymon	219	Kryptografia	Co by się stało, gdyby ktoś poznał liczby p i q?	1	4799	2026-03-22 14:29:27
693	szymon	242	Kryptografia	Dlaczego w RSA wybiera się liczby pierwsze p i q?	0	10114	2026-03-22 14:29:39
694	szymon	229	Kryptografia	Dlaczego RSA jest wolniejszy niż szyfry symetryczne?	1	10900	2026-03-22 14:29:51
695	szymon	95	Bazy danych	Co to jest klucz obcy (FOREIGN KEY)?	1	5181	2026-03-22 14:29:58
696	szymon	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	6667	2026-03-22 14:30:06
697	szymon	70	Algorytmy	Co to jest rekurencja?	0	3816	2026-03-22 14:30:12
698	szymon	124	Protokoły sieciowe	Do czego służy VPN?	1	2866	2026-03-22 15:24:49
699	szymon	296	Operacje logiczne	Ktora operacja logiczna jest podstawa szyfrowania XOR?	1	1864	2026-03-22 15:24:52
700	szymon	100	Architektura komputera	Co to jest ALU?	1	3703	2026-03-22 15:24:57
701	szymon	231	Kryptografia	Dlaczego RSA nie szyfruje całych wiadomości w praktyce?	1	6244	2026-03-22 15:25:05
702	szymon	5	Protokoły sieciowe	Jaka jest główna wada protokołu TELNET?	1	5449	2026-03-22 15:25:12
703	szymon	117	Protokoły sieciowe	Co to jest NAT i po co się go używa?	0	8309	2026-03-22 15:25:22
704	szymon	332	Prawa autorskie	Od kiedy dzielo jest chronione prawem autorskim?	1	4470	2026-03-22 15:25:28
705	szymon	230	Kryptografia	Do czego w praktyce używa się RSA?	0	8997	2026-03-22 15:25:39
706	szymon	366	Piractwo	Co to jest warez?	1	5869	2026-03-22 15:25:47
707	szymon	151	Języki programowania	Do czego służy Rust?	1	5550	2026-03-22 15:25:54
708	szymon	18	Protokoły sieciowe	Czym jest TCP/IP?	1	4087	2026-03-22 15:25:59
709	szymon	337	Prawa autorskie	Czy program komputerowy jest chroniony prawem autorskim?	1	4977	2026-03-22 15:26:06
710	szymon	101	Architektura komputera	Co to jest cache procesora?	1	3533	2026-03-22 15:26:11
711	szymon	339	Prawa autorskie	Czy mozna legalnie zrobic kopie zapasowa legalnie zakupionego programu?	1	6265	2026-03-22 15:26:19
712	szymon	149	Języki programowania	Czym są języki niskopoziomowe?	1	4535	2026-03-22 15:26:25
713	szymon	334	Prawa autorskie	Autorskie prawa osobiste sa:	0	4697	2026-03-22 15:26:31
714	szymon	99	Architektura komputera	Różnica RAM vs ROM?	1	4132	2026-03-22 15:26:37
715	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	2783	2026-03-22 15:26:42
716	szymon	281	Operacje logiczne	Jaki jest wynik operacji: 1 XOR 1?	1	4557	2026-03-23 09:07:08
717	szymon	22	Licencje i prawo IT	Czym jest Freeware?	1	6153	2026-03-23 09:07:16
718	szymon	101	Architektura komputera	Co to jest cache procesora?	1	2391	2026-03-23 09:07:20
719	szymon	99	Architektura komputera	Różnica RAM vs ROM?	1	3645	2026-03-23 09:07:25
720	szymon	129	Licencje i prawo IT	Co to jest Shareware?	0	6509	2026-03-23 09:07:33
721	szymon	238	Kryptografia	Ile maksymalnie kluczy ma szyfr Cezara (alfabet 26 liter)?	1	6251	2026-03-23 09:07:41
722	szymon	266	Kryptografia	Co to jest odwrotność modulo?	1	9554	2026-03-23 09:07:52
723	szymon	208	Architektura komputera	Co to jest ALU?	1	6310	2026-03-23 09:08:00
724	szymon	346	Licencje	Open source oznacza, ze:	1	5495	2026-03-23 09:08:07
725	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	1953	2026-03-23 09:08:10
726	szymon	149	Języki programowania	Czym są języki niskopoziomowe?	0	15000	2026-03-23 09:08:30
727	szymon	75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	0	4724	2026-03-23 09:08:36
728	szymon	235	Kryptografia	Co jest kluczem prywatnym w RSA?	0	2823	2026-03-23 09:08:41
729	szymon	178	Algorytmy	Co to jest rekurencja?	1	6914	2026-03-23 09:08:49
730	szymon	179	Algorytmy	Czym różni się BFS od DFS w grafach?	1	4280	2026-03-23 09:08:55
731	szymon	267	Kryptografia	W RSA liczba n to:	1	5835	2026-03-23 09:09:03
732	szymon	20	Licencje i prawo IT	Co to jest Adware?	0	7774	2026-03-23 09:09:12
733	szymon	275	Kryptografia	HTTPS służy do:	0	7356	2026-03-23 09:09:21
734	szymon	19	Licencje i prawo IT	Co gwarantuje licencja GNU GPL?	1	3444	2026-03-23 09:09:26
735	szymon	177	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	6110	2026-03-23 09:09:34
736	szymon	24	Licencje i prawo IT	Co to jest licencja LGPL?	1	5728	2026-03-23 09:09:41
737	szymon	100	Architektura komputera	Co to jest ALU?	1	1215	2026-03-23 09:09:44
738	szymon	289	Operacje logiczne	Ile wynosi: (0 OR 0) AND 1?	0	5871	2026-03-23 09:09:51
739	szymon	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	6615	2026-03-23 09:10:00
740	szymon	69	Algorytmy	Jak działa sortowanie przez wstawianie (insertion sort)?	1	3226	2026-03-23 09:10:05
741	szymon	239	Kryptografia	Co jest główną wadą szyfrów symetrycznych?	1	7403	2026-03-23 09:10:13
742	szymon	290	Operacje logiczne	Ile wynosi: 1 NAND 1?	1	5787	2026-03-23 09:10:21
743	szymon	222	Kryptografia	Dlaczego potrzebujemy liczby d w RSA?	1	6545	2026-03-23 09:10:29
744	szymon	351	Licencje	Ktora licencja najczesciej chroni systemy Linux?	1	9633	2026-03-23 09:10:40
745	szymon	30	Licencje i prawo IT	Do czego służą Cookies (ciasteczka)?	1	4055	2026-03-23 09:10:46
746	szymon	341	Prawa autorskie	Czy usuniecie znaku wodnego ze zdjeciaw zamieswiedzie w sieci jest legalne?	1	4028	2026-03-23 09:34:14
747	szymon	74	Algorytmy	Co to jest programowanie dynamiczne?	1	3565	2026-03-23 09:34:19
748	szymon	365	Piractwo	Czy sciaganie plikow z nielegalnych zrodel jest przestepstwem?	1	5155	2026-03-23 09:34:26
749	szymon	339	Prawa autorskie	Czy mozna legalnie zrobic kopie zapasowa legalnie zakupionego programu?	1	3601	2026-03-23 09:34:31
750	szymon	340	Prawa autorskie	Czym jest domena publiczna?	0	4263	2026-03-23 09:34:37
751	szymon	72	Algorytmy	Do czego służy algorytm wyszukiwania binarnego?	0	4669	2026-03-23 09:34:43
752	szymon	363	Piractwo	Co to jest piractwo komputerowe?	1	5360	2026-03-23 09:34:50
753	szymon	342	Prawa autorskie	Majatkowe prawa autorskie mozna:	0	6939	2026-03-23 09:34:59
754	szymon	99	Architektura komputera	Różnica RAM vs ROM?	1	2177	2026-03-23 09:35:03
755	szymon	102	Architektura komputera	Co to jest procesor wielordzeniowy?	1	7578	2026-03-23 09:35:12
756	szymon	106	Prawo informatyczne	Co to jest licencja open source?	1	4958	2026-03-23 09:35:19
757	szymon	73	Algorytmy	Jaka jest zasada działania algorytmu Euklidesa?	1	1502	2026-03-23 09:35:22
758	szymon	337	Prawa autorskie	Czy program komputerowy jest chroniony prawem autorskim?	1	2269	2026-03-23 09:35:26
759	szymon	75	Algorytmy	Czym jest algorytm zachłanny (greedy)?	1	3729	2026-03-23 09:35:31
760	szymon	338	Prawa autorskie	Czym jest dozwolony uzytek?	1	5177	2026-03-23 09:35:38
761	szymon	296	Operacje logiczne	Ktora operacja logiczna jest podstawa szyfrowania XOR?	1	3402	2026-03-23 09:35:43
762	szymon	370	Piractwo	Czym jest keygen?	1	6547	2026-03-23 09:35:51
763	szymon	103	Architektura komputera	Co to jest magistrala (bus) w komputerze?	1	3599	2026-03-23 09:35:56
764	szymon	364	Piractwo	Jakie sa konsekwencje prawne piractwa komputerowego w Polsce?	1	5187	2026-03-23 09:36:03
765	szymon	371	Piractwo	Czy udostepnianie zakupionego ebooka znajomym bez zgody wydawcy jest legalne?	1	9810	2026-03-23 09:36:14
766	szymon	105	Prawo informatyczne	Co reguluje RODO?	1	4241	2026-03-23 09:36:20
767	szymon	368	Piractwo	Jakie szkody powoduje piractwo dla tworcow oprogramowania?	0	8269	2026-03-23 09:36:30
768	szymon	100	Architektura komputera	Co to jest ALU?	1	1563	2026-03-23 09:36:33
769	szymon	207	Architektura komputera	Różnica RAM vs ROM?	1	1878	2026-03-23 09:36:37
770	szymon	367	Piractwo	Krakowanie oprogramowania polega na:	1	4657	2026-03-23 09:36:43
771	szymon	372	Piractwo	Programy DRM (Digital Rights Management) sluza do:	1	3713	2026-03-23 09:36:48
772	szymon	216	Prawo informatyczne	Co to jest podpis elektroniczny (e-podpis)?	1	2224	2026-03-23 09:36:52
773	szymon	107	Prawo informatyczne	Czym jest cyberprzestępstwo?	1	5762	2026-03-23 09:37:00
774	szymon	101	Architektura komputera	Co to jest cache procesora?	1	1303	2026-03-23 09:37:03
775	szymon	208	Architektura komputera	Co to jest ALU?	1	1099	2026-03-23 09:37:05
776	szymon	70	Algorytmy	Co to jest rekurencja?	0	2205	2026-03-23 09:37:09
777	szymon	2	Protokoły sieciowe	Co to jest FTP i do czego służy?	1	2773	2026-03-23 09:37:14
778	szymon	215	Prawo informatyczne	Czym jest cyberprzestępstwo?	0	3543	2026-03-23 09:37:19

=== DANE: flashcard_progress ===

=== DANE: sessions ===
id	session_id	created_at
129	sess_1773858814644_bxxtcfy	2026-03-18 19:21:11
146	sess_1773485427401_dkig00i	2026-03-18 20:57:13
177	sess_1773870315518_mtnp5xp	2026-03-18 21:45:31
245	test	2026-03-18 22:24:57
247	szymon	2026-03-18 22:28:33

=== DANE: users ===
id	nick	pin	created_at
1	test	test	2026-03-18 22:24:57
2	szymon	1234	2026-03-18 22:28:33

=== DANE: sql_scenarios ===
id	name	description	ddl	seed	is_active	created_at
1	Biblioteka Miejska	System zarządzania wypożyczalnią książek. Zawiera informacje o autorach, książkach, czytelnikach i wypożyczeniach. Pole data_zwrotu = NULL oznacza książkę jeszcze nieoddaną.	CREATE TABLE autorzy(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,kraj TEXT,rok_urodzenia INTEGER);\nCREATE TABLE ksiazki(id INTEGER PRIMARY KEY,tytul TEXT,autor_id INTEGER,gatunek TEXT,rok_wydania INTEGER,liczba_stron INTEGER,dostepna INTEGER);\nCREATE TABLE czytelnicy(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,miasto TEXT,data_rejestracji TEXT);\nCREATE TABLE wypozyczenia(id INTEGER PRIMARY KEY,ksiazka_id INTEGER,czytelnik_id INTEGER,data_wypozyczenia TEXT,data_zwrotu TEXT);	INSERT INTO autorzy VALUES(1,'Adam','Mickiewicz','Polska',1798);\nINSERT INTO autorzy VALUES(2,'Bolesław','Prus','Polska',1847);\nINSERT INTO autorzy VALUES(3,'Stanisław','Lem','Polska',1921);\nINSERT INTO autorzy VALUES(4,'Fyodor','Dostoyevsky','Rosja',1821);\nINSERT INTO autorzy VALUES(5,'George','Orwell','Wielka Brytania',1903);\nINSERT INTO autorzy VALUES(6,'Gabriel','García Márquez','Kolumbia',1927);\nINSERT INTO autorzy VALUES(7,'Olga','Tokarczuk','Polska',1962);\nINSERT INTO autorzy VALUES(8,'Franz','Kafka','Czechy',1883);\nINSERT INTO ksiazki VALUES(1,'Pan Tadeusz',1,'epika',1834,312,1);\nINSERT INTO ksiazki VALUES(2,'Lalka',2,'powieść',1890,746,0);\nINSERT INTO ksiazki VALUES(3,'Faraon',2,'powieść historyczna',1895,632,1);\nINSERT INTO ksiazki VALUES(4,'Solaris',3,'science fiction',1961,204,1);\nINSERT INTO ksiazki VALUES(5,'Cyberiada',3,'science fiction',1965,318,0);\nINSERT INTO ksiazki VALUES(6,'Zbrodnia i kara',4,'powieść',1866,574,1);\nINSERT INTO ksiazki VALUES(7,'Idiota',4,'powieść',1869,671,0);\nINSERT INTO ksiazki VALUES(8,'Rok 1984',5,'dystopia',1949,328,1);\nINSERT INTO ksiazki VALUES(9,'Folwark zwierzęcy',5,'dystopia',1945,112,1);\nINSERT INTO ksiazki VALUES(10,'Sto lat samotności',6,'realizm magiczny',1967,458,0);\nINSERT INTO ksiazki VALUES(11,'Bieguni',7,'powieść',2007,402,1);\nINSERT INTO ksiazki VALUES(12,'Księgi Jakubowe',7,'powieść historyczna',2014,912,0);\nINSERT INTO ksiazki VALUES(13,'Proces',8,'powieść',1925,198,1);\nINSERT INTO ksiazki VALUES(14,'Zamek',8,'powieść',1926,312,1);\nINSERT INTO ksiazki VALUES(15,'Dziady cz. II',1,'dramat',1823,88,1);\nINSERT INTO czytelnicy VALUES(1,'Marta','Kowalska','Warszawa','2020-03-15');\nINSERT INTO czytelnicy VALUES(2,'Piotr','Nowak','Kraków','2019-11-02');\nINSERT INTO czytelnicy VALUES(3,'Anna','Wiśniewska','Warszawa','2021-06-20');\nINSERT INTO czytelnicy VALUES(4,'Tomasz','Zając','Gdańsk','2020-01-10');\nINSERT INTO czytelnicy VALUES(5,'Karolina','Lewandowska','Kraków','2022-09-05');\nINSERT INTO czytelnicy VALUES(6,'Marek','Wójcik','Wrocław','2019-04-18');\nINSERT INTO czytelnicy VALUES(7,'Ewa','Kamińska','Gdańsk','2023-02-28');\nINSERT INTO czytelnicy VALUES(8,'Jakub','Mazur','Poznań','2021-07-14');\nINSERT INTO czytelnicy VALUES(9,'Zofia','Dąbrowska','Łódź','2020-08-30');\nINSERT INTO czytelnicy VALUES(10,'Robert','Kaczmarek','Poznań','2022-12-01');\nINSERT INTO wypozyczenia VALUES(1,2,1,'2023-01-10','2023-02-05');\nINSERT INTO wypozyczenia VALUES(2,4,1,'2023-03-01','2023-03-20');\nINSERT INTO wypozyczenia VALUES(3,8,1,'2023-05-15','2023-06-10');\nINSERT INTO wypozyczenia VALUES(4,10,1,'2023-07-01',NULL);\nINSERT INTO wypozyczenia VALUES(5,1,2,'2023-02-14','2023-03-01');\nINSERT INTO wypozyczenia VALUES(6,6,2,'2023-04-10','2023-05-30');\nINSERT INTO wypozyczenia VALUES(7,7,2,'2023-08-01',NULL);\nINSERT INTO wypozyczenia VALUES(8,4,3,'2022-11-05','2022-11-25');\nINSERT INTO wypozyczenia VALUES(9,5,3,'2023-01-20','2023-02-15');\nINSERT INTO wypozyczenia VALUES(10,12,3,'2023-09-10',NULL);\nINSERT INTO wypozyczenia VALUES(11,2,3,'2023-10-01',NULL);\nINSERT INTO wypozyczenia VALUES(12,8,4,'2022-06-01','2022-07-15');\nINSERT INTO wypozyczenia VALUES(13,9,4,'2023-03-05','2023-03-25');\nINSERT INTO wypozyczenia VALUES(14,13,5,'2023-05-01','2023-05-20');\nINSERT INTO wypozyczenia VALUES(15,4,5,'2022-12-10','2023-01-10');\nINSERT INTO wypozyczenia VALUES(16,8,6,'2021-09-01','2021-10-20');\nINSERT INTO wypozyczenia VALUES(17,11,6,'2022-03-15','2022-04-30');\nINSERT INTO wypozyczenia VALUES(18,14,6,'2023-06-01',NULL);\nINSERT INTO wypozyczenia VALUES(19,3,7,'2023-07-10','2023-08-05');\nINSERT INTO wypozyczenia VALUES(20,6,8,'2023-02-01','2023-03-10');\nINSERT INTO wypozyczenia VALUES(21,10,8,'2023-08-15',NULL);\nINSERT INTO wypozyczenia VALUES(22,4,8,'2022-05-01','2022-06-20');\nINSERT INTO wypozyczenia VALUES(23,9,9,'2023-01-05','2023-01-28');\nINSERT INTO wypozyczenia VALUES(24,11,9,'2023-04-20','2023-05-15');\nINSERT INTO wypozyczenia VALUES(25,2,9,'2022-09-01','2022-10-15');\nINSERT INTO wypozyczenia VALUES(26,5,10,'2023-03-20',NULL);\nINSERT INTO wypozyczenia VALUES(27,7,10,'2023-08-01',NULL);\nINSERT INTO wypozyczenia VALUES(28,13,10,'2023-09-15',NULL);\nINSERT INTO wypozyczenia VALUES(29,4,1,'2021-06-10','2021-07-20');\nINSERT INTO wypozyczenia VALUES(30,8,5,'2023-10-05',NULL);	1	2026-03-14 20:19:28
2	Sklep Internetowy	System e-commerce. Zawiera produkty podzielone na kategorie, klientów oraz zamówienia składające się z wielu pozycji. Pole data_realizacji = NULL oznacza zamówienie niezrealizowane.	CREATE TABLE kategorie(id INTEGER PRIMARY KEY,nazwa TEXT,opis TEXT);\nCREATE TABLE produkty(id INTEGER PRIMARY KEY,nazwa TEXT,kategoria_id INTEGER,cena REAL,stan_magazynu INTEGER,aktywny INTEGER);\nCREATE TABLE klienci(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,email TEXT,miasto TEXT,data_rejestracji TEXT);\nCREATE TABLE zamowienia(id INTEGER PRIMARY KEY,klient_id INTEGER,data_zamowienia TEXT,data_realizacji TEXT,status TEXT);\nCREATE TABLE pozycje_zamowien(id INTEGER PRIMARY KEY,zamowienie_id INTEGER,produkt_id INTEGER,ilosc INTEGER,cena_jednostkowa REAL);	INSERT INTO kategorie VALUES(1,'Elektronika','Sprzęt elektroniczny i akcesoria');\nINSERT INTO kategorie VALUES(2,'Książki','Literatura i podręczniki');\nINSERT INTO kategorie VALUES(3,'Sport','Sprzęt i odzież sportowa');\nINSERT INTO kategorie VALUES(4,'AGD','Sprzęt gospodarstwa domowego');\nINSERT INTO produkty VALUES(1,'Laptop ProBook',1,2999.99,15,1);\nINSERT INTO produkty VALUES(2,'Słuchawki BT',1,249.00,42,1);\nINSERT INTO produkty VALUES(3,'Klawiatura mechaniczna',1,389.00,28,1);\nINSERT INTO produkty VALUES(4,'Pan Tadeusz',2,29.99,100,1);\nINSERT INTO produkty VALUES(5,'Algorytmy w C++',2,89.99,35,1);\nINSERT INTO produkty VALUES(6,'Atlas geograficzny',2,59.99,20,0);\nINSERT INTO produkty VALUES(7,'Buty biegowe',3,299.00,50,1);\nINSERT INTO produkty VALUES(8,'Mata do jogi',3,79.99,60,1);\nINSERT INTO produkty VALUES(9,'Kask rowerowy',3,149.99,25,1);\nINSERT INTO produkty VALUES(10,'Ekspres do kawy',4,699.00,12,1);\nINSERT INTO produkty VALUES(11,'Blender',4,199.99,30,1);\nINSERT INTO produkty VALUES(12,'Żelazko parowe',4,149.00,18,1);\nINSERT INTO klienci VALUES(1,'Marta','Kowalska','marta@email.pl','Warszawa','2021-03-10');\nINSERT INTO klienci VALUES(2,'Piotr','Nowak','piotr@email.pl','Kraków','2020-08-22');\nINSERT INTO klienci VALUES(3,'Anna','Wiśniewska','anna@email.pl','Gdańsk','2022-01-15');\nINSERT INTO klienci VALUES(4,'Tomasz','Zając','tomasz@email.pl','Warszawa','2021-11-05');\nINSERT INTO klienci VALUES(5,'Karolina','Lewandowska','karo@email.pl','Wrocław','2023-04-20');\nINSERT INTO klienci VALUES(6,'Marek','Wójcik','marek@email.pl','Kraków','2020-06-30');\nINSERT INTO klienci VALUES(7,'Ewa','Kamińska','ewa@email.pl','Poznań','2022-09-12');\nINSERT INTO zamowienia VALUES(1,1,'2023-01-15','2023-01-18','zrealizowane');\nINSERT INTO zamowienia VALUES(2,1,'2023-05-10','2023-05-13','zrealizowane');\nINSERT INTO zamowienia VALUES(3,2,'2023-02-20','2023-02-23','zrealizowane');\nINSERT INTO zamowienia VALUES(4,2,'2023-09-05',NULL,'w realizacji');\nINSERT INTO zamowienia VALUES(5,3,'2023-03-12','2023-03-15','zrealizowane');\nINSERT INTO zamowienia VALUES(6,4,'2023-06-01','2023-06-04','zrealizowane');\nINSERT INTO zamowienia VALUES(7,4,'2023-10-20',NULL,'w realizacji');\nINSERT INTO zamowienia VALUES(8,5,'2023-07-08','2023-07-12','zrealizowane');\nINSERT INTO zamowienia VALUES(9,6,'2023-04-25','2023-04-28','zrealizowane');\nINSERT INTO zamowienia VALUES(10,6,'2023-08-14','2023-08-17','zrealizowane');\nINSERT INTO zamowienia VALUES(11,7,'2023-11-02',NULL,'w realizacji');\nINSERT INTO pozycje_zamowien VALUES(1,1,1,1,2999.99);\nINSERT INTO pozycje_zamowien VALUES(2,1,2,2,249.00);\nINSERT INTO pozycje_zamowien VALUES(3,2,3,1,389.00);\nINSERT INTO pozycje_zamowien VALUES(4,2,8,1,79.99);\nINSERT INTO pozycje_zamowien VALUES(5,3,5,2,89.99);\nINSERT INTO pozycje_zamowien VALUES(6,3,4,3,29.99);\nINSERT INTO pozycje_zamowien VALUES(7,4,10,1,699.00);\nINSERT INTO pozycje_zamowien VALUES(8,4,11,1,199.99);\nINSERT INTO pozycje_zamowien VALUES(9,5,7,1,299.00);\nINSERT INTO pozycje_zamowien VALUES(10,5,9,1,149.99);\nINSERT INTO pozycje_zamowien VALUES(11,6,2,1,249.00);\nINSERT INTO pozycje_zamowien VALUES(12,6,3,2,389.00);\nINSERT INTO pozycje_zamowien VALUES(13,7,1,1,2999.99);\nINSERT INTO pozycje_zamowien VALUES(14,8,8,2,79.99);\nINSERT INTO pozycje_zamowien VALUES(15,8,12,1,149.00);\nINSERT INTO pozycje_zamowien VALUES(16,9,4,5,29.99);\nINSERT INTO pozycje_zamowien VALUES(17,9,5,1,89.99);\nINSERT INTO pozycje_zamowien VALUES(18,10,10,1,699.00);\nINSERT INTO pozycje_zamowien VALUES(19,10,2,3,249.00);\nINSERT INTO pozycje_zamowien VALUES(20,11,7,2,299.00);\nINSERT INTO pozycje_zamowien VALUES(21,11,3,1,389.00);	1	2026-03-14 20:19:28
3	Turniej Szachowy	Baza danych federacji szachowej. Zawiera zawodników z rankingiem ELO, turnieje, rozegrane mecze i ich wyniki. Wynik meczu: W=wygrana białymi, B=wygrana czarnymi, R=remis.	CREATE TABLE zawodnicy(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,kraj TEXT,ranking_elo INTEGER,rok_urodzenia INTEGER);\nCREATE TABLE turnieje(id INTEGER PRIMARY KEY,nazwa TEXT,miasto TEXT,rok INTEGER,liczba_rund INTEGER,typ TEXT);\nCREATE TABLE mecze(id INTEGER PRIMARY KEY,turniej_id INTEGER,runda INTEGER,bialy_id INTEGER,czarny_id INTEGER,wynik TEXT,data_meczu TEXT);	INSERT INTO zawodnicy VALUES(1,'Magnus','Carlsen','Norwegia',2830,1990);\nINSERT INTO zawodnicy VALUES(2,'Fabiano','Caruana','USA',2804,1992);\nINSERT INTO zawodnicy VALUES(3,'Ding','Liren','Chiny',2788,1992);\nINSERT INTO zawodnicy VALUES(4,'Ian','Nepomniachtchi','Rosja',2771,1990);\nINSERT INTO zawodnicy VALUES(5,'Anish','Giri','Holandia',2745,1994);\nINSERT INTO zawodnicy VALUES(6,'Levon','Aronian','Armenia',2735,1982);\nINSERT INTO zawodnicy VALUES(7,'Jan-Krzysztof','Duda','Polska',2724,1998);\nINSERT INTO zawodnicy VALUES(8,'Radosław','Wojtaszek','Polska',2698,1987);\nINSERT INTO zawodnicy VALUES(9,'Alireza','Firouzja','Francja',2760,2003);\nINSERT INTO zawodnicy VALUES(10,'Hikaru','Nakamura','USA',2768,1987);\nINSERT INTO turnieje VALUES(1,'Grand Chess Tour Warszawa','Warszawa',2023,9,'round-robin');\nINSERT INTO turnieje VALUES(2,'Puchar Polski Open','Kraków',2023,7,'swiss');\nINSERT INTO turnieje VALUES(3,'Memorial Rubinsteina','Polanica-Zdrój',2022,9,'round-robin');\nINSERT INTO turnieje VALUES(4,'Błyskawica Gdańsk','Gdańsk',2023,5,'swiss');\nINSERT INTO mecze VALUES(1,1,1,1,2,'W','2023-06-10');\nINSERT INTO mecze VALUES(2,1,1,3,4,'R','2023-06-10');\nINSERT INTO mecze VALUES(3,1,1,5,6,'B','2023-06-10');\nINSERT INTO mecze VALUES(4,1,2,2,3,'R','2023-06-11');\nINSERT INTO mecze VALUES(5,1,2,4,5,'W','2023-06-11');\nINSERT INTO mecze VALUES(6,1,2,7,8,'W','2023-06-11');\nINSERT INTO mecze VALUES(7,1,3,1,3,'W','2023-06-12');\nINSERT INTO mecze VALUES(8,1,3,9,10,'R','2023-06-12');\nINSERT INTO mecze VALUES(9,1,4,2,4,'B','2023-06-13');\nINSERT INTO mecze VALUES(10,1,4,1,5,'W','2023-06-13');\nINSERT INTO mecze VALUES(11,1,5,6,7,'R','2023-06-14');\nINSERT INTO mecze VALUES(12,1,5,3,9,'B','2023-06-14');\nINSERT INTO mecze VALUES(13,2,1,7,2,'R','2023-09-01');\nINSERT INTO mecze VALUES(14,2,1,8,5,'W','2023-09-01');\nINSERT INTO mecze VALUES(15,2,2,10,7,'B','2023-09-02');\nINSERT INTO mecze VALUES(16,2,2,2,8,'W','2023-09-02');\nINSERT INTO mecze VALUES(17,2,3,7,5,'W','2023-09-03');\nINSERT INTO mecze VALUES(18,2,4,8,10,'R','2023-09-04');\nINSERT INTO mecze VALUES(19,2,4,7,1,'R','2023-09-04');\nINSERT INTO mecze VALUES(20,3,1,1,4,'W','2022-08-05');\nINSERT INTO mecze VALUES(21,3,1,7,6,'W','2022-08-05');\nINSERT INTO mecze VALUES(22,3,2,5,1,'R','2022-08-06');\nINSERT INTO mecze VALUES(23,3,3,1,6,'W','2022-08-07');\nINSERT INTO mecze VALUES(24,3,4,7,4,'W','2022-08-08');\nINSERT INTO mecze VALUES(25,4,1,7,9,'W','2023-11-10');\nINSERT INTO mecze VALUES(26,4,2,10,7,'R','2023-11-11');\nINSERT INTO mecze VALUES(27,4,3,7,3,'B','2023-11-12');\nINSERT INTO mecze VALUES(28,4,4,1,7,'R','2023-11-13');\nINSERT INTO mecze VALUES(29,4,5,7,2,'W','2023-11-14');	1	2026-03-14 20:19:28

=== DANE: sql_tasks ===
id	scenario_id	title	difficulty	description	hint	solution	is_active	created_at
1	1	Zadanie 1. (0–2) Najbardziej aktywny czytelnik	hard	Podaj imię i nazwisko czytelnika, który wypożyczył łącznie najwięcej książek (uwzględnij wszystkie wypożyczenia, również te gdzie książka nie została jeszcze zwrócona). Jeśli jest kilku takich czytelników, wypisz wszystkich — posortuj alfabetycznie po nazwisku.	Użyj GROUP BY c.id z COUNT(*), następnie ogranicz wynik do MAX za pomocą podzapytania lub HAVING COUNT(*)=(SELECT MAX(cnt) FROM ...).	SELECT c.imie, c.nazwisko FROM czytelnicy c JOIN wypozyczenia w ON c.id=w.czytelnik_id GROUP BY c.id HAVING COUNT(*)=(SELECT MAX(cnt) FROM (SELECT COUNT(*) as cnt FROM wypozyczenia GROUP BY czytelnik_id) sub) ORDER BY c.nazwisko	1	2026-03-14 20:19:28
2	1	Zadanie 2. (0–2) Książki nigdy nie wypożyczone	hard	Podaj tytuły książek, które nie zostały ani razu wypożyczone. Posortuj alfabetycznie po tytule.	Użyj NOT IN z podzapytaniem: WHERE id NOT IN (SELECT DISTINCT ksiazka_id FROM wypozyczenia).	SELECT tytul FROM ksiazki WHERE id NOT IN (SELECT DISTINCT ksiazka_id FROM wypozyczenia) ORDER BY tytul	1	2026-03-14 20:19:28
3	1	Zadanie 3. (0–2) Gatunek z największą łączną liczbą stron	hard	Podaj nazwę gatunku, dla którego suma liczby stron wszystkich książek tego gatunku jest największa. Istnieje dokładnie jeden taki gatunek.	GROUP BY gatunek, ORDER BY SUM(liczba_stron) DESC LIMIT 1.	SELECT gatunek FROM ksiazki GROUP BY gatunek ORDER BY SUM(liczba_stron) DESC LIMIT 1	12026-03-14 20:19:28
4	1	Zadanie 4. (0–2) Czytelnicy przetrzymujący więcej niż 2 książki	hard	Podaj imię i nazwisko czytelników, którzy aktualnie przetrzymują więcej niż 2 nieoddane książki (data_zwrotu IS NULL). Posortuj po nazwisku.	WHERE w.data_zwrotu IS NULL GROUP BY c.id HAVING COUNT(*) > 2.	SELECT c.imie, c.nazwisko FROM czytelnicy c JOIN wypozyczenia w ON c.id=w.czytelnik_id WHERE w.data_zwrotu IS NULL GROUP BY c.id HAVING COUNT(*)>2 ORDER BY c.nazwisko	1	2026-03-14 20:19:28
5	1	Zadanie 5. (0–2) Najdłużej przetrzymana książka	hard	Podaj tytuł książki, która była wypożyczona najdłużej (największa liczba dni między data_wypozyczenia a data_zwrotu). Uwzględniaj tylko zakończone wypożyczenia. Istnieje dokładnie jeden taki rekord.	Użyj julianday(data_zwrotu) - julianday(data_wypozyczenia) do obliczenia liczby dni. ORDER BY ... DESC LIMIT 1.	SELECT k.tytul FROM ksiazki k JOIN wypozyczenia w ON k.id=w.ksiazka_id WHERE w.data_zwrotu IS NOT NULL ORDER BY (julianday(w.data_zwrotu)-julianday(w.data_wypozyczenia)) DESC LIMIT 1	1	2026-03-14 20:19:28
6	1	Zadanie 6. (0–2) Średni czas wypożyczenia wg gatunku	hard	Dla każdego gatunku oblicz średni czas wypożyczenia w dniach (zaokrąglony do 1 miejsca po przecinku), uwzględniając tylko zakończone wypożyczenia. Posortuj malejąco po średnim czasie.	AVG(julianday(data_zwrotu) - julianday(data_wypozyczenia)), GROUP BY gatunek, ORDER BY srednia DESC.	SELECT k.gatunek, ROUND(AVG(julianday(w.data_zwrotu)-julianday(w.data_wypozyczenia)),1) as srednia FROM ksiazki k JOIN wypozyczenia w ON k.id=w.ksiazka_id WHERE w.data_zwrotu IS NOT NULL GROUP BY k.gatunek ORDER BY srednia DESC	1	2026-03-14 20:19:28
7	1	Zadanie 7. (0–2) Czytelnicy którzy wypożyczali każdy gatunek	hard	Podaj imię i nazwisko czytelników, którzy wypożyczyli co najmniej jedną książkę z KAŻDEGO gatunku obecnego w bazie. Posortuj po nazwisku.	GROUP BY c.id HAVING COUNT(DISTINCT k.gatunek) = (SELECT COUNT(DISTINCT gatunek) FROM ksiazki).	SELECT c.imie, c.nazwisko FROM czytelnicy c JOIN wypozyczenia w ON c.id=w.czytelnik_id JOIN ksiazki k ON w.ksiazka_id=k.id GROUP BY c.id HAVING COUNT(DISTINCT k.gatunek)=(SELECT COUNT(DISTINCT gatunek) FROM ksiazki) ORDER BY c.nazwisko	1	2026-03-14 20:19:28
8	2	Zadanie 8. (0–2) Produkt o największych łącznych przychodach	hard	Podaj nazwę produktu, który wygenerował największy łączny przychód (suma ilosc * cena_jednostkowa ze wszystkich pozycji zamówień). Istnieje dokładnie jeden taki produkt.	JOIN pozycje_zamowien, GROUP BY produkt_id, SUM(ilosc*cena_jednostkowa), ORDER BY DESC LIMIT 1.	SELECT p.nazwa FROM produkty p JOIN pozycje_zamowien pz ON p.id=pz.produkt_id GROUP BY p.id ORDER BY SUM(pz.ilosc*pz.cena_jednostkowa) DESC LIMIT 1	1	2026-03-14 20:19:28
9	2	Zadanie 9. (0–2) Klienci bez żadnego zrealizowanego zamówienia	hard	Podaj imię i nazwisko klientów, którzy nie mają ani jednego zamówienia o statusie 'zrealizowane'. Uwzględnij też klientów bez żadnych zamówień. Posortuj po nazwisku.	NOT IN: WHERE id NOT IN (SELECT klient_id FROM zamowienia WHERE status='zrealizowane').	SELECT imie, nazwisko FROM klienci WHERE id NOT IN (SELECT klient_id FROM zamowienia WHERE status='zrealizowane') ORDER BY nazwisko	1	2026-03-14 20:19:28
10	2	Zadanie 10. (0–2) Kategoria z największą średnią ceną produktów aktywnych	hard	Podaj nazwę kategorii, której aktywne produkty (aktywny = 1) mają największą średnią cenę. Istnieje dokładnie jeden taki wynik.	JOIN kategorie, WHERE aktywny=1, GROUP BY kategoria_id, ORDER BY AVG(cena) DESC LIMIT 1.	SELECT k.nazwa FROM kategorie k JOIN produkty p ON k.id=p.kategoria_id WHERE p.aktywny=1 GROUP BY k.id ORDER BY AVG(p.cena) DESC LIMIT 1	1	2026-03-14 20:19:28
11	2	Zadanie 11. (0–2) Wartość niezrealizowanych zamówień wg klienta	hard	Dla każdego klienta mającego przynajmniej jedno niezrealizowane zamówienie podaj imię, nazwisko i łączną wartość tych zamówień (suma ilosc*cena_jednostkowa). Posortuj malejąco po wartości.	WHERE z.data_realizacji IS NULL, JOIN pozycje_zamowien, GROUP BY klient_id, SUM(ilosc*cena_jednostkowa).	SELECT kl.imie, kl.nazwisko, SUM(pz.ilosc*pz.cena_jednostkowa) as wartosc FROM klienci kl JOIN zamowienia z ON kl.id=z.klient_id JOIN pozycje_zamowien pz ON z.id=pz.zamowienie_id WHERE z.data_realizacji IS NULL GROUP BY kl.id ORDER BY wartosc DESC	1	2026-03-14 20:19:28
12	2	Zadanie 12. (0–2) Produkty nigdy nie zamówione	medium	Podaj nazwy produktów, które nie zostały ani razu zamówione (nie ma ich w żadnej pozycji zamówienia). Posortuj alfabetycznie.	WHERE id NOT IN (SELECT DISTINCT produkt_id FROM pozycje_zamowien).	SELECT nazwa FROM produkty WHERE id NOT IN (SELECT DISTINCT produkt_id FROM pozycje_zamowien) ORDER BY nazwa	12026-03-14 20:19:28
13	3	Zadanie 13. (0–2) Zawodnik z największą liczbą wygranych meczów	hard	Zawodnik wygrywa mecz gdy gra białymi i wynik = 'W', lub gdy gra czarnymi i wynik = 'B'. Podaj imię, nazwisko i łączną liczbę wygranych meczów zawodnika z największą ich liczbą. Istnieje dokładnie jeden taki zawodnik.	Zlicz wygrane jako biały: WHERE bialy_id=z.id AND wynik='W', i jako czarny: WHERE czarny_id=z.id AND wynik='B'. Sumuj oba przypadki.	SELECT z.imie, z.nazwisko, COUNT(*) as wygrane FROM zawodnicy z JOIN mecze m ON (z.id=m.bialy_id AND m.wynik='W') OR (z.id=m.czarny_id AND m.wynik='B') GROUP BY z.id ORDER BY wygrane DESC LIMIT 1	1	2026-03-14 20:19:28
14	3	Zadanie 14. (0–2) Zawodnicy z Polski w więcej niż 1 turnieju	hard	Podaj imię, nazwisko i liczbę turniejów zawodników z Polski, którzy brali udział (jako biały lub czarny) w więcej niż jednym turnieju. Posortuj po nazwisku.	INNER JOIN mecze (biały lub czarny), COUNT(DISTINCT turniej_id) > 1, WHERE kraj='Polska'.	SELECT z.imie, z.nazwisko, COUNT(DISTINCT m.turniej_id) as turnieje FROM zawodnicy z JOIN mecze m ON z.id=m.bialy_id OR z.id=m.czarny_id WHERE z.kraj='Polska' GROUP BY z.id HAVING COUNT(DISTINCT m.turniej_id)>1 ORDER BY z.nazwisko	1	2026-03-14 20:19:28
15	3	Zadanie 15. (0–2) Turniej z największym odsetkiem remisów	hard	Podaj nazwę turnieju, w którym odsetek remisów (mecze z wynikiem 'R' do wszystkich meczów) był największy. Istnieje dokładnie jeden taki turniej. Wyraź wynik jako wartość dziesiętną zaokrągloną do 2 miejsc.	ROUND(SUM(CASE WHEN wynik='R' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2), GROUP BY turniej_id.	SELECT t.nazwa FROM turnieje t JOIN mecze m ON t.id=m.turniej_id GROUP BY t.id ORDER BY ROUND(SUM(CASE WHEN m.wynik='R' THEN 1.0 ELSE 0 END)/COUNT(*),2) DESC LIMIT 1	1	2026-03-14 20:19:28
16	3	Zadanie 16. (0–2) Zawodnicy którzy nigdy nie remisowali	hard	Podaj imię, nazwisko i kraj zawodników, którzy rozegrali co najmniej jeden mecz, ale nie zremisowali ani razu (żaden mecz z ich udziałem nie ma wyniku 'R'). Posortuj po nazwisku.	Zawodnik grał: (bialy_id=id OR czarny_id=id). Brak remisu: nie istnieje mecz z wynikiem R i udziałem tego zawodnika.	SELECT DISTINCT z.imie, z.nazwisko, z.kraj FROM zawodnicy z WHERE z.id IN (SELECT bialy_id FROM mecze UNION SELECT czarny_id FROM mecze) AND z.id NOT IN (SELECT bialy_id FROM mecze WHERE wynik='R' UNION SELECT czarny_id FROM mecze WHERE wynik='R') ORDER BY z.nazwisko	1	2026-03-14 20:19:28
17	3	Zadanie 17. (0–2) Ranking zawodników w turnieju Grand Chess Tour Warszawa	hard	Dla turnieju „Grand Chess Tour Warszawa" oblicz punktację każdego zawodnika: wygrana = 1 pkt, remis = 0.5 pkt, przegrana = 0 pkt. Podaj imię, nazwisko i punkty, posortuj malejąco po punktach, a przy równej liczbie punktów — alfabetycznie po nazwisku.	SUM(CASE WHEN bialy_id=z.id AND wynik='W' THEN 1 WHEN bialy_id=z.id AND wynik='R' THEN 0.5 ... END).	SELECT z.imie, z.nazwisko, SUM(CASE WHEN m.bialy_id=z.id AND m.wynik='W' THEN 1.0 WHEN m.bialy_id=z.id AND m.wynik='R' THEN 0.5 WHEN m.czarny_id=z.id AND m.wynik='B' THEN 1.0 WHEN m.czarny_id=z.id AND m.wynik='R' THEN 0.5 ELSE 0 END) as pkt FROM zawodnicy z JOIN mecze m ON z.id=m.bialy_id OR z.id=m.czarny_id WHERE m.turniej_id=1 GROUP BY z.id ORDER BY pkt DESC, z.nazwisko	1	2026-03-14 20:19:28

=== DANE: sql_attempts ===
id	session_id	task_id	task_title	query	is_correct	error_msg	attempted_at	task_id_ref	scenario_id
9	sess_1773858814644_bxxtcfy	11	Zadanie 11. (0–2) Wartość niezrealizowanych zamówień wg klienta	Select klienci.imie, klienci.nazwisko, Sum(pozycje_zamowien.ilosc * produkty.cena) from klienci\nINNER JOIN zamowienia (INNER JOIN pozycje_zamowien (INNER JOIN produkty on produkty.id = pozycje_zamowien.produkt_id) on pozycje_zamowien.zamowienie_id = zamowienie.id ) on zamowienia.klient_id = klienci.id where zamowienia.status = "niezrealizowane" group by klienci.imie, klienci.nazwisko, Sum(pozycje_zamowien.ilosc * produkty.cena) order by Sum(pozycje_zamowien.ilosc * produkty.cena) DESC	0	near "JOIN": syntax error	2026-03-18 20:26:30	11	NULL
10	sess_1773485427401_dkig00i	14	Zadanie 14. (0–2) Zawodnicy z Polski w więcej niż 1 turnieju	select * from zawodnicy;	0	NULL	2026-03-18 21:15:35	14	NULL
11	sess_1773485427401_dkig00i	14	Zadanie 14. (0–2) Zawodnicy z Polski w więcej niż 1 turnieju	SELECT z.imie, z.nazwisko, COUNT(DISTINCT m.turniej_id) as turnieje FROM zawodnicy z JOIN mecze m ON z.id=m.bialy_id OR z.id=m.czarny_id WHERE z.kraj='Polska' GROUP BY z.id HAVING COUNT(DISTINCT m.turniej_id)>1 ORDER BY z.nazwisko	1	NULL	2026-03-18 21:15:59	14	NULL
12	szymon	16	Zadanie 16. (0–2) Zawodnicy którzy nigdy nie remisowali	select zawodnicy.imie, zawodnicy.nazwisko, count(mecze.id) as licznik from zawodnicy inner join mecze on zawodnicy.id = mecze.bialy_id or zawodnicy.id = mecze.czarny_id where mecze.wynik not like 'R' having licznik > 0;	0	NULL	2026-03-19 22:37:36	16	NULL
13	szymon	16	Zadanie 16. (0–2) Zawodnicy którzy nigdy nie remisowali	SELECT DISTINCT z.imie, z.nazwisko, z.kraj FROM zawodnicy z WHERE z.id IN (SELECT bialy_id FROM mecze UNION SELECT czarny_id FROM mecze) AND z.id NOT IN (SELECT bialy_id FROM mecze WHERE wynik='R' UNION SELECT czarny_id FROM mecze WHERE wynik='R') ORDER BY z.nazwisko	1	NULL	2026-03-19 22:37:58	16	NULL
14	szymon	8	Zadanie 8. (0–2) Produkt o największych łącznych przychodach	select produkty.nazwa from produkty inner join pozycje_zamowien on produkty.id = pozycje_zamowien.produkt_id GROUP BY pozycje_zamowien.produkt_id ORDER BY SUM(pozycje_zamowien.ilosc*produkty.cena) DESC LIMIT 1.	1	NULL	2026-03-22 14:20:46	8	NULL
15	szymon	17	Zadanie 17. (0–2) Ranking zawodników w turnieju Grand Chess Tour Warszawa	SELECT z.imie, z.nazwisko, SUM(CASE WHEN m.bialy_id=z.id AND m.wynik='W' THEN 1.0 WHEN m.bialy_id=z.id AND m.wynik='R' THEN 0.5 WHEN m.czarny_id=z.id AND m.wynik='B' THEN 1.0 WHEN m.czarny_id=z.id AND m.wynik='R' THEN 0.5 ELSE 0 END) as pkt FROM zawodnicy z JOIN mecze m ON z.id=m.bialy_id OR z.id=m.czarny_id WHERE m.turniej_id=1 GROUP BY z.id ORDER BY pkt DESC, z.nazwisko	1	NULL	2026-03-22 14:28:50	17	NULL
16	szymon	10	Zadanie 10. (0–2) Kategoria z największą średnią ceną produktów aktywnych	select kategorie.nazwa from kategorie inner join produkty on produkty.kategoria_id = kategorie.id where produkty.aktywny = 1 group by kategorie.nazwa order by avg(produkty.cena) desc limit 1;	1	NULL	2026-03-22 15:09:43	10	NULL
17	szymon	10	Zadanie 10. (0–2) Kategoria z największą średnią ceną produktów aktywnych	select kategorie.nazwa from kategorie inner join produkty on produkty.kategoria_id = kategorie.id where produkty.aktywny = 1 group by kategorie.nazwa order by avg(produkty.cena) desc limit 1;	1	NULL	2026-03-22 15:09:48	10	NULL
szymon@atari:/opt/matura$ 
