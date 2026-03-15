# Matura Informatyka – Trener Algorytmiki i SQL

Pełnoprawna aplikacja webowa do nauki na maturę z informatyki.
- **Frontend**: HTML/CSS/JS (single-page, zero frameworków)
- **Backend**: Node.js + Express
- **Baza danych**: MariaDB
- **Tester C++**: prawdziwy kompilator `g++` – uruchamia testy i zwraca wyniki

---

## Wymagania

| Narzędzie | Wersja |
|-----------|--------|
| Node.js   | ≥ 18   |
| MariaDB   | ≥ 10.6 |
| g++       | ≥ 11   |

```bash
# Ubuntu/Debian
sudo apt install g++ mariadb-server nodejs npm

# macOS
brew install gcc mariadb node
```

---

## Instalacja krok po kroku

### 1. Baza danych

```bash
# Uruchom MariaDB
sudo systemctl start mariadb   # Linux
brew services start mariadb    # macOS

# Utwórz bazę i wgraj schemat
mysql -u root -p < backend/schema.sql
```

### 2. Backend

```bash
cd backend
npm install
```

Skonfiguruj zmienne środowiskowe (lub edytuj wartości domyślne w `server.js`):

```bash
export DB_HOST=127.0.0.1
export DB_PORT=3306
export DB_USER=root
export DB_PASSWORD=0000
export DB_NAME=matura_db
export PORT=3001
```

Uruchom serwer:

```bash
node server.js
# lub (z auto-restartem):
npx nodemon server.js
```

Sprawdź czy działa:
```bash
curl http://localhost:3001/api/health
# → {"ok":true,"db":"connected"}
```

### 3. Frontend

Otwórz plik `frontend/index.html` w przeglądarce:

```bash
# Opcja A – bezpośrednio
open frontend/index.html          # macOS
xdg-open frontend/index.html      # Linux

# Opcja B – serwer statyczny (zalecane)
cd frontend
python3 -m http.server 8080
# → http://localhost:8080
```

W polu **API** w górnym pasku wpisz: `http://localhost:3001`

---

## Struktura projektu

```
matura/
├── backend/
│   ├── server.js       # Serwer Express + runner g++ + endpointy
│   ├── schema.sql      # Schemat MariaDB + seed zadań i testów
│   └── package.json
└── frontend/
    └── index.html      # Cała aplikacja (HTML/CSS/JS)
```

---

## Endpointy API

| Metoda | Ścieżka | Opis |
|--------|---------|------|
| GET  | `/api/health`              | Status serwera i bazy |
| GET  | `/api/tasks`               | Lista zadań algorytmicznych |
| POST | `/api/algo/submit`         | Sprawdź kod C++ (kompilacja + testy) |
| POST | `/api/sql/attempt`         | Zapisz próbę SQL |
| POST | `/api/quiz/result`         | Zapisz wynik pytania quizowego |
| POST | `/api/flashcard/seen`      | Aktualizuj postęp fiszki |
| GET  | `/api/stats/:session_id`   | Statystyki sesji |
| GET  | `/api/history/algo/:session_id` | Historia prób algorytmiki |
| GET  | `/api/history/quiz/:session_id` | Historia quizów |

---

## Jak działa tester C++

1. Frontend wysyła kod do `POST /api/algo/submit`
2. Backend zapisuje kod do pliku tymczasowego w `/tmp/matura-XXXX/solution.cpp`
3. Kompiluje: `g++ -O2 -std=c++17 -o solution solution.cpp`
4. Jeśli kompilacja się nie powiedzie → zwraca błąd kompilatora
5. Dla każdego testu z bazy (`algo_task_tests`):
   - Uruchamia `./solution` z `input_data` na stdin
   - Porównuje stdout z `expected` (trim + normalize)
   - Timeout: 3 sekundy
6. Zwraca tablicę wyników z: `passed`, `time_ms`, `input`, `expected`, `got`
7. Testy oznaczone `is_hidden=1` nie pokazują wejścia/wyjścia uczniowi

---

## Dodawanie zadań

Wstaw zadanie do bazy:

```sql
INSERT INTO algo_tasks (title, difficulty, description, hint, ex_input, ex_output)
VALUES ('Moje nowe zadanie', 'medium', 'Opis...', 'Wskazówka...', '5\n1 2 3 4 5', '15');

-- Dodaj testy (ostatni wstawiony id)
INSERT INTO algo_task_tests (task_id, test_name, input_data, expected, is_hidden)
VALUES (LAST_INSERT_ID(), 'test_podstawowy', '5\n1 2 3 4 5', '15', 0);
```

---------

```sql
CREATE DATABASE `matura_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;


-- matura_db.algo_attempts definition

CREATE TABLE `algo_attempts` (
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
  KEY `idx_task` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.algo_task_tests definition

CREATE TABLE `algo_task_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `test_name` varchar(100) NOT NULL,
  `input_data` text NOT NULL,
  `expected` text NOT NULL,
  `is_hidden` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `algo_task_tests_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `algo_tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.algo_tasks definition

CREATE TABLE `algo_tasks` (
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.algo_test_results definition

CREATE TABLE `algo_test_results` (
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
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.flashcard_progress definition

CREATE TABLE `flashcard_progress` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `question_id` int(11) NOT NULL,
  `seen_count` int(11) DEFAULT 0,
  `correct_count` int(11) DEFAULT 0,
  `last_seen` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sess_q` (`session_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.quiz_questions definition

CREATE TABLE `quiz_questions` (
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
  KEY `idx_quiz_cat` (`category`),
  KEY `idx_quiz_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.quiz_results definition

CREATE TABLE `quiz_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `question_id` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `question_text` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `time_ms` int(11) NOT NULL,
  `answered_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_sess_quiz` (`session_id`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.sessions definition

CREATE TABLE `sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`),
  KEY `idx_session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- matura_db.sql_attempts definition

CREATE TABLE `sql_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL,
  `task_id` int(11) NOT NULL,
  `task_title` varchar(200) NOT NULL,
  `query` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `error_msg` text DEFAULT NULL,
  `attempted_at` datetime DEFAULT current_timestamp(),
  `task_id_ref` int(11) DEFAULT NULL,
  `scenario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sess_sql` (`session_id`),
  KEY `idx_sql_task` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- matura_db.sql_scenarios definition

CREATE TABLE `sql_scenarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ddl` mediumtext NOT NULL,
  `seed` mediumtext NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_sql_scenario_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- matura_db.sql_tasks definition

CREATE TABLE `sql_tasks` (
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```
