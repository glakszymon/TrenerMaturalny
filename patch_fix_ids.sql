-- =====================================================
-- TrenerMaturalny: External DB ID Fix Patch
-- Generated: 2026-03-23
--
-- Fixes the ID mismatch on external servers where
-- algo_tasks got sequential IDs (1-37) instead of
-- the canonical gapped IDs (1-14, 16-24, 26-29, 31-40).
--
-- This patch:
--   1. Deletes all mismatched test cases
--   2. Remaps algo_tasks.id to the gapped scheme
--   3. Remaps algo_attempts.task_id accordingly
--   4. Re-inserts correct test cases (208 total)
--   5. Sets AUTO_INCREMENT = 41
--
-- Usage:
--   docker exec -i CONTAINER mariadb -u USER -pPASS DB < patch_fix_ids.sql
-- =====================================================

SET FOREIGN_KEY_CHECKS = 0;

-- ===== PART 1: Delete all mismatched test cases =====
DELETE FROM matura_db.algo_task_tests;

-- ===== PART 2: Remap task IDs (sequential -> gapped) =====
-- Process from highest to lowest to avoid PK conflicts

UPDATE matura_db.algo_tasks SET id = 40 WHERE id = 37;
UPDATE matura_db.algo_attempts SET task_id = 40 WHERE task_id = 37;
UPDATE matura_db.algo_tasks SET id = 39 WHERE id = 36;
UPDATE matura_db.algo_attempts SET task_id = 39 WHERE task_id = 36;
UPDATE matura_db.algo_tasks SET id = 38 WHERE id = 35;
UPDATE matura_db.algo_attempts SET task_id = 38 WHERE task_id = 35;
UPDATE matura_db.algo_tasks SET id = 37 WHERE id = 34;
UPDATE matura_db.algo_attempts SET task_id = 37 WHERE task_id = 34;
UPDATE matura_db.algo_tasks SET id = 36 WHERE id = 33;
UPDATE matura_db.algo_attempts SET task_id = 36 WHERE task_id = 33;
UPDATE matura_db.algo_tasks SET id = 35 WHERE id = 32;
UPDATE matura_db.algo_attempts SET task_id = 35 WHERE task_id = 32;
UPDATE matura_db.algo_tasks SET id = 34 WHERE id = 31;
UPDATE matura_db.algo_attempts SET task_id = 34 WHERE task_id = 31;
UPDATE matura_db.algo_tasks SET id = 33 WHERE id = 30;
UPDATE matura_db.algo_attempts SET task_id = 33 WHERE task_id = 30;
UPDATE matura_db.algo_tasks SET id = 32 WHERE id = 29;
UPDATE matura_db.algo_attempts SET task_id = 32 WHERE task_id = 29;
UPDATE matura_db.algo_tasks SET id = 31 WHERE id = 28;
UPDATE matura_db.algo_attempts SET task_id = 31 WHERE task_id = 28;
UPDATE matura_db.algo_tasks SET id = 29 WHERE id = 27;
UPDATE matura_db.algo_attempts SET task_id = 29 WHERE task_id = 27;
UPDATE matura_db.algo_tasks SET id = 28 WHERE id = 26;
UPDATE matura_db.algo_attempts SET task_id = 28 WHERE task_id = 26;
UPDATE matura_db.algo_tasks SET id = 27 WHERE id = 25;
UPDATE matura_db.algo_attempts SET task_id = 27 WHERE task_id = 25;
UPDATE matura_db.algo_tasks SET id = 26 WHERE id = 24;
UPDATE matura_db.algo_attempts SET task_id = 26 WHERE task_id = 24;
UPDATE matura_db.algo_tasks SET id = 24 WHERE id = 23;
UPDATE matura_db.algo_attempts SET task_id = 24 WHERE task_id = 23;
UPDATE matura_db.algo_tasks SET id = 23 WHERE id = 22;
UPDATE matura_db.algo_attempts SET task_id = 23 WHERE task_id = 22;
UPDATE matura_db.algo_tasks SET id = 22 WHERE id = 21;
UPDATE matura_db.algo_attempts SET task_id = 22 WHERE task_id = 21;
UPDATE matura_db.algo_tasks SET id = 21 WHERE id = 20;
UPDATE matura_db.algo_attempts SET task_id = 21 WHERE task_id = 20;
UPDATE matura_db.algo_tasks SET id = 20 WHERE id = 19;
UPDATE matura_db.algo_attempts SET task_id = 20 WHERE task_id = 19;
UPDATE matura_db.algo_tasks SET id = 19 WHERE id = 18;
UPDATE matura_db.algo_attempts SET task_id = 19 WHERE task_id = 18;
UPDATE matura_db.algo_tasks SET id = 18 WHERE id = 17;
UPDATE matura_db.algo_attempts SET task_id = 18 WHERE task_id = 17;
UPDATE matura_db.algo_tasks SET id = 17 WHERE id = 16;
UPDATE matura_db.algo_attempts SET task_id = 17 WHERE task_id = 16;
UPDATE matura_db.algo_tasks SET id = 16 WHERE id = 15;
UPDATE matura_db.algo_attempts SET task_id = 16 WHERE task_id = 15;

-- ===== PART 3: Set AUTO_INCREMENT =====
ALTER TABLE matura_db.algo_tasks AUTO_INCREMENT = 41;

SET FOREIGN_KEY_CHECKS = 1;

-- ===== PART 4: Re-insert correct test cases (208 tests) =====

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (1,'zero','0','NIE',0),
	 (1,'jeden','1','NIE',0),
	 (1,'dwa','2','TAK',0),
	 (1,'trzy','3','TAK',0),
	 (1,'cztery','4','NIE',0),
	 (1,'siedemnascie','17','TAK',0),
	 (1,'duza_pierwsza','1000000007','TAK',1),
	 (1,'duza_zlozona','1000000008','NIE',1),
	 (1,'zlozena_25','25','NIE',1),
	 (2,'dwa','2','2',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (2,'cztery','4','2^2',0),
	 (2,'dwanascie','12','2^2 * 3',0),
	 (2,'trzysta','360','2^3 * 3^2 * 5',0),
	 (2,'pierwsza','997','997',1),
	 (2,'milion','1000000','2^6 * 5^6',1),
	 (3,'jeden_elem_ok','1
5
5','0',0),
	 (3,'jeden_elem_brak','1
5
3','-1',0),
	 (3,'siedem_elem','7
1 3 5 7 9 11 13
7','3',0),
	 (3,'brak_w_tablicy','5
2 4 6 8 10
1','-1',1),
	 (3,'ostatni_elem','5
2 4 6 8 10
10','4',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (4,'zero','0','0',0),
	 (4,'jeden','1','1',0),
	 (4,'dwa','2','10',0),
	 (4,'czterdziesci_dwa','42','101010',0),
	 (4,'osiem_bitow','255','11111111',1),
	 (4,'miliard','1000000000','111011100110101100101000000000',1),
	 (5,'klasyczny','48 18','6',0),
	 (5,'zero_b','0 5','5',0),
	 (5,'a_zero','5 0','5',0),
	 (5,'oba_zero','0 0','0',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (5,'wzglednie_pierwsze','13 7','1',1),
	 (5,'duze_liczby','1000000000000000000 999999999999999999','1',1),
	 (6,'jeden_elem','1
7','7
0',0),
	 (6,'juz_posortowane','5
1 2 3 4 5','1 2 3 4 5
0',0),
	 (6,'odwrotne','5
5 4 3 2 1','1 2 3 4 5
10',0),
	 (6,'przyklad','5
5 3 1 4 2','1 2 3 4 5
7',1),
	 (7,'tylko_dwa','2','2',0),
	 (7,'do_dziesiec','10','2
3
5
7',0),
	 (7,'do_dwadziescia','20','2
3
5
7
11
13
17
19',0),
	 (7,'do_trzydziesci','30','2
3
5
7
11
13
17
19
23
29',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (8,'szesc','6','TAK',0),
	 (8,'dwadziescia_osiem','28','TAK',0),
	 (8,'jeden','1','NIE',0),
	 (8,'dwanascie','12','NIE',0),
	 (8,'czterysta_dziewiec','496','TAK',1),
	 (8,'osiem_tysiecy','8128','TAK',1),
	 (8,'duza_zlozona','100','NIE',1),
	 (9,'zero','0','0',0),
	 (9,'jeden','1','1',0),
	 (9,'dziesiec','10','A',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (9,'ff','255','FF',0),
	 (9,'sto','256','100',0),
	 (9,'cafe','51966','CAFE',1),
	 (9,'miliard','1000000000','3B9ACA00',1),
	 (10,'binarny_zero','0 2','0',0),
	 (10,'binarny_42','42 2','101010',0),
	 (10,'osemkowy_255','255 8','377',0),
	 (10,'hex_255','255 16','FF',0),
	 (10,'trojkowy_10','10 3','101',0),
	 (10,'hex_miliard','1000000000 16','3B9ACA00',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (11,'przyklad','12 8','4
24',0),
	 (11,'wzglednie','13 7','1
91',0),
	 (11,'rowne','6 6','6
6',0),
	 (11,'jeden_jeden','1 1','1
1',0),
	 (11,'duze','999999999 1000000000','1
999999999000000000',1),
	 (12,'listen_silent','listen
silent','TAK',0),
	 (12,'hello_world','hello
world','NIE',0),
	 (12,'abc_cba','abc
cba','TAK',0),
	 (12,'rozna_dlugosc','ab
abc','NIE',0),
	 (12,'jedno_slowo','a
a','TAK',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (12,'puste_rozne','ab
ba','TAK',1),
	 (13,'przyklad','ababcabab
ab','0
2
5
7',0),
	 (13,'brak','hello
xyz','BRAK',0),
	 (13,'poczatek','abcdef
abc','0',0),
	 (13,'koniec','xyzabc
abc','3',0),
	 (13,'caly_tekst','abc
abc','0',0),
	 (13,'wielokrotne','aaaaaa
aa','0
1
2
3
4',1),
	 (14,'przyklad','hello world
3','khoor zruog',0),
	 (14,'zero','abc
0','abc',0),
	 (14,'dwadziescia_szesc','abc
26','abc',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (14,'pelny_obrot','xyz
3','abc',0),
	 (14,'ze_spacjami','ab cd
1','bc de',1),
	 (14,'jeden_znak','z
1','a',1),
	 (16,'przyklad','48 18','6
4',0),
	 (16,'b_zero','5 0','5
1',0),
	 (16,'rowne','7 7','7
2',0),
	 (16,'wzglednie_pierw','13 7','1
4',1),
	 (16,'duze','1000000000000000000 999999999999999999','1
3',1),
	 (17,'przyklad','6
3 1 4 1 5 9','1
9
8',0),
	 (17,'jeden_elem','1
42','42
42
0',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (17,'dwa_elem','2
5 3','3
5
1',0),
	 (17,'posortowane','4
1 2 3 4','1
4
5',0),
	 (17,'wszystkie_rowne','4
7 7 7 7','7
7
5',1),
	 (18,'przyklad','5
5 3 1 4 2','1 2 3 4 5
7',0),
	 (18,'jeden','1
7','7
0',0),
	 (18,'juz_posortowane','4
1 2 3 4','1 2 3 4
4',0),
	 (18,'odwrotne','4
4 3 2 1','1 2 3 4
4',0),
	 (18,'dwa_elem','2
2 1','1 2
1',1),
	 (18,'wiekszy','8
8 7 6 5 4 3 2 1','1 2 3 4 5 6 7 8
12',1),
	 (19,'przyklad','1.0 2.0 0.000001','1.521380',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (19,'szersza','0.0 3.0 0.000001','1.521380',0),
	 (19,'dokladna','1.0 2.0 0.0000001','1.521380',1),
	 (20,'sqrt2','2','1.414214',0),
	 (20,'sqrt9','9','3.000000',0),
	 (20,'sqrt1','1','1.000000',0),
	 (20,'sqrt100','100','10.000000',0),
	 (20,'sqrt2_5','2.25','1.500000',1),
	 (21,'przyklad','2
1 -3 2
3','2',0),
	 (21,'stala','0
5
100','5',0),
	 (21,'liniowy','1
2 1
3','7',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (21,'x_zero','3
1 2 3 4
0','4',0),
	 (21,'ujemne_x','2
1 0 -1
-2','3',1),
	 (22,'przyklad','2 10','1024',0),
	 (22,'zero_exp','5 0','1',0),
	 (22,'jeden_base','1 1000000000000000000','1',0),
	 (22,'modulo','2 30','73741817',0),
	 (22,'duze','2 1000000000','140625001',1),
	 (22,'zero_base','0 5','0',1),
	 (23,'przyklad','2 10','1024
5',0),
	 (23,'zero_exp','5 0','1
1',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (23,'dwa_jeden','2 1','2
2',0),
	 (23,'dwa_osiem','2 8','256
5',1),
	 (24,'n0','3 0','3/1',0),
	 (24,'n1','3 1','4/1',0),
	 (24,'n2','3 2','16/3',0),
	 (24,'n3','9 3','64/3',0),
	 (24,'n5','3 5','1024/81',1),
	 (26,'przyklad','ABCBDAB
BDCAB','4
BCAB',0),
	 (26,'identyczne','ABC
ABC','3
ABC',0),
	 (26,'rozlaczne','ABC
XYZ','0
',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (26,'jeden_znak','A
A','1
A',0),
	 (26,'dlugi','AGGTAB
GXTXAYB','4
GTAB',1),
	 (27,'przyklad','3 + 4 * 2','3 4 2 * +
11',0),
	 (27,'nawiasy','( 2 + 3 ) * 4','2 3 + 4 *
20',0),
	 (27,'samo_dodanie','1 + 2','1 2 +
3',0),
	 (27,'zlozone','2 * ( 3 + 4 ) - 1','2 3 4 + * 1 -
13',1),
	 (28,'przyklad','41
3
25 10 1','8
25 x 1
10 x 1
1 x 6',0),
	 (28,'zero','0
2
10 1','0',0),
	 (28,'dokładny','100
2
50 25','2
50 x 2
25 x 0',0),
	 (28,'jeden_grosz','7
3
5 2 1','2
5 x 1
2 x 1
1 x 0',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (29,'przyklad','8
10 9 2 5 3 7 101 18','4
2 3 7 18',0),
	 (29,'jeden','1
5','1
5',0),
	 (29,'malejace','4
4 3 2 1','1
1',0),
	 (29,'rosnace','5
1 2 3 4 5','5
1 2 3 4 5',0),
	 (29,'z_rownoscia','5
3 3 3 3 3','1
3',1),
	 (31,'przyklad','5
PUSH 3
PUSH 7
TOP
POP
EMPTY','7
7
0',0),
	 (31,'pusty','1
EMPTY','1',0),
	 (31,'push_pop','3
PUSH 1
POP
EMPTY','1
1',0),
	 (31,'trzy_push','4
PUSH 5
PUSH 3
PUSH 1
TOP','1',1),
	 (32,'przyklad','5
ENQUEUE 3
ENQUEUE 7
FRONT
DEQUEUE
EMPTY','3
3
0',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (32,'pusty','1
EMPTY','1',0),
	 (32,'fifo_order','4
ENQUEUE 1
ENQUEUE 2
DEQUEUE
DEQUEUE','1
2',0),
	 (32,'front_nie_usuwa','3
ENQUEUE 9
FRONT
FRONT','9
9',1),
	 (33,'przyklad','7
1 3 5 7 9 11 13
7','3
1',0),
	 (33,'pierwszy','5
1 2 3 4 5
1','0
2',0),
	 (33,'ostatni','5
1 2 3 4 5
5','4
3',0),
	 (33,'brak','3
1 3 5
4','-1
3',0),
	 (33,'jeden_elem','1
42
42','0
1',1),
	 (34,'n10','10','55
11',0),
	 (34,'n0','0','0
1',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (34,'n1','1','1
2',0),
	 (34,'n5','5','5
6',0),
	 (34,'n20','20','6765
21',1),
	 (34,'n50','50','12586269025
51',1),
	 (35,'przyklad','5 6
1 2
1 3
2 4
3 4
4 5
3 5
1 5','2',0),
	 (35,'bezposredni','2 1
1 2
1 2','1',0),
	 (35,'brak','3 2
1 2
2 3
1 3','1',0),
	 (35,'rozlaczny','4 2
1 2
3 4
1 4','-1',0),
	 (35,'ten_sam','3 2
1 2
2 3
2 2','0',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (36,'przyklad','5
5 3 1 4 2','1 2 3 4 5
7',0),
	 (36,'jeden_elem','1
7','7
0',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (36,'juz_posortowane','5
1 2 3 4 5','1 2 3 4 5
0',0),
	 (36,'odwrotne','4
4 3 2 1','1 2 3 4
6',0),
	 (36,'dwa_elem_ok','2
1 2','1 2
0',0),
	 (36,'dwa_elem_swap','2
2 1','1 2
1',1),
	 (36,'wszystkie_rowne','4
3 3 3 3','3 3 3 3
0',1),
	 (36,'wiekszy','6
6 5 4 3 2 1','1 2 3 4 5 6
15',1),
	 (37,'przyklad','5
3 6 8 10 1','1 3 6 8 10
10',0),
	 (37,'jeden_elem','1
42','42
0',0),
	 (37,'dwa_posortowane','2
1 2','1 2
1',0),
	 (37,'dwa_odwrotne','2
2 1','1 2
1',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (37,'juz_posortowane','5
1 2 3 4 5','1 2 3 4 5
10',0),
	 (37,'odwrotne','5
5 4 3 2 1','1 2 3 4 5
10',1),
	 (37,'rowne','4
2 2 2 2','2 2 2 2
3',1),
	 (38,'przyklad','5
3 1 4 1 5
4','2
3',0),
	 (38,'pierwszy','4
7 2 3 4
7','0
1',0),
	 (38,'ostatni','4
1 2 3 5
5','3
4',0),
	 (38,'brak','3
1 2 3
9','-1
3',0),
	 (38,'jeden_elem_ok','1
42
42','0
1',0),
	 (38,'pierwsze_wyst','6
1 2 1 2 1 2
1','0
1',1),
	 (38,'duzy_brak','5
10 20 30 40 50
99','-1
5',1);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (39,'n0','0','0',0),
	 (39,'n1','1','1',0),
	 (39,'n2','2','1',0),
	 (39,'n10','10','55',0),
	 (39,'n20','20','6765',0),
	 (39,'n50','50','12586269025',1),
	 (39,'n93','93','12200160415121876738',1),
	 (40,'kajak','kajak','TAK',0),
	 (40,'hello','hello','NIE',0),
	 (40,'jeden_znak','a','TAK',0);

INSERT INTO matura_db.algo_task_tests (task_id,test_name,input_data,expected,is_hidden) VALUES
	 (40,'dwa_palindrom','aa','TAK',0),
	 (40,'dwa_nie','ab','NIE',0),
	 (40,'radar','radar','TAK',0),
	 (40,'abcba','abcba','TAK',1),
	 (40,'abcde','abcde','NIE',1),
	 (40,'dlugi_tak','amanaplanacanalpanama','TAK',1),
	 (40,'parzysta','abba','TAK',1);

-- ===== Verification =====
SELECT t.id, t.title, COALESCE(c.cnt, 0) AS tests
FROM matura_db.algo_tasks t
LEFT JOIN (SELECT task_id, COUNT(*) AS cnt FROM matura_db.algo_task_tests GROUP BY task_id) c
ON t.id = c.task_id ORDER BY t.id;
