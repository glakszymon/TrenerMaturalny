INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Protokoły sieciowe','Do czego służy protokół HTTP?','HTTP (Hypertext Transfer Protocol) – protokół przesyłania stron internetowych.','Automatyczne przydzielanie adresów IP','Szyfrowane przesyłanie plików','Przesyłanie stron internetowych między przeglądarką a serwerem','Zdalny dostęp do komputera',2,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Co to jest FTP i do czego służy?','FTP (File Transfer Protocol) – protokół służący do przesyłania plików między klientem a serwerem.','Tłumaczenie nazw domenowych na adresy IP','Przesyłanie plików między klientem a serwerem','Zarządzanie urządzeniami sieciowymi','Synchronizacja czasu systemowego',1,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Czym HTTPS różni się od HTTP?','HTTPS to zabezpieczona wersja HTTP, wykorzystuje SSL/TLS do szyfrowania danych.','HTTPS działa wyłącznie w sieciach lokalnych','HTTPS jest wolniejszy, ale bardziej niezawodny','HTTPS używa innego portu i innego formatu pakietów','HTTPS szyfruje dane za pomocą SSL/TLS w odróżnieniu od HTTP',3,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Co umożliwia technologia VoIP?','VoIP (Voice over Internet Protocol) umożliwia przesyłanie głosu przez Internet.','Szyfrowanie połączeń w sieci lokalnej','Prowadzenie rozmów głosowych przez Internet','Zdalny dostęp do plików na serwerze','Zarządzanie ruchem sieciowym',1,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Jaka jest główna wada protokołu TELNET?','TELNET przesyła dane (w tym hasła) w niezabezpieczonej formie tekstowej.','Przesyła dane w niezaszyfrowanej formie tekstowej','Działa tylko w sieciach IPv6','Nie obsługuje połączeń zdalnych','Wymaga instalacji dodatkowego sprzętu',0,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','W czym SSH jest lepszy od TELNET?','SSH (Secure Shell) używa szyfrowania danych, w przeciwieństwie do TELNET.','SSH jest szybszy i obsługuje więcej urządzeń','SSH działa tylko lokalnie, TELNET przez Internet','SSH nie wymaga uwierzytelniania','SSH szyfruje dane – TELNET przesyła je jako czysty tekst',3,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Co robi protokół DHCP?','DHCP automatycznie przydziela adresy IP oraz inne parametry sieciowe urządzeniom.','Tłumaczy nazwy domen na adresy IP','Szyfruje połączenia w sieci lokalnej','Automatycznie przydziela adresy IP urządzeniom w sieci','Zarządza trasowaniem pakietów między sieciami',2,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Za co odpowiada system DNS?','DNS (Domain Name System) tłumaczy nazwy domenowe na adresy IP.','Tłumaczy nazwy domenowe na adresy IP','Przydziela adresy IP w sieciach lokalnych','Zarządza bezpieczeństwem połączeń','Monitoruje ruch sieciowy',0,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Co to jest NAT i po co się go używa?','NAT (Network Address Translation) mapuje wiele prywatnych adresów IP na jeden publiczny.','Metoda kompresji pakietów sieciowych','Protokół do szyfrowania transmisji danych','System synchronizacji zegarów sieciowych','Mapowanie wielu prywatnych IP na jeden publiczny',3,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Do czego służy protokół SNMP?','SNMP (Simple Network Management Protocol) służy do zarządzania i monitorowania urządzeń sieciowych.','Przesyłanie poczty elektronicznej','Zarządzanie i monitorowanie urządzeń sieciowych','Szyfrowanie ruchu w sieci WAN','Synchronizacja czasu na urządzeniach sieciowych',1,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Protokoły sieciowe','Do czego służy protokół NTP?','NTP (Network Time Protocol) służy do synchronizacji czasu systemowego.','Przesyłania plików w sieci lokalnej','Synchronizacji czasu systemowego w sieci','Zarządzania adresami IP','Monitorowania przepustowości łącza',1,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Jaka jest rola protokołu SMTP?','SMTP (Simple Mail Transfer Protocol) jest używany do wysyłania poczty elektronicznej.','Pobieranie poczty na urządzenie klienta','Zarządzanie skrzynką na wielu urządzeniach jednocześnie','Wysyłanie poczty elektronicznej między serwerami','Szyfrowanie wiadomości e-mail',2,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Czym POP3 różni się od IMAP?','POP3 pobiera pocztę na urządzenie i usuwa ją z serwera. IMAP synchronizuje skrzynkę na wielu urządzeniach.','POP3 szyfruje pocztę, IMAP nie','POP3 pobiera i usuwa pocztę z serwera; IMAP synchronizuje ją na wielu urządzeniach','POP3 obsługuje tylko tekst, IMAP też załączniki','Oba protokoły działają identycznie',1,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Czym jest protokół SSL?','SSL (Secure Sockets Layer) to protokół kryptograficzny zapewniający bezpieczne połączenia.','Protokół kryptograficzny szyfrujący dane między klientem a serwerem','Protokół do przesyłania plików multimedialnych','Protokół zarządzania adresami w sieci','System nazw domenowych',0,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Jaka jest relacja między TLS a SSL?','TLS (Transport Layer Security) jest następcą SSL, zapewnia nowocześniejsze szyfrowanie.','TLS i SSL to dwie niezależne i równoważne technologie','TLS jest starszy i mniej bezpieczny niż SSL','TLS działa tylko w sieciach IPv6','TLS jest następcą SSL i zapewnia nowocześniejsze szyfrowanie',3,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Do czego służy VPN?','VPN (Virtual Private Network) tworzy bezpieczny szyfrowany tunel przez Internet.','Przyspiesza pobieranie plików z Internetu','Zarządza domenami i adresami IP','Tworzy bezpieczny tunel przez Internet do sieci prywatnych','Monitoruje ruch w sieci lokalnej',2,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Czym jest serwer Proxy?','Serwer Proxy działa jako pośrednik między klientem a serwerem, służy do filtrowania ruchu.','Pośrednik między klientem a serwerem filtrujący ruch','Urządzenie przydzielające adresy IP','System szyfrowania połączeń','Protokół do zdalnego zarządzania',0,1,'2026-03-15 16:08:10'),
	 ('Protokoły sieciowe','Czym jest TCP/IP?','TCP/IP to zestaw protokołów stanowiący podstawę internetu. TCP dzieli dane na pakiety, IP adresuje je.','Jeden protokół do szyfrowania połączeń','Zestaw protokołów stanowiący podstawę internetu – TCP pakietuje dane, IP adresuje je','System nazw domenowych','Protokół zarządzania urządzeniami sieciowymi',1,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Co gwarantuje licencja GNU GPL?','GNU GPL pozwala uruchamiać, modyfikować i dystrybuować oprogramowanie; zmiany muszą być na tej samej licencji.','Dowolne użycie bez obowiązku udostępniania zmian','Bezpłatne użycie tylko do celów osobistych','Uruchamianie, modyfikowanie i dystrybucję – zmiany muszą być na tej samej licencji','Używanie kodu tylko w projektach komercyjnych',2,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Co to jest Adware?','Adware to darmowe oprogramowanie wyświetlające reklamy.','Złośliwe oprogramowanie blokujące pliki','Oprogramowanie wymagające subskrypcji','Oprogramowanie szyfrujące dysk','Darmowe oprogramowanie finansowane przez wyświetlanie reklam',3,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Licencje i prawo IT','Co to jest Shareware?','Shareware to oprogramowanie dostępne bezpłatnie przez ograniczony czas lub z ograniczoną funkcjonalnością.','Oprogramowanie dostępne bezpłatnie przez ograniczony czas lub z ograniczoną funkcją','Oprogramowanie całkowicie darmowe na zawsze','Oprogramowanie open source z dostępem do kodu','Oprogramowanie wymagające opłaty miesięcznej',0,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Czym jest Freeware?','Freeware to oprogramowanie całkowicie darmowe do użytku, bez możliwości modyfikacji.','Oprogramowanie na licencji GPL','Darmowe oprogramowanie, którego nie wolno modyfikować ani redystrybuować zmienionej wersji','Oprogramowanie open source z kodem źródłowym','Oprogramowanie dostępne przez 30-dniowy trial',1,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Co charakteryzuje licencję MIT?','Licencja MIT jest bardzo liberalna – pozwala na dowolne użycie z zachowaniem informacji o autorze.','Wymaga udostępnienia kodu pochodnego na tej samej licencji','Dozwolona tylko do użytku niekomercyjnego','Zabrania dystrybucji bez zgody właściciela','Pozwala na dowolne użycie z zachowaniem informacji o autorze',3,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Co to jest licencja LGPL?','LGPL pozwala na linkowanie do bibliotek bez konieczności udostępniania całego kodu na tej samej licencji.','Licencja zabraniająca komercyjnego użycia bibliotek','Pozwala linkować biblioteki bez wymogu udostępniania całego kodu na tej samej licencji','Wymaga pełnego open source całej aplikacji','Jest identyczna z GPL',1,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Co to jest Proprietary License?','Licencja zastrzeżona zabrania kopiowania, modyfikowania lub dystrybucji bez zgody właściciela.','Licencja pozwalająca na dowolne modyfikacje','Licencja wymagająca publikacji kodu źródłowego','Licencja zastrzegająca wyłączne prawa właściciela – zakaz kopii i modyfikacji bez zgody','Licencja do użytku wyłącznie edukacyjnego',2,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Czym jest licencja subskrypcyjna?','Model subskrypcyjny umożliwia korzystanie z oprogramowania w zamian za regularne opłaty.','Jednorazowy zakup oprogramowania na zawsze','Bezpłatne oprogramowanie finansowane reklamami','Licencja tylko dla instytucji edukacyjnych','Regularne opłaty za dostęp do oprogramowania i aktualizacji',3,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Co to są licencje Creative Commons?','CC to zestaw licencji umożliwiających twórcom udostępnianie prac na określonych zasadach.','Licencje wyłącznie dla oprogramowania komercyjnego','Zestaw licencji do udostępniania prac twórczych na określonych zasadach','Protokół szyfrowania komunikacji','System zarządzania prawami autorskimi w UE',1,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Kiedy powstaje ochrona praw autorskich?','Prawa autorskie chronią twórcę automatycznie od momentu stworzenia dzieła, bez żadnych formalności.','Po opublikowaniu w Internecie','Po zarejestrowaniu w urzędzie patentowym','Po upływie 70 lat od powstania','Automatycznie od momentu stworzenia dzieła – bez żadnych formalności',3,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Na czym polega Prawo Cytatu?','Prawo Cytatu pozwala używać fragmentów treści chronionej w celach edukacji lub krytyki z podaniem autora.','Prawo do kopiowania całych dzieł w celach edukacyjnych','Prawo do używania fragmentów chronionej treści z podaniem autora i źródła','Prawo autora do wycofania dzieła z obiegu','Prawo do tłumaczenia dzieła bez zgody autora',1,1,'2026-03-15 16:08:10'),
	 ('Licencje i prawo IT','Do czego służą Cookies (ciasteczka)?','Cookies to małe pliki tekstowe zapisywane przez strony WWW zapamiętujące preferencje i stan sesji.','Pliki złośliwego oprogramowania pobierane automatycznie','Protokół szyfrowania danych w przeglądarkach','Mechanizm blokowania reklam w przeglądarce','Małe pliki tekstowe zapamiętujące preferencje i stan sesji na stronach WWW',3,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Języki programowania','Co to jest język programowania?','Język programowania to formalny język z instrukcjami do tworzenia oprogramowania.','Formalny język z instrukcjami do tworzenia oprogramowania','Naturalny język do komunikacji z użytkownikiem','Protokół sieciowy do przesyłania kodu','System operacyjny do uruchamiania programów',0,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Co to jest Python i gdzie się go stosuje?','Python to wysokopoziomowy język stosowany w Data Science, AI, automatyzacji oraz web developmencie.','Język niskopoziomowy do programowania układów FPGA','Język wyłącznie do tworzenia aplikacji mobilnych','Wysokopoziomowy język do AI, Data Science, automatyzacji i web developmentu','Język dedykowany systemom iOS i macOS',2,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Do czego służy JavaScript?','JavaScript to język używany w web developmencie (front-end i back-end), aplikacjach mobilnych oraz serwerach.','Tworzenie sterowników i systemów operacyjnych','Web development (front-end i back-end), aplikacje mobilne i serwerowe','Projektowanie układów cyfrowych FPGA','Programowanie systemów wbudowanych',1,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Do czego używa się języka Java?','Java to język do aplikacji webowych, mobilnych (Android), systemów wbudowanych i serwerowych.','Wyłącznie do gier komputerowych','Programowanie GPU i obliczeń równoległych','Tworzenie aplikacji wyłącznie na iOS','Aplikacje webowe, mobilne (Android), systemy wbudowane i serwerowe',3,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Do czego stosuje się C#?','C# to język do aplikacji desktopowych, webowych, gier (Unity) oraz aplikacji mobilnych.','Aplikacje desktopowe, webowe, gry (Unity) i mobilne','Wyłącznie do aplikacji serwerowych Linux','Programowanie mikrokontrolerów Arduino','Projektowanie układów ASIC',0,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Gdzie najczęściej stosuje się PHP?','PHP to język do tworzenia stron WWW, systemów CMS i aplikacji serwerowych.','Tworzenie gier 3D i silników graficznych','Strony WWW, systemy CMS i aplikacje serwerowe','Programowanie sterowników urządzeń','Aplikacje na systemy iOS i macOS',1,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Co to jest Swift i gdzie się go używa?','Swift to język stworzony przez Apple, przeznaczony do tworzenia aplikacji na iOS i macOS.','Język do programowania aplikacji Android','Język do data science i analizy danych','Język Apple do tworzenia aplikacji na iOS i macOS','Język skryptowy do automatyzacji Windows',2,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Czym jest SQL jako język?','SQL (Structured Query Language) to specjalistyczny język służący do zarządzania relacyjnymi bazami danych.','Język ogólnego przeznaczenia do aplikacji webowych','Język niskopoziomowy do programowania systemowego','Język skryptowy do automatyzacji zadań','Język specjalistyczny do zarządzania relacyjnymi bazami danych',3,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Czym charakteryzują się języki wysokopoziomowe?','Języki wysokopoziomowe mają wysoką abstrakcję od sprzętu, zbliżone do języka naturalnego.','Dają bezpośrednią kontrolę nad sprzętem bez abstrakcji','Wymagają ręcznego zarządzania pamięcią','Są zbliżone do języka naturalnego, łatwe w nauce, mają bogate biblioteki','Działają tylko na jednej platformie',2,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Co charakteryzuje języki średniopoziomowe?','Języki średniopoziomowe łączą cechy wysokiego i niskiego poziomu. Przykłady: C, C++, Rust.','Są identyczne z językami wysokopoziomowymi','Działają wyłącznie na systemach wbudowanych','Nie mogą być kompilowane','Łączą kontrolę nad sprzętem z pewną abstrakcją – np. C, C++, Rust',3,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Języki programowania','Czym są języki niskopoziomowe?','Języki niskopoziomowe mają minimalną abstrakcję i są bliskie kodowi maszynowemu. Przykład: Assembly.','Języki zbliżone do języka naturalnego','Języki bliskie kodowi maszynowemu z maksymalną kontrolą nad sprzętem – np. Assembly','Języki wyłącznie do baz danych','Języki interpretowane działające w przeglądarce',1,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Co to jest TypeScript?','TypeScript to typowana wersja JavaScriptu używana w zaawansowanym web developmencie.','Nowy język do tworzenia aplikacji mobilnych','Język do tworzenia baz danych','Typowana wersja JavaScript do zaawansowanego web developmentu','Asembler dla procesorów ARM',2,1,'2026-03-15 16:08:10'),
	 ('Języki programowania','Do czego służy Rust?','Rust to język do systemów operacyjnych, oprogramowania wbudowanego i aplikacji wymagających wydajności.','Systemy operacyjne, oprogramowanie wbudowane, aplikacje o wysokiej wydajności','Tworzenie stron internetowych i aplikacji webowych','Wyłącznie aplikacje mobilne Android','Data Science i analiza statystyczna',0,1,'2026-03-15 16:08:10'),
	 ('Kompilacja i wykonanie','Co to jest kod źródłowy?','Kod źródłowy to tekst programu napisany przez programistę przed kompilacją.','Kod maszynowy wykonywany przez procesor','Skompilowany plik wykonywalny .exe','Zestaw instrukcji asemblerowych','Tekst programu napisany przez programistę przed kompilacją',3,1,'2026-03-15 16:08:10'),
	 ('Kompilacja i wykonanie','Na czym polega kompilacja?','Kompilacja to proces tłumaczenia kodu źródłowego na kod maszynowy.','Tłumaczenie kodu w czasie rzeczywistym bez generowania pliku','Debugowanie i testowanie programu','Tłumaczenie kodu źródłowego na kod maszynowy – powstaje plik wykonywalny','Łączenie modułów i bibliotek w finalny plik',2,1,'2026-03-15 16:08:10'),
	 ('Kompilacja i wykonanie','Czym różni się interpretacja od kompilacji?','Interpretacja polega na tłumaczeniu i wykonywaniu kodu w czasie rzeczywistym bez pliku wykonywalnego.','Interpretacja tworzy plik .exe, kompilacja nie','Oba procesy są identyczne','Interpretacja wykonuje kod na bieżąco bez pliku wykonywalnego; kompilacja tworzy plik','Interpretacja działa tylko na serwerach',2,1,'2026-03-15 16:08:10'),
	 ('Kompilacja i wykonanie','Co robi Linker?','Linker to narzędzie łączące skompilowane moduły i biblioteki w finalny plik wykonywalny.','Kompiluje kod źródłowy na kod asemblerowy','Łączy skompilowane moduły i biblioteki w finalny plik wykonywalny','Debuguje błędy w kodzie źródłowym','Uruchamia program w środowisku wirtualnym',1,1,'2026-03-15 16:08:10'),
	 ('Kompilacja i wykonanie','Na czym polega cykl pobierania-dekodowania-wykonania?','To podstawowy proces procesora: pobiera instrukcję z pamięci, dekoduje ją, a następnie wykonuje.','Metoda zarządzania pamięcią podręczną','Podstawowy cykl procesora: pobierz instrukcję → zdekoduj → wykonaj','Protokół komunikacji między rdzeniami procesora','Proces kompilacji kodu do pliku wykonywalnego',1,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Jaka jest główna różnica między TCP a UDP?','TCP jest połączeniowy i gwarantuje dostarczenie danych. UDP jest bezpołączeniowy i szybszy.','TCP i UDP działają identycznie','UDP gwarantuje dostarczenie; TCP nie','TCP działa w warstwie fizycznej','TCP gwarantuje dostarczenie (połączeniowy); UDP nie gwarantuje',3,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Do której warstwy modelu OSI należy HTTP?','HTTP to warstwa 7 – aplikacji. Inne: HTTPS, FTP, SMTP, DNS.','Warstwa 4 – transportowa','Warstwa 7 – aplikacji','Warstwa 3 – sieciowa','Warstwa 2 – łącza danych',1,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Sieci komputerowe','Co to jest adres MAC?','Unikalny 48-bitowy identyfikator sprzętowy karty sieciowej. Działa w warstwie 2 OSI.','Adres logiczny przydzielany przez DHCP','Unikalny identyfikator sprzętowy karty sieciowej (warstwa 2)','Nazwa hosta w sieci lokalnej','Identyfikator sesji TCP',1,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Co to jest LAN?','LAN (Local Area Network) to sieć łącząca urządzenia na ograniczonym obszarze.','Sieć obejmująca cały kraj lub kontynent','Sieć łącząca miasta w kraju','Bezprzewodowa sieć rozległa','Sieć lokalna łącząca urządzenia na ograniczonym obszarze np. biuro',3,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Co to jest MAN?','MAN (Metropolitan Area Network) łączy wiele sieci LAN na obszarze miasta lub kampusu.','Sieć łącząca sieci LAN w obszarze miasta lub kampusu','Sieć lokalna w jednym budynku','Sieć globalna łącząca kontynenty','Bezprzewodowa sieć w zasięgu Bluetooth',0,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Do czego służy Router?','Router łączy różne sieci i kieruje ruchem między nimi na podstawie adresów IP.','Rozgłasza dane do wszystkich portów jednocześnie','Przydziela adresy IP w sieci','Łączy urządzenia w jednej sieci lokalnej na podstawie MAC','Łączy różne sieci i kieruje ruchem na podstawie adresów IP',3,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Czym się różni Switch od Hub?','Switch inteligentnie kieruje pakiety do właściwych portów na podstawie MAC. Hub rozsyła do wszystkich.','Switch kieruje dane do właściwego portu (MAC); Hub rozsyła do wszystkich portów','Switch jest wolniejszy, Hub szybszy','Oba działają identycznie','Switch działa w warstwie IP, Hub w warstwie fizycznej',0,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Co to jest Firewall?','Firewall to zabezpieczenie kontrolujące ruch sieciowy i chroniące przed nieautoryzowanym dostępem.','Protokół szyfrowania połączeń VPN','Serwer zarządzający adresami IP','Urządzenie wzmacniające sygnał Wi-Fi','Zabezpieczenie kontrolujące ruch sieciowy i chroniące przed nieautoryzowanym dostępem',3,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Co to jest Ethernet?','Ethernet to technologia do tworzenia przewodowych połączeń w lokalnych sieciach komputerowych.','Bezprzewodowa technologia sieciowa','Protokół szyfrowania danych w sieci','Technologia przewodowych połączeń w sieciach lokalnych','System zarządzania adresami IP',2,1,'2026-03-15 16:08:10'),
	 ('Sieci komputerowe','Czym jest Wi-Fi?','Wi-Fi to technologia umożliwiająca bezprzewodowe łączenie urządzeń z siecią.','Przewodowa technologia sieciowa standardu LAN','Protokół szyfrowania transmisji bezprzewodowej','System adresowania urządzeń w sieci','Technologia bezprzewodowego łączenia urządzeń z siecią',3,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Co to jest Malware?','Malware (złośliwe oprogramowanie) to zbiorcza nazwa programów do atakowania systemów i kradzieży danych.','Legalne oprogramowanie antywirusowe','Zbiorcza nazwa złośliwych programów do atakowania systemów i kradzieży danych','Protokół zabezpieczeń sieciowych','System kopii zapasowych',1,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Czym charakteryzują się wirusy komputerowe?','Wirusy dołączają się do plików i aktywują się po uruchomieniu, wymagają interakcji użytkownika.','Replikują się automatycznie przez sieć bez interakcji użytkownika','Szyfrują pliki i żądają okupu','Dołączają się do plików i aktywują po uruchomieniu – wymagają interakcji użytkownika','Służą do wyświetlania reklam',2,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Bezpieczeństwo IT','Jak robaki (Worms) różnią się od wirusów?','Robaki replikują się automatycznie przez sieć bez interakcji użytkownika, bez dołączania do plików.','Robaki i wirusy to to samo','Robaki replikują się automatycznie przez sieć bez interakcji użytkownika','Robaki tylko szyfrują pliki','Robaki wymagają uruchomienia pliku przez użytkownika',1,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Co to jest Trojan (Trojan Horse)?','Trojan to oprogramowanie udające przydatną aplikację, które kradnie dane lub pozwala na zdalne przejęcie kontroli.','Wirus replikujący się przez e-mail','Program wyświetlający reklamy','Oprogramowanie szyfrujące pliki i żądające okupu','Oprogramowanie udające przydatną aplikację umożliwiające zdalne przejęcie kontroli',3,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Co to jest Ransomware?','Ransomware blokuje dostęp do plików lub systemu i żąda okupu za ich odblokowanie.','Oprogramowanie szpiegujące aktywność użytkownika','Wirus sieciowy replikujący się automatycznie','Program wyświetlający niechciane reklamy','Złośliwe oprogramowanie blokujące pliki i żądające okupu',3,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Do czego służy Spyware?','Spyware szpieguje aktywność użytkownika bez jego wiedzy, zbierając dane osobiste i informacje logowania.','Blokuje dostęp do systemu i żąda okupu','Replikuje się przez sieć atakując serwery','Wyświetla niechciane reklamy w przeglądarce','Szpieguje aktywność użytkownika i zbiera dane osobiste bez jego wiedzy',3,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Co to jest Rootkit?','Rootkit to trudne do wykrycia oprogramowanie maskujące swoją obecność, dające atakującemu pełną kontrolę.','Narzędzie do monitorowania ruchu sieciowego','Protokół szyfrowania dysku twardego','Oprogramowanie maskujące się w systemie i dające atakującemu pełną kontrolę','Program antywirusowy do usuwania wirusów',2,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Co to jest Keylogger?','Keylogger to program monitorujący i zapisujący naciśnięcia klawiszy, służy do kradzieży haseł.','Oprogramowanie optymalizujące klawiaturę','Program zapisujący naciśnięcia klawiszy w celu kradzieży haseł i danych','Sterownik do obsługi klawiatury bezprzewodowej','Narzędzie do makr klawiszowych',1,1,'2026-03-15 16:08:10'),
	 ('Bezpieczeństwo IT','Czym Adware różni się od zwykłego Malware?','Adware wyświetla reklamy i może prowadzić do dalszych infekcji; nie kradnie bezpośrednio danych.','Adware i Malware to synonimy','Adware jest bezpieczne i nie stanowi zagrożenia','Adware działa tylko na serwerach','Adware wyświetla reklamy i może prowadzić do dalszych infekcji; nie kradnie bezpośrednio danych',3,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Czym jest algorytm?','Algorytm to skończony, jednoznaczny ciąg kroków prowadzących do rozwiązania problemu.','Program napisany w dowolnym języku programowania','Skończony, jednoznaczny ciąg kroków prowadzących do rozwiązania problemu','Dowolna procedura matematyczna','Schemat blokowy zapisany w pamięci komputera',1,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Jak działa sortowanie przez wstawianie (insertion sort)?','Insertion sort buduje posortowaną tablicę element po elemencie, wstawiając każdy nowy element na właściwe miejsce.','Dzieli tablicę na pół i sortuje każdą połowę osobno','Wybiera zawsze najmniejszy element i zamienia z pierwszym niesortowanym','Buduje posortowaną tablicę element po elemencie, wstawiając każdy na właściwe miejsce','Używa kolejki priorytetowej do kolejkowania elementów',2,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Co to jest rekurencja?','Rekurencja to technika, w której funkcja wywołuje samą siebie z uproszczonym problemem, aż do osiągnięcia przypadku bazowego.','Pętla iteracyjna wykonująca ten sam kod wielokrotnie','Technika, w której funkcja wywołuje samą siebie z uproszczonym problemem','Metoda optymalizacji algorytmów sortowania','Rodzaj struktury danych w języku C++',1,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Algorytmy','Czym różni się BFS od DFS w grafach?','BFS (przeszukiwanie wszerz) używa kolejki i przegląda warstwami. DFS (wgłąb) używa stosu i idzie jak najgłębiej.','BFS i DFS zawsze dają te same wyniki','BFS działa tylko na grafach skierowanych, DFS tylko na nieskierowanych','BFS zawsze jest szybszy od DFS','BFS używa kolejki i przegląda warstwami; DFS używa stosu i idzie jak najgłębiej',3,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Do czego służy algorytm wyszukiwania binarnego?','Wyszukiwanie binarne w O(log n) znajduje element w POSORTOWANEJ tablicy, dzieląc zakres wyszukiwania na pół.','Do sortowania tablicy w czasie O(n log n)','Do wyszukiwania wzorca w tekście','Do szybkiego wyszukiwania w posortowanej tablicy w czasie O(log n)','Do znajdowania najkrótszej ścieżki w grafie',2,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Jaka jest zasada działania algorytmu Euklidesa?','Algorytm Euklidesa oblicza NWD(a,b): jeśli b=0 zwraca a, w przeciwnym razie zwraca NWD(b, a mod b).','Oblicza silnię liczby metodą rekurencyjną','Wyznacza liczby pierwsze metodą sita','Oblicza NWD(a,b): jeśli b=0 zwróć a, inaczej NWD(b, a mod b)','Sortuje liczby całkowite od najmniejszej do największej',2,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Co to jest programowanie dynamiczne?','Programowanie dynamiczne rozwiązuje problem rozkładając go na podproblemy i zapamiętując (memoizacja) wyniki.','Technika pisania kodu bez użycia pętli','Metoda dynamicznego przydzielania pamięci w trakcie działania programu','Algorytm do sortowania dużych zbiorów danych','Technika rozkładania problemu na podproblemy i zapamiętywania wyników (memoizacja)',3,1,'2026-03-15 16:08:10'),
	 ('Algorytmy','Czym jest algorytm zachłanny (greedy)?','Algorytm zachłanny w każdym kroku wybiera lokalnie optymalną decyzję, licząc że prowadzi do globalnego optimum.','Algorytm przeszukujący wszystkie możliwe rozwiązania metodą brute force','Algorytm zawsze dający optymalne rozwiązanie dla dowolnego problemu','W każdym kroku wybiera lokalnie optymalną decyzję licząc na globalne optimum','Technika podziału problemu na dwie równe części',2,1,'2026-03-15 16:08:10'),
	 ('Złożoność obliczeniowa','Co oznacza notacja O(n)?','O(n) to złożoność liniowa – czas wykonania rośnie proporcjonalnie do rozmiaru danych wejściowych.','Czas wykonania jest stały i niezależny od danych','Czas wykonania rośnie kwadratowo wraz z rozmiarem danych','Czas wykonania rośnie proporcjonalnie do rozmiaru danych (złożoność liniowa)','Czas wykonania rośnie logarytmicznie',2,1,'2026-03-15 16:08:10'),
	 ('Złożoność obliczeniowa','Jaka jest złożoność czasowa sortowania bąbelkowego (bubble sort)?','Bubble sort ma złożoność O(n²) w przypadku średnim i pesymistycznym.','O(n log n) w każdym przypadku','O(n) dla posortowanej tablicy, O(n²) dla odwrotnie posortowanej','O(n²) w przypadku średnim i pesymistycznym','O(log n) dla tablicy posortowanej',2,1,'2026-03-15 16:08:10'),
	 ('Złożoność obliczeniowa','Jaka jest złożoność algorytmu merge sort?','Merge sort ma złożoność O(n log n) w każdym przypadku – pesymistycznym, średnim i optymistycznym.','O(n²) w pesymistycznym przypadku','O(n) dla posortowanej tablicy','O(n log n) w każdym przypadku – pesymistycznym, średnim i optymistycznym','O(log n) dla małych tablic',2,1,'2026-03-15 16:08:10'),
	 ('Złożoność obliczeniowa','Co oznacza złożoność O(1)?','O(1) to złożoność stała – czas wykonania jest niezależny od rozmiaru danych wejściowych.','Czas wykonania rośnie z każdym elementem','Algorytm działa tylko dla jednego elementu','Złożoność stała – czas niezależny od rozmiaru danych','Czas wykonania równy liczbie elementów podzielonej przez 2',2,1,'2026-03-15 16:08:10'),
	 ('Złożoność obliczeniowa','Dlaczego binary search ma złożoność O(log n)?','Binary search dzieli zakres wyszukiwania na pół w każdym kroku, więc potrzeba co najwyżej log₂(n) kroków.','Bo zawsze przeszukuje połowę tablicy niezależnie od danych','Bo implementacja używa rekurencji ogonowej','Bo działa tylko dla n będącego potęgą 2','Bo dzieli zakres wyszukiwania na pół w każdym kroku – potrzeba log₂(n) kroków',3,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Złożoność obliczeniowa','Jaka jest złożoność dostępu do elementu tablicy po indeksie?','Dostęp po indeksie to O(1) – komputer bezpośrednio oblicza adres w pamięci.','O(n) – trzeba przejść wszystkie elementy','O(log n) – używa wyszukiwania binarnego','O(1) – bezpośredni dostęp przez adres pamięci','O(n²) – zależy od rozmiaru tablicy kwadratowo',2,1,'2026-03-15 16:08:10'),
	 ('Złożoność obliczeniowa','Co to jest złożoność pamięciowa algorytmu?','Złożoność pamięciowa opisuje ile dodatkowej pamięci algorytm potrzebuje w zależności od rozmiaru danych.','Liczba bitów potrzebnych do zapisania programu na dysku','Czas potrzebny do przydzielenia pamięci przez system operacyjny','Rozmiar danych wejściowych w bajtach','Ilość dodatkowej pamięci potrzebnej algorytmowi w zależności od rozmiaru danych',3,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Ile wynosi 1010₂ w systemie dziesiętnym?','1010₂ = 1×8 + 0×4 + 1×2 + 0×1 = 8 + 2 = 10₁₀','8','12','10','6',2,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Ile wynosi 255₁₀ w systemie szesnastkowym?','255₁₀ = 15×16 + 15 = FF₁₆','FE','FF','EF','100',1,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Ile cyfr używa system ósemkowy (oktalny)?','System ósemkowy używa cyfr 0–7 (osiem cyfr: 0, 1, 2, 3, 4, 5, 6, 7).','6 cyfr: 0–5','10 cyfr: 0–9','16 cyfr: 0–9 i A–F','8 cyfr: 0–7',3,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Jak przelicza się liczbę binarną na dziesiętną?','Mnożymy każdą cyfrę przez odpowiednią potęgę 2 (od prawej: 2⁰, 2¹, 2², ...) i sumujemy.','Dzielimy liczbę przez 2 wielokrotnie i czytamy reszty od dołu','Mnożymy każdą cyfrę przez odpowiednią potęgę 2 i sumujemy','Zamieniamy każde 4 bity na jedną cyfrę szesnastkową','Odczytujemy cyfrę po cyfrze i sumujemy',1,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Co to jest bit i co to jest bajt?','Bit to najmniejsza jednostka informacji (0 lub 1). Bajt = 8 bitów.','Bit to 8 cyfr binarnych; bajt to 1 cyfra binarna','Bit i bajt to to samo','Bit to 4 cyfry binarne; bajt to 2 bity','Bit to 0 lub 1 (najmniejsza jednostka); bajt = 8 bitów',3,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Ile wynosi A3₁₆ w systemie dziesiętnym?','A3₁₆ = 10×16 + 3 = 160 + 3 = 163₁₀','173','163','143','153',1,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Jak zapisujemy liczbę 13₁₀ w systemie binarnym?','13 = 8+4+1 = 1101₂','1110','1010','1100','1101',3,1,'2026-03-15 16:08:10'),
	 ('Systemy liczbowe','Do czego służy system szesnastkowy (hex) w informatyce?','Hex jest zwięzłą reprezentacją danych binarnych – 1 cyfra hex = 4 bity. Używany m.in. do adresów pamięci i kolorów.','Do zapisywania dużych liczb dziesiętnych w mniejszej liczbie cyfr','Wyłącznie do zapisu adresów IPv6','Zwięzła reprezentacja danych binarnych: 1 cyfra hex = 4 bity; kolory, adresy pamięci','Do obliczeń zmiennoprzecinkowych w procesorze',2,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Bazy danych','Czym różni się DELETE od DROP?','DELETE usuwa wiersze (tabela istnieje). DROP TABLE usuwa całą tabelę.','DELETE usuwa tabelę; DROP usuwa wiersze','Są synonimami','DELETE działa na kolumnach','DELETE usuwa wiersze; DROP usuwa całą tabelę',3,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Czym jest PRIMARY KEY?','PRIMARY KEY jednoznacznie identyfikuje rekord w tabeli – musi być unikalny i NOT NULL.','FK do innej tabeli','Indeks przyspieszający wyszukiwanie','Unikalny identyfikator rekordu (NOT NULL)','Pierwsza kolumna tabeli',2,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Różnica między WHERE a HAVING?','WHERE filtruje wiersze PRZED GROUP BY. HAVING filtruje grupy PO GROUP BY.','Są synonimami','WHERE przed GROUP BY; HAVING po GROUP BY','HAVING szybsze od WHERE','WHERE na kolumnach; HAVING na wierszach',1,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Co to jest indeks w bazie danych?','Indeks to struktura danych przyspieszająca wyszukiwanie rekordów (jak spis treści).','Unikalny ID wiersza','Kopia zapasowa tabeli','Ograniczenie NOT NULL','Struktura przyspieszająca wyszukiwanie',3,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Co to jest klucz obcy (FOREIGN KEY)?','FOREIGN KEY to kolumna wskazująca na PRIMARY KEY w innej tabeli, zapewniając integralność relacyjną.','Kolumna wskazująca na PRIMARY KEY w innej tabeli – zapewnia integralność relacyjną','Kolumna, której wartości nie mogą się powtarzać','Automatycznie generowany identyfikator rekordu','Indeks przyspieszający wyszukiwanie',0,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Co to jest transakcja w bazie danych?','Transakcja to jednostka pracy w DB, która albo w całości się udaje (COMMIT) albo jest cofana (ROLLBACK).','Jednorazowe zapytanie SELECT do bazy danych','Przeniesienie danych między tabelami','Kopia zapasowa wybranej tabeli','Jednostka pracy albo w całości udana (COMMIT) albo cofnięta (ROLLBACK)',3,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Co to jest JOIN w SQL?','JOIN łączy wiersze z dwóch lub więcej tabel na podstawie powiązanej kolumny.','Polecenie sortujące wyniki zapytania','Łączy wiersze z dwóch lub więcej tabel na podstawie powiązanej kolumny','Grupuje wiersze o identycznych wartościach','Usuwa duplikaty z wyników zapytania',1,1,'2026-03-15 16:08:10'),
	 ('Bazy danych','Co robi polecenie GROUP BY?','GROUP BY grupuje wiersze z identyczną wartością w kolumnie do jednego wiersza podsumowania.','Sortuje wyniki według podanej kolumny','Grupuje wiersze o tej samej wartości w kolumnie do jednego podsumowania','Filtruje wyniki po warunku logicznym','Łączy dwie tabele w jedną',1,1,'2026-03-15 16:08:10'),
	 ('Architektura komputera','Różnica RAM vs ROM?','RAM – ulotna, odczyt/zapis, traci dane po wyłączeniu. ROM – nieulotna, tylko odczyt, firmware/BIOS.','RAM nieulotna; ROM ulotna','RAM = BIOS; ROM = pamięć robocza','Oba to cache procesora','RAM ulotna RW; ROM nieulotna odczyt',3,1,'2026-03-15 16:08:10'),
	 ('Architektura komputera','Co to jest ALU?','ALU (Arithmetic Logic Unit) – wykonuje operacje arytmetyczne (+,-,*,/) i logiczne (AND, OR, NOT, XOR).','Układ zarządzający cache','Jednostka arytmetyczno-logiczna procesora','Kontroler magistrali','Dekoder instrukcji',1,1,'2026-03-15 16:08:10');
INSERT INTO matura_db.quiz_questions (category,question,answer_full,opt_a,opt_b,opt_c,opt_d,correct,is_active,created_at) VALUES
	 ('Architektura komputera','Co to jest cache procesora?','Cache procesora to szybka pamięć podręczna (L1/L2/L3), która przechowuje często używane dane.','Szybka pamięć podręczna (L1/L2/L3)','Pamięć wirtualna na dysku','Bufor I/O','Pamięć BIOS',0,1,'2026-03-15 16:08:10'),
	 ('Architektura komputera','Co to jest procesor wielordzeniowy?','Procesor wielordzeniowy zawiera dwa lub więcej niezależnych rdzeni obliczeniowych, co umożliwia równoległe przetwarzanie.','Procesor z bardzo dużą pamięcią cache','Procesor obsługujący wyłącznie wirtualizację','Jeden rdzeń obliczeniowy taktowany z dużą częstotliwością','Procesor z wieloma niezależnymi rdzeniami obliczeniowymi do równoległego przetwarzania',3,1,'2026-03-15 16:08:10'),
	 ('Architektura komputera','Co to jest magistrala (bus) w komputerze?','Magistrala to zestaw linii komunikacyjnych przesyłających dane między komponentami komputera.','Pamięć podręczna procesora najwyższego poziomu','Zestaw linii komunikacyjnych przesyłających dane między komponentami','Protokół sieciowy do komunikacji w sieci LAN','Sterownik urządzeń wejścia/wyjścia',1,1,'2026-03-15 16:08:10'),
	 ('Architektura komputera','Co to jest pamięć wirtualna?','Pamięć wirtualna rozszerza dostępną pamięć RAM używając przestrzeni dyskowej (swap/plik stronicowania).','Pamięć zainstalowana na karcie graficznej','Inna nazwa dla pamięci RAM','Rozszerzenie dostępnej pamięci RAM poprzez użycie przestrzeni dyskowej','Pamięć nieulotna przechowująca BIOS',2,1,'2026-03-15 16:08:10'),
	 ('Prawo informatyczne','Co reguluje RODO?','RODO reguluje ochronę danych osobowych osób w UE. Zasady: minimalizacja, zgoda, prawo do bycia zapomnianym.','Handel elektroniczny','Tylko firmy IT w Polsce','Prawa autorskie','Ochrona danych osobowych w UE',3,1,'2026-03-15 16:08:10'),
	 ('Prawo informatyczne','Co to jest licencja open source?','Licencja open source zezwala na używanie, modyfikację i dystrybucję z kodem źródłowym.','Freeware bez kodu','Shareware po 30 dniach','Public domain','Używanie + modyfikacja + dystrybucja z kodem',3,1,'2026-03-15 16:08:10'),
	 ('Prawo informatyczne','Czym jest cyberprzestępstwo?','Cyberprzestępstwo to czyn zabroniony popełniany przy użyciu sieci komputerowych lub Internetu.','Każde przestępstwo zgłoszone przez Internet','Naruszenie praw autorskich wyłącznie w środowisku cyfrowym','Czyn zabroniony popełniany przy użyciu sieci komputerowych lub Internetu','Nieautoryzowany dostęp tylko do systemów rządowych',2,1,'2026-03-15 16:08:10'),
	 ('Prawo informatyczne','Co to jest podpis elektroniczny (e-podpis)?','Podpis elektroniczny to dane elektroniczne umożliwiające identyfikację sygnatariusza i weryfikację integralności dokumentu.','Zeskanowany własnoręczny podpis dołączony do e-maila','System szyfrowania całego dokumentu PDF','Dane elektroniczne umożliwiające identyfikację sygnatariusza i weryfikację integralności dokumentu','Hasło jednorazowe do logowania w banku',2,1,'2026-03-15 16:08:10');
	 
INSERT INTO matura_db.sql_scenarios (name,description,ddl,seed,is_active,created_at) VALUES
	 ('Biblioteka Miejska','System zarządzania wypożyczalnią książek. Zawiera informacje o autorach, książkach, czytelnikach i wypożyczeniach. Pole data_zwrotu = NULL oznacza książkę jeszcze nieoddaną.','CREATE TABLE autorzy(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,kraj TEXT,rok_urodzenia INTEGER);
CREATE TABLE ksiazki(id INTEGER PRIMARY KEY,tytul TEXT,autor_id INTEGER,gatunek TEXT,rok_wydania INTEGER,liczba_stron INTEGER,dostepna INTEGER);
CREATE TABLE czytelnicy(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,miasto TEXT,data_rejestracji TEXT);
CREATE TABLE wypozyczenia(id INTEGER PRIMARY KEY,ksiazka_id INTEGER,czytelnik_id INTEGER,data_wypozyczenia TEXT,data_zwrotu TEXT);','INSERT INTO autorzy VALUES(1,''Adam'',''Mickiewicz'',''Polska'',1798);
INSERT INTO autorzy VALUES(2,''Bolesław'',''Prus'',''Polska'',1847);
INSERT INTO autorzy VALUES(3,''Stanisław'',''Lem'',''Polska'',1921);
INSERT INTO autorzy VALUES(4,''Fyodor'',''Dostoyevsky'',''Rosja'',1821);
INSERT INTO autorzy VALUES(5,''George'',''Orwell'',''Wielka Brytania'',1903);
INSERT INTO autorzy VALUES(6,''Gabriel'',''García Márquez'',''Kolumbia'',1927);
INSERT INTO autorzy VALUES(7,''Olga'',''Tokarczuk'',''Polska'',1962);
INSERT INTO autorzy VALUES(8,''Franz'',''Kafka'',''Czechy'',1883);
INSERT INTO ksiazki VALUES(1,''Pan Tadeusz'',1,''epika'',1834,312,1);
INSERT INTO ksiazki VALUES(2,''Lalka'',2,''powieść'',1890,746,0);
INSERT INTO ksiazki VALUES(3,''Faraon'',2,''powieść historyczna'',1895,632,1);
INSERT INTO ksiazki VALUES(4,''Solaris'',3,''science fiction'',1961,204,1);
INSERT INTO ksiazki VALUES(5,''Cyberiada'',3,''science fiction'',1965,318,0);
INSERT INTO ksiazki VALUES(6,''Zbrodnia i kara'',4,''powieść'',1866,574,1);
INSERT INTO ksiazki VALUES(7,''Idiota'',4,''powieść'',1869,671,0);
INSERT INTO ksiazki VALUES(8,''Rok 1984'',5,''dystopia'',1949,328,1);
INSERT INTO ksiazki VALUES(9,''Folwark zwierzęcy'',5,''dystopia'',1945,112,1);
INSERT INTO ksiazki VALUES(10,''Sto lat samotności'',6,''realizm magiczny'',1967,458,0);
INSERT INTO ksiazki VALUES(11,''Bieguni'',7,''powieść'',2007,402,1);
INSERT INTO ksiazki VALUES(12,''Księgi Jakubowe'',7,''powieść historyczna'',2014,912,0);
INSERT INTO ksiazki VALUES(13,''Proces'',8,''powieść'',1925,198,1);
INSERT INTO ksiazki VALUES(14,''Zamek'',8,''powieść'',1926,312,1);
INSERT INTO ksiazki VALUES(15,''Dziady cz. II'',1,''dramat'',1823,88,1);
INSERT INTO czytelnicy VALUES(1,''Marta'',''Kowalska'',''Warszawa'',''2020-03-15'');
INSERT INTO czytelnicy VALUES(2,''Piotr'',''Nowak'',''Kraków'',''2019-11-02'');
INSERT INTO czytelnicy VALUES(3,''Anna'',''Wiśniewska'',''Warszawa'',''2021-06-20'');
INSERT INTO czytelnicy VALUES(4,''Tomasz'',''Zając'',''Gdańsk'',''2020-01-10'');
INSERT INTO czytelnicy VALUES(5,''Karolina'',''Lewandowska'',''Kraków'',''2022-09-05'');
INSERT INTO czytelnicy VALUES(6,''Marek'',''Wójcik'',''Wrocław'',''2019-04-18'');
INSERT INTO czytelnicy VALUES(7,''Ewa'',''Kamińska'',''Gdańsk'',''2023-02-28'');
INSERT INTO czytelnicy VALUES(8,''Jakub'',''Mazur'',''Poznań'',''2021-07-14'');
INSERT INTO czytelnicy VALUES(9,''Zofia'',''Dąbrowska'',''Łódź'',''2020-08-30'');
INSERT INTO czytelnicy VALUES(10,''Robert'',''Kaczmarek'',''Poznań'',''2022-12-01'');
INSERT INTO wypozyczenia VALUES(1,2,1,''2023-01-10'',''2023-02-05'');
INSERT INTO wypozyczenia VALUES(2,4,1,''2023-03-01'',''2023-03-20'');
INSERT INTO wypozyczenia VALUES(3,8,1,''2023-05-15'',''2023-06-10'');
INSERT INTO wypozyczenia VALUES(4,10,1,''2023-07-01'',NULL);
INSERT INTO wypozyczenia VALUES(5,1,2,''2023-02-14'',''2023-03-01'');
INSERT INTO wypozyczenia VALUES(6,6,2,''2023-04-10'',''2023-05-30'');
INSERT INTO wypozyczenia VALUES(7,7,2,''2023-08-01'',NULL);
INSERT INTO wypozyczenia VALUES(8,4,3,''2022-11-05'',''2022-11-25'');
INSERT INTO wypozyczenia VALUES(9,5,3,''2023-01-20'',''2023-02-15'');
INSERT INTO wypozyczenia VALUES(10,12,3,''2023-09-10'',NULL);
INSERT INTO wypozyczenia VALUES(11,2,3,''2023-10-01'',NULL);
INSERT INTO wypozyczenia VALUES(12,8,4,''2022-06-01'',''2022-07-15'');
INSERT INTO wypozyczenia VALUES(13,9,4,''2023-03-05'',''2023-03-25'');
INSERT INTO wypozyczenia VALUES(14,13,5,''2023-05-01'',''2023-05-20'');
INSERT INTO wypozyczenia VALUES(15,4,5,''2022-12-10'',''2023-01-10'');
INSERT INTO wypozyczenia VALUES(16,8,6,''2021-09-01'',''2021-10-20'');
INSERT INTO wypozyczenia VALUES(17,11,6,''2022-03-15'',''2022-04-30'');
INSERT INTO wypozyczenia VALUES(18,14,6,''2023-06-01'',NULL);
INSERT INTO wypozyczenia VALUES(19,3,7,''2023-07-10'',''2023-08-05'');
INSERT INTO wypozyczenia VALUES(20,6,8,''2023-02-01'',''2023-03-10'');
INSERT INTO wypozyczenia VALUES(21,10,8,''2023-08-15'',NULL);
INSERT INTO wypozyczenia VALUES(22,4,8,''2022-05-01'',''2022-06-20'');
INSERT INTO wypozyczenia VALUES(23,9,9,''2023-01-05'',''2023-01-28'');
INSERT INTO wypozyczenia VALUES(24,11,9,''2023-04-20'',''2023-05-15'');
INSERT INTO wypozyczenia VALUES(25,2,9,''2022-09-01'',''2022-10-15'');
INSERT INTO wypozyczenia VALUES(26,5,10,''2023-03-20'',NULL);
INSERT INTO wypozyczenia VALUES(27,7,10,''2023-08-01'',NULL);
INSERT INTO wypozyczenia VALUES(28,13,10,''2023-09-15'',NULL);
INSERT INTO wypozyczenia VALUES(29,4,1,''2021-06-10'',''2021-07-20'');
INSERT INTO wypozyczenia VALUES(30,8,5,''2023-10-05'',NULL);',1,'2026-03-14 20:19:28'),
	 ('Sklep Internetowy','System e-commerce. Zawiera produkty podzielone na kategorie, klientów oraz zamówienia składające się z wielu pozycji. Pole data_realizacji = NULL oznacza zamówienie niezrealizowane.','CREATE TABLE kategorie(id INTEGER PRIMARY KEY,nazwa TEXT,opis TEXT);
CREATE TABLE produkty(id INTEGER PRIMARY KEY,nazwa TEXT,kategoria_id INTEGER,cena REAL,stan_magazynu INTEGER,aktywny INTEGER);
CREATE TABLE klienci(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,email TEXT,miasto TEXT,data_rejestracji TEXT);
CREATE TABLE zamowienia(id INTEGER PRIMARY KEY,klient_id INTEGER,data_zamowienia TEXT,data_realizacji TEXT,status TEXT);
CREATE TABLE pozycje_zamowien(id INTEGER PRIMARY KEY,zamowienie_id INTEGER,produkt_id INTEGER,ilosc INTEGER,cena_jednostkowa REAL);','INSERT INTO kategorie VALUES(1,''Elektronika'',''Sprzęt elektroniczny i akcesoria'');
INSERT INTO kategorie VALUES(2,''Książki'',''Literatura i podręczniki'');
INSERT INTO kategorie VALUES(3,''Sport'',''Sprzęt i odzież sportowa'');
INSERT INTO kategorie VALUES(4,''AGD'',''Sprzęt gospodarstwa domowego'');
INSERT INTO produkty VALUES(1,''Laptop ProBook'',1,2999.99,15,1);
INSERT INTO produkty VALUES(2,''Słuchawki BT'',1,249.00,42,1);
INSERT INTO produkty VALUES(3,''Klawiatura mechaniczna'',1,389.00,28,1);
INSERT INTO produkty VALUES(4,''Pan Tadeusz'',2,29.99,100,1);
INSERT INTO produkty VALUES(5,''Algorytmy w C++'',2,89.99,35,1);
INSERT INTO produkty VALUES(6,''Atlas geograficzny'',2,59.99,20,0);
INSERT INTO produkty VALUES(7,''Buty biegowe'',3,299.00,50,1);
INSERT INTO produkty VALUES(8,''Mata do jogi'',3,79.99,60,1);
INSERT INTO produkty VALUES(9,''Kask rowerowy'',3,149.99,25,1);
INSERT INTO produkty VALUES(10,''Ekspres do kawy'',4,699.00,12,1);
INSERT INTO produkty VALUES(11,''Blender'',4,199.99,30,1);
INSERT INTO produkty VALUES(12,''Żelazko parowe'',4,149.00,18,1);
INSERT INTO klienci VALUES(1,''Marta'',''Kowalska'',''marta@email.pl'',''Warszawa'',''2021-03-10'');
INSERT INTO klienci VALUES(2,''Piotr'',''Nowak'',''piotr@email.pl'',''Kraków'',''2020-08-22'');
INSERT INTO klienci VALUES(3,''Anna'',''Wiśniewska'',''anna@email.pl'',''Gdańsk'',''2022-01-15'');
INSERT INTO klienci VALUES(4,''Tomasz'',''Zając'',''tomasz@email.pl'',''Warszawa'',''2021-11-05'');
INSERT INTO klienci VALUES(5,''Karolina'',''Lewandowska'',''karo@email.pl'',''Wrocław'',''2023-04-20'');
INSERT INTO klienci VALUES(6,''Marek'',''Wójcik'',''marek@email.pl'',''Kraków'',''2020-06-30'');
INSERT INTO klienci VALUES(7,''Ewa'',''Kamińska'',''ewa@email.pl'',''Poznań'',''2022-09-12'');
INSERT INTO zamowienia VALUES(1,1,''2023-01-15'',''2023-01-18'',''zrealizowane'');
INSERT INTO zamowienia VALUES(2,1,''2023-05-10'',''2023-05-13'',''zrealizowane'');
INSERT INTO zamowienia VALUES(3,2,''2023-02-20'',''2023-02-23'',''zrealizowane'');
INSERT INTO zamowienia VALUES(4,2,''2023-09-05'',NULL,''w realizacji'');
INSERT INTO zamowienia VALUES(5,3,''2023-03-12'',''2023-03-15'',''zrealizowane'');
INSERT INTO zamowienia VALUES(6,4,''2023-06-01'',''2023-06-04'',''zrealizowane'');
INSERT INTO zamowienia VALUES(7,4,''2023-10-20'',NULL,''w realizacji'');
INSERT INTO zamowienia VALUES(8,5,''2023-07-08'',''2023-07-12'',''zrealizowane'');
INSERT INTO zamowienia VALUES(9,6,''2023-04-25'',''2023-04-28'',''zrealizowane'');
INSERT INTO zamowienia VALUES(10,6,''2023-08-14'',''2023-08-17'',''zrealizowane'');
INSERT INTO zamowienia VALUES(11,7,''2023-11-02'',NULL,''w realizacji'');
INSERT INTO pozycje_zamowien VALUES(1,1,1,1,2999.99);
INSERT INTO pozycje_zamowien VALUES(2,1,2,2,249.00);
INSERT INTO pozycje_zamowien VALUES(3,2,3,1,389.00);
INSERT INTO pozycje_zamowien VALUES(4,2,8,1,79.99);
INSERT INTO pozycje_zamowien VALUES(5,3,5,2,89.99);
INSERT INTO pozycje_zamowien VALUES(6,3,4,3,29.99);
INSERT INTO pozycje_zamowien VALUES(7,4,10,1,699.00);
INSERT INTO pozycje_zamowien VALUES(8,4,11,1,199.99);
INSERT INTO pozycje_zamowien VALUES(9,5,7,1,299.00);
INSERT INTO pozycje_zamowien VALUES(10,5,9,1,149.99);
INSERT INTO pozycje_zamowien VALUES(11,6,2,1,249.00);
INSERT INTO pozycje_zamowien VALUES(12,6,3,2,389.00);
INSERT INTO pozycje_zamowien VALUES(13,7,1,1,2999.99);
INSERT INTO pozycje_zamowien VALUES(14,8,8,2,79.99);
INSERT INTO pozycje_zamowien VALUES(15,8,12,1,149.00);
INSERT INTO pozycje_zamowien VALUES(16,9,4,5,29.99);
INSERT INTO pozycje_zamowien VALUES(17,9,5,1,89.99);
INSERT INTO pozycje_zamowien VALUES(18,10,10,1,699.00);
INSERT INTO pozycje_zamowien VALUES(19,10,2,3,249.00);
INSERT INTO pozycje_zamowien VALUES(20,11,7,2,299.00);
INSERT INTO pozycje_zamowien VALUES(21,11,3,1,389.00);',1,'2026-03-14 20:19:28'),
	 ('Turniej Szachowy','Baza danych federacji szachowej. Zawiera zawodników z rankingiem ELO, turnieje, rozegrane mecze i ich wyniki. Wynik meczu: W=wygrana białymi, B=wygrana czarnymi, R=remis.','CREATE TABLE zawodnicy(id INTEGER PRIMARY KEY,imie TEXT,nazwisko TEXT,kraj TEXT,ranking_elo INTEGER,rok_urodzenia INTEGER);
CREATE TABLE turnieje(id INTEGER PRIMARY KEY,nazwa TEXT,miasto TEXT,rok INTEGER,liczba_rund INTEGER,typ TEXT);
CREATE TABLE mecze(id INTEGER PRIMARY KEY,turniej_id INTEGER,runda INTEGER,bialy_id INTEGER,czarny_id INTEGER,wynik TEXT,data_meczu TEXT);','INSERT INTO zawodnicy VALUES(1,''Magnus'',''Carlsen'',''Norwegia'',2830,1990);
INSERT INTO zawodnicy VALUES(2,''Fabiano'',''Caruana'',''USA'',2804,1992);
INSERT INTO zawodnicy VALUES(3,''Ding'',''Liren'',''Chiny'',2788,1992);
INSERT INTO zawodnicy VALUES(4,''Ian'',''Nepomniachtchi'',''Rosja'',2771,1990);
INSERT INTO zawodnicy VALUES(5,''Anish'',''Giri'',''Holandia'',2745,1994);
INSERT INTO zawodnicy VALUES(6,''Levon'',''Aronian'',''Armenia'',2735,1982);
INSERT INTO zawodnicy VALUES(7,''Jan-Krzysztof'',''Duda'',''Polska'',2724,1998);
INSERT INTO zawodnicy VALUES(8,''Radosław'',''Wojtaszek'',''Polska'',2698,1987);
INSERT INTO zawodnicy VALUES(9,''Alireza'',''Firouzja'',''Francja'',2760,2003);
INSERT INTO zawodnicy VALUES(10,''Hikaru'',''Nakamura'',''USA'',2768,1987);
INSERT INTO turnieje VALUES(1,''Grand Chess Tour Warszawa'',''Warszawa'',2023,9,''round-robin'');
INSERT INTO turnieje VALUES(2,''Puchar Polski Open'',''Kraków'',2023,7,''swiss'');
INSERT INTO turnieje VALUES(3,''Memorial Rubinsteina'',''Polanica-Zdrój'',2022,9,''round-robin'');
INSERT INTO turnieje VALUES(4,''Błyskawica Gdańsk'',''Gdańsk'',2023,5,''swiss'');
INSERT INTO mecze VALUES(1,1,1,1,2,''W'',''2023-06-10'');
INSERT INTO mecze VALUES(2,1,1,3,4,''R'',''2023-06-10'');
INSERT INTO mecze VALUES(3,1,1,5,6,''B'',''2023-06-10'');
INSERT INTO mecze VALUES(4,1,2,2,3,''R'',''2023-06-11'');
INSERT INTO mecze VALUES(5,1,2,4,5,''W'',''2023-06-11'');
INSERT INTO mecze VALUES(6,1,2,7,8,''W'',''2023-06-11'');
INSERT INTO mecze VALUES(7,1,3,1,3,''W'',''2023-06-12'');
INSERT INTO mecze VALUES(8,1,3,9,10,''R'',''2023-06-12'');
INSERT INTO mecze VALUES(9,1,4,2,4,''B'',''2023-06-13'');
INSERT INTO mecze VALUES(10,1,4,1,5,''W'',''2023-06-13'');
INSERT INTO mecze VALUES(11,1,5,6,7,''R'',''2023-06-14'');
INSERT INTO mecze VALUES(12,1,5,3,9,''B'',''2023-06-14'');
INSERT INTO mecze VALUES(13,2,1,7,2,''R'',''2023-09-01'');
INSERT INTO mecze VALUES(14,2,1,8,5,''W'',''2023-09-01'');
INSERT INTO mecze VALUES(15,2,2,10,7,''B'',''2023-09-02'');
INSERT INTO mecze VALUES(16,2,2,2,8,''W'',''2023-09-02'');
INSERT INTO mecze VALUES(17,2,3,7,5,''W'',''2023-09-03'');
INSERT INTO mecze VALUES(18,2,4,8,10,''R'',''2023-09-04'');
INSERT INTO mecze VALUES(19,2,4,7,1,''R'',''2023-09-04'');
INSERT INTO mecze VALUES(20,3,1,1,4,''W'',''2022-08-05'');
INSERT INTO mecze VALUES(21,3,1,7,6,''W'',''2022-08-05'');
INSERT INTO mecze VALUES(22,3,2,5,1,''R'',''2022-08-06'');
INSERT INTO mecze VALUES(23,3,3,1,6,''W'',''2022-08-07'');
INSERT INTO mecze VALUES(24,3,4,7,4,''W'',''2022-08-08'');
INSERT INTO mecze VALUES(25,4,1,7,9,''W'',''2023-11-10'');
INSERT INTO mecze VALUES(26,4,2,10,7,''R'',''2023-11-11'');
INSERT INTO mecze VALUES(27,4,3,7,3,''B'',''2023-11-12'');
INSERT INTO mecze VALUES(28,4,4,1,7,''R'',''2023-11-13'');
INSERT INTO mecze VALUES(29,4,5,7,2,''W'',''2023-11-14'');',1,'2026-03-14 20:19:28');


INSERT INTO matura_db.sql_tasks (scenario_id,title,difficulty,description,hint,solution,is_active,created_at) VALUES
	 (1,'Zadanie 1. (0–2) Najbardziej aktywny czytelnik','hard','Podaj imię i nazwisko czytelnika, który wypożyczył łącznie najwięcej książek (uwzględnij wszystkie wypożyczenia, również te gdzie książka nie została jeszcze zwrócona). Jeśli jest kilku takich czytelników, wypisz wszystkich — posortuj alfabetycznie po nazwisku.','Użyj GROUP BY c.id z COUNT(*), następnie ogranicz wynik do MAX za pomocą podzapytania lub HAVING COUNT(*)=(SELECT MAX(cnt) FROM ...).','SELECT c.imie, c.nazwisko FROM czytelnicy c JOIN wypozyczenia w ON c.id=w.czytelnik_id GROUP BY c.id HAVING COUNT(*)=(SELECT MAX(cnt) FROM (SELECT COUNT(*) as cnt FROM wypozyczenia GROUP BY czytelnik_id) sub) ORDER BY c.nazwisko',1,'2026-03-14 20:19:28'),
	 (1,'Zadanie 2. (0–2) Książki nigdy nie wypożyczone','hard','Podaj tytuły książek, które nie zostały ani razu wypożyczone. Posortuj alfabetycznie po tytule.','Użyj NOT IN z podzapytaniem: WHERE id NOT IN (SELECT DISTINCT ksiazka_id FROM wypozyczenia).','SELECT tytul FROM ksiazki WHERE id NOT IN (SELECT DISTINCT ksiazka_id FROM wypozyczenia) ORDER BY tytul',1,'2026-03-14 20:19:28'),
	 (1,'Zadanie 3. (0–2) Gatunek z największą łączną liczbą stron','hard','Podaj nazwę gatunku, dla którego suma liczby stron wszystkich książek tego gatunku jest największa. Istnieje dokładnie jeden taki gatunek.','GROUP BY gatunek, ORDER BY SUM(liczba_stron) DESC LIMIT 1.','SELECT gatunek FROM ksiazki GROUP BY gatunek ORDER BY SUM(liczba_stron) DESC LIMIT 1',1,'2026-03-14 20:19:28'),
	 (1,'Zadanie 4. (0–2) Czytelnicy przetrzymujący więcej niż 2 książki','hard','Podaj imię i nazwisko czytelników, którzy aktualnie przetrzymują więcej niż 2 nieoddane książki (data_zwrotu IS NULL). Posortuj po nazwisku.','WHERE w.data_zwrotu IS NULL GROUP BY c.id HAVING COUNT(*) > 2.','SELECT c.imie, c.nazwisko FROM czytelnicy c JOIN wypozyczenia w ON c.id=w.czytelnik_id WHERE w.data_zwrotu IS NULL GROUP BY c.id HAVING COUNT(*)>2 ORDER BY c.nazwisko',1,'2026-03-14 20:19:28'),
	 (1,'Zadanie 5. (0–2) Najdłużej przetrzymana książka','hard','Podaj tytuł książki, która była wypożyczona najdłużej (największa liczba dni między data_wypozyczenia a data_zwrotu). Uwzględniaj tylko zakończone wypożyczenia. Istnieje dokładnie jeden taki rekord.','Użyj julianday(data_zwrotu) - julianday(data_wypozyczenia) do obliczenia liczby dni. ORDER BY ... DESC LIMIT 1.','SELECT k.tytul FROM ksiazki k JOIN wypozyczenia w ON k.id=w.ksiazka_id WHERE w.data_zwrotu IS NOT NULL ORDER BY (julianday(w.data_zwrotu)-julianday(w.data_wypozyczenia)) DESC LIMIT 1',1,'2026-03-14 20:19:28'),
	 (1,'Zadanie 6. (0–2) Średni czas wypożyczenia wg gatunku','hard','Dla każdego gatunku oblicz średni czas wypożyczenia w dniach (zaokrąglony do 1 miejsca po przecinku), uwzględniając tylko zakończone wypożyczenia. Posortuj malejąco po średnim czasie.','AVG(julianday(data_zwrotu) - julianday(data_wypozyczenia)), GROUP BY gatunek, ORDER BY srednia DESC.','SELECT k.gatunek, ROUND(AVG(julianday(w.data_zwrotu)-julianday(w.data_wypozyczenia)),1) as srednia FROM ksiazki k JOIN wypozyczenia w ON k.id=w.ksiazka_id WHERE w.data_zwrotu IS NOT NULL GROUP BY k.gatunek ORDER BY srednia DESC',1,'2026-03-14 20:19:28'),
	 (1,'Zadanie 7. (0–2) Czytelnicy którzy wypożyczali każdy gatunek','hard','Podaj imię i nazwisko czytelników, którzy wypożyczyli co najmniej jedną książkę z KAŻDEGO gatunku obecnego w bazie. Posortuj po nazwisku.','GROUP BY c.id HAVING COUNT(DISTINCT k.gatunek) = (SELECT COUNT(DISTINCT gatunek) FROM ksiazki).','SELECT c.imie, c.nazwisko FROM czytelnicy c JOIN wypozyczenia w ON c.id=w.czytelnik_id JOIN ksiazki k ON w.ksiazka_id=k.id GROUP BY c.id HAVING COUNT(DISTINCT k.gatunek)=(SELECT COUNT(DISTINCT gatunek) FROM ksiazki) ORDER BY c.nazwisko',1,'2026-03-14 20:19:28'),
	 (2,'Zadanie 8. (0–2) Produkt o największych łącznych przychodach','hard','Podaj nazwę produktu, który wygenerował największy łączny przychód (suma ilosc * cena_jednostkowa ze wszystkich pozycji zamówień). Istnieje dokładnie jeden taki produkt.','JOIN pozycje_zamowien, GROUP BY produkt_id, SUM(ilosc*cena_jednostkowa), ORDER BY DESC LIMIT 1.','SELECT p.nazwa FROM produkty p JOIN pozycje_zamowien pz ON p.id=pz.produkt_id GROUP BY p.id ORDER BY SUM(pz.ilosc*pz.cena_jednostkowa) DESC LIMIT 1',1,'2026-03-14 20:19:28'),
	 (2,'Zadanie 9. (0–2) Klienci bez żadnego zrealizowanego zamówienia','hard','Podaj imię i nazwisko klientów, którzy nie mają ani jednego zamówienia o statusie ''zrealizowane''. Uwzględnij też klientów bez żadnych zamówień. Posortuj po nazwisku.','NOT IN: WHERE id NOT IN (SELECT klient_id FROM zamowienia WHERE status=''zrealizowane'').','SELECT imie, nazwisko FROM klienci WHERE id NOT IN (SELECT klient_id FROM zamowienia WHERE status=''zrealizowane'') ORDER BY nazwisko',1,'2026-03-14 20:19:28'),
	 (2,'Zadanie 10. (0–2) Kategoria z największą średnią ceną produktów aktywnych','hard','Podaj nazwę kategorii, której aktywne produkty (aktywny = 1) mają największą średnią cenę. Istnieje dokładnie jeden taki wynik.','JOIN kategorie, WHERE aktywny=1, GROUP BY kategoria_id, ORDER BY AVG(cena) DESC LIMIT 1.','SELECT k.nazwa FROM kategorie k JOIN produkty p ON k.id=p.kategoria_id WHERE p.aktywny=1 GROUP BY k.id ORDER BY AVG(p.cena) DESC LIMIT 1',1,'2026-03-14 20:19:28');
INSERT INTO matura_db.sql_tasks (scenario_id,title,difficulty,description,hint,solution,is_active,created_at) VALUES
	 (2,'Zadanie 11. (0–2) Wartość niezrealizowanych zamówień wg klienta','hard','Dla każdego klienta mającego przynajmniej jedno niezrealizowane zamówienie podaj imię, nazwisko i łączną wartość tych zamówień (suma ilosc*cena_jednostkowa). Posortuj malejąco po wartości.','WHERE z.data_realizacji IS NULL, JOIN pozycje_zamowien, GROUP BY klient_id, SUM(ilosc*cena_jednostkowa).','SELECT kl.imie, kl.nazwisko, SUM(pz.ilosc*pz.cena_jednostkowa) as wartosc FROM klienci kl JOIN zamowienia z ON kl.id=z.klient_id JOIN pozycje_zamowien pz ON z.id=pz.zamowienie_id WHERE z.data_realizacji IS NULL GROUP BY kl.id ORDER BY wartosc DESC',1,'2026-03-14 20:19:28'),
	 (2,'Zadanie 12. (0–2) Produkty nigdy nie zamówione','medium','Podaj nazwy produktów, które nie zostały ani razu zamówione (nie ma ich w żadnej pozycji zamówienia). Posortuj alfabetycznie.','WHERE id NOT IN (SELECT DISTINCT produkt_id FROM pozycje_zamowien).','SELECT nazwa FROM produkty WHERE id NOT IN (SELECT DISTINCT produkt_id FROM pozycje_zamowien) ORDER BY nazwa',1,'2026-03-14 20:19:28'),
	 (3,'Zadanie 13. (0–2) Zawodnik z największą liczbą wygranych meczów','hard','Zawodnik wygrywa mecz gdy gra białymi i wynik = ''W'', lub gdy gra czarnymi i wynik = ''B''. Podaj imię, nazwisko i łączną liczbę wygranych meczów zawodnika z największą ich liczbą. Istnieje dokładnie jeden taki zawodnik.','Zlicz wygrane jako biały: WHERE bialy_id=z.id AND wynik=''W'', i jako czarny: WHERE czarny_id=z.id AND wynik=''B''. Sumuj oba przypadki.','SELECT z.imie, z.nazwisko, COUNT(*) as wygrane FROM zawodnicy z JOIN mecze m ON (z.id=m.bialy_id AND m.wynik=''W'') OR (z.id=m.czarny_id AND m.wynik=''B'') GROUP BY z.id ORDER BY wygrane DESC LIMIT 1',1,'2026-03-14 20:19:28'),
	 (3,'Zadanie 14. (0–2) Zawodnicy z Polski w więcej niż 1 turnieju','hard','Podaj imię, nazwisko i liczbę turniejów zawodników z Polski, którzy brali udział (jako biały lub czarny) w więcej niż jednym turnieju. Posortuj po nazwisku.','INNER JOIN mecze (biały lub czarny), COUNT(DISTINCT turniej_id) > 1, WHERE kraj=''Polska''.','SELECT z.imie, z.nazwisko, COUNT(DISTINCT m.turniej_id) as turnieje FROM zawodnicy z JOIN mecze m ON z.id=m.bialy_id OR z.id=m.czarny_id WHERE z.kraj=''Polska'' GROUP BY z.id HAVING COUNT(DISTINCT m.turniej_id)>1 ORDER BY z.nazwisko',1,'2026-03-14 20:19:28'),
	 (3,'Zadanie 15. (0–2) Turniej z największym odsetkiem remisów','hard','Podaj nazwę turnieju, w którym odsetek remisów (mecze z wynikiem ''R'' do wszystkich meczów) był największy. Istnieje dokładnie jeden taki turniej. Wyraź wynik jako wartość dziesiętną zaokrągloną do 2 miejsc.','ROUND(SUM(CASE WHEN wynik=''R'' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2), GROUP BY turniej_id.','SELECT t.nazwa FROM turnieje t JOIN mecze m ON t.id=m.turniej_id GROUP BY t.id ORDER BY ROUND(SUM(CASE WHEN m.wynik=''R'' THEN 1.0 ELSE 0 END)/COUNT(*),2) DESC LIMIT 1',1,'2026-03-14 20:19:28'),
	 (3,'Zadanie 16. (0–2) Zawodnicy którzy nigdy nie remisowali','hard','Podaj imię, nazwisko i kraj zawodników, którzy rozegrali co najmniej jeden mecz, ale nie zremisowali ani razu (żaden mecz z ich udziałem nie ma wyniku ''R''). Posortuj po nazwisku.','Zawodnik grał: (bialy_id=id OR czarny_id=id). Brak remisu: nie istnieje mecz z wynikiem R i udziałem tego zawodnika.','SELECT DISTINCT z.imie, z.nazwisko, z.kraj FROM zawodnicy z WHERE z.id IN (SELECT bialy_id FROM mecze UNION SELECT czarny_id FROM mecze) AND z.id NOT IN (SELECT bialy_id FROM mecze WHERE wynik=''R'' UNION SELECT czarny_id FROM mecze WHERE wynik=''R'') ORDER BY z.nazwisko',1,'2026-03-14 20:19:28'),
	 (3,'Zadanie 17. (0–2) Ranking zawodników w turnieju Grand Chess Tour Warszawa','hard','Dla turnieju „Grand Chess Tour Warszawa" oblicz punktację każdego zawodnika: wygrana = 1 pkt, remis = 0.5 pkt, przegrana = 0 pkt. Podaj imię, nazwisko i punkty, posortuj malejąco po punktach, a przy równej liczbie punktów — alfabetycznie po nazwisku.','SUM(CASE WHEN bialy_id=z.id AND wynik=''W'' THEN 1 WHEN bialy_id=z.id AND wynik=''R'' THEN 0.5 ... END).','SELECT z.imie, z.nazwisko, SUM(CASE WHEN m.bialy_id=z.id AND m.wynik=''W'' THEN 1.0 WHEN m.bialy_id=z.id AND m.wynik=''R'' THEN 0.5 WHEN m.czarny_id=z.id AND m.wynik=''B'' THEN 1.0 WHEN m.czarny_id=z.id AND m.wynik=''R'' THEN 0.5 ELSE 0 END) as pkt FROM zawodnicy z JOIN mecze m ON z.id=m.bialy_id OR z.id=m.czarny_id WHERE m.turniej_id=1 GROUP BY z.id ORDER BY pkt DESC, z.nazwisko',1,'2026-03-14 20:19:28');
	 


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
	 
	 
INSERT INTO matura_db.algo_tasks (id,title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 (1,'Liczba pierwsza','easy','Wczytaj liczbę całkowitą N (0 ≤ N ≤ 10^9). Wypisz TAK jeśli jest pierwsza, NIE w przeciwnym razie.','Sprawdzaj dzielniki tylko do √N. Pętla: for(int i=2; i*i<=n; i++). Pamiętaj: 0 i 1 to nie liczby pierwsze.','17','TAK',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
bool pierwsza(long long n){
    if(n < 2) return false;
    if(n == 2) return true;
    if(n % 2 == 0) return false;
    for(long long i = 3; i * i <= n; i += 2)
        if(n % i == 0) return false;
    return true;
}
int main(){
    long long n; cin >> n;
    cout << (pierwsza(n) ? "TAK" : "NIE") << endl;
    return 0;
}'),
	 (2,'Rozkład na czynniki pierwsze','easy','Wczytaj N (2 ≤ N ≤ 10^6). Wypisz rozkład: p1^e1 * p2^e2 * ... Pomiń "^1" gdy wykładnik = 1.','Dziel N przez kolejne liczby od 2. Licz powtórzenia. Gdy i*i > N i N > 1, N jest ostatnim czynnikiem.','360','2^3 * 3^2 * 5',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    bool first = true;
    for(int i = 2; (long long)i*i <= n; i++){
        int cnt = 0;
        while(n % i == 0){ cnt++; n /= i; }
        if(cnt > 0){
            if(!first) cout << " * ";
            cout << i;
            if(cnt > 1) cout << "^" << cnt;
            first = false;
        }
    }
    if(n > 1){
        if(!first) cout << " * ";
        cout << n;
    }
    cout << endl;
    return 0;
}'),
	 (3,'Wyszukiwanie binarne','medium','Wczytaj n, następnie n posortowanych liczb, potem x. Wypisz indeks (od 0) pierwszego x lub -1.','l=0, r=n-1, mid=(l+r)/2. Porównaj a[mid] z x i zawęż przedział.','7
1 3 5 7 9 11 13
7','3',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int& x : a) cin >> x;
    int k; cin >> k;
    int lo = 0, hi = n-1, pos = -1;
    while(lo <= hi){
        int mid = (lo+hi)/2;
        if(a[mid] == k){ pos = mid; break; }
        else if(a[mid] < k) lo = mid+1;
        else hi = mid-1;
    }
    cout << pos << endl;
    return 0;
}'),
	 (4,'Konwersja dziesiętna → binarna','easy','Wczytaj N (0 ≤ N ≤ 10^9). Wypisz reprezentację binarną bez wiodących zer. Wyjątek: N=0 → "0".','Dziel N przez 2, zbieraj reszty od tyłu. Szczególny przypadek: N=0.','42','101010',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long n; cin >> n;
    if(n == 0){ cout << 0; return 0; }
    string bin = "";
    while(n > 0){ bin = char(''0'' + n%2) + bin; n /= 2; }
    cout << bin << endl;
    return 0;
}'),
	 (5,'Algorytm Euklidesa NWD','easy','Wczytaj A i B (0 ≤ A, B ≤ 10^18). Wypisz NWD(A,B). Przypadek: NWD(0,0) = 0.','nwd(a,b) = nwd(b, a%b), nwd(a,0) = a. Użyj long long!','48 18','6',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long a, b;
    cin >> a >> b;
    while(b != 0){
        long long r = a % b;
        a = b; b = r;
    }
    cout << a << endl;
    return 0;
}'),
	 (6,'Sortowanie przez wstawianie','medium','Wczytaj n, potem n liczb. Posortuj insertion sort rosnąco. Wypisz tablicę, w drugiej linii liczbę przestawień.','Klucz = a[i], cofaj elementy > klucz o jeden w prawo. Każde cofnięcie = +1 do licznika.','5
5 3 1 4 2','1 2 3 4 5
7',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    int shifts = 0;
    for(int i = 1; i < n; i++){
        int key = a[i], j = i-1;
        while(j >= 0 && a[j] > key){
            a[j+1] = a[j];
            j--;
            shifts++;
        }
        a[j+1] = key;
    }
    for(int i = 0; i < n; i++){
        if(i) cout << " ";
        cout << a[i];
    }
    cout << "\n" << shifts << endl;
    return 0;
}'),
	 (7,'Sito Eratostenesa','medium','Wczytaj N (2 ≤ N ≤ 10^6). Wypisz wszystkie liczby pierwsze od 2 do N, każdą w osobnej linii.','Tablica bool is_prime[N+1]. Dla i od 2: jeśli is_prime[i], oznacz wielokrotności i (od i*i) jako false.','20','2
3
5
7
11
13
17
19',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<bool> sito(n+1, true);
    sito[0] = sito[1] = false;
    for(int i = 2; i * i <= n; i++)
        if(sito[i])
            for(int j = i*i; j <= n; j += i)
                sito[j] = false;
    for(int i = 2; i <= n; i++)
        if(sito[i]) cout << i << "
";
    return 0;
}'),
	 (8,'Liczba doskonała','easy','Wczytaj liczbę całkowitą N (1 ≤ N ≤ 10^7). Wypisz TAK jeśli N jest liczbą doskonałą (suma właściwych dzielników = N), NIE w przeciwnym razie.','Sumuj dzielniki d od 1 do N-1 gdzie N%d==0. Optymalizacja: iteruj do √N i dodawaj oba dzielniki, uważaj na d=√N.','6','TAK',1,'2026-03-14 12:19:36','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long n; cin >> n;
    if(n <= 1){ cout << "NIE" << endl; return 0; }
    long long sum = 1;
    for(long long i = 2; i * i <= n; i++){
        if(n % i == 0){
            sum += i;
            if(i != n/i) sum += n/i;
        }
    }
    cout << (sum == n ? "TAK" : "NIE") << endl;
    return 0;
}'),
	 (9,'Konwersja: dziesiętny → hex','easy','Wczytaj liczbę całkowitą N (0 ≤ N ≤ 10^9). Wypisz jej reprezentację szesnastkową WIELKIMI LITERAMI (bez prefiksu 0x). Przypadek: N=0 → "0".','Dziel N przez 16, reszty: 10→A, 11→B, 12→C, 13→D, 14→E, 15→F. Zbieraj od tyłu.','255','FF',1,'2026-03-14 12:19:36','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long n;
    cin >> n;
    if(n == 0){ cout << 0; return 0; }
    string res = "";
    while(n > 0){
        int r = n % 16;
        res = char(r < 10 ? ''0''+r : ''A''+(r-10)) + res;
        n /= 16;
    }
    cout << res << endl;
    return 0;
}'),
	 (10,'Konwersja: dziesiętny → system o podstawie B','medium','Wczytaj dwie liczby: N (0 ≤ N ≤ 10^9) i B (2 ≤ B ≤ 16). Wypisz N w systemie o podstawie B (cyfry >9 jako A-F wielkie litery). N=0 → "0".','Dziel N przez B, resztę zamieniaj na znak (0-9 lub A-F). Zbieraj reszty od tyłu.','42 2','101010',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long n; int b; cin >> n >> b;
    if(n == 0){ cout << 0; return 0; }
    string res = "";
    while(n > 0){
        int r = n % b;
        res = char(r < 10 ? ''0''+r : ''A''+(r-10)) + res;
        n /= b;
    }
    cout << res << endl;
    return 0;
}');
INSERT INTO matura_db.algo_tasks (id,title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 (11,'NWD i NWW','easy','Wczytaj dwie dodatnie liczby całkowite A i B (1 ≤ A, B ≤ 10^9). Wypisz w dwóch liniach: NWD(A,B) i NWW(A,B). NWW = A/NWD * B (uważaj na overflow, użyj long long).','NWD algorytmem Euklidesa. NWW(a,b) = a / NWD(a,b) * b – najpierw dziel, by uniknąć overflow.','12 8','4
24',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long a, b;
    cin >> a >> b;
    long long p = a, q = b;
    while(q != 0){ long long r = p % q; p = q; q = r; }
    cout << p << "\n" << (a / p) * b << endl;
    return 0;
}'),
	 (12,'Porównywanie tekstów (anagram)','easy','Wczytaj dwa słowa S1 i S2 (tylko małe litery, max 1000 znaków). Wypisz TAK jeśli są anagramami (zawierają te same litery w dowolnej kolejności), NIE w przeciwnym razie.','Posortuj oba ciągi i porównaj. Lub zlicz wystąpienia każdej litery (tablica int freq[26]).','listen
silent','TAK',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string a, b; cin >> a >> b;
    sort(a.begin(), a.end());
    sort(b.begin(), b.end());
    cout << (a == b ? "TAK" : "NIE") << endl;
    return 0;
}'),
	 (13,'Wyszukiwanie wzorca (metoda naiwna)','medium','Wczytaj tekst T i wzorzec W (tylko małe litery). Wypisz wszystkie pozycje (od 0) początku wzorca w tekście, każdą w osobnej linii. Jeśli brak – wypisz "BRAK".','Dla każdej pozycji i (0..len(T)-len(W)) sprawdź czy T[i..i+len(W)] == W. Złożoność O(n*m) jest wystarczająca.','ababcabab
ab','0
2
5
7',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string t, w;
    getline(cin, t);
    getline(cin, w);
    int n = t.size(), m = w.size();
    bool found = false;
    for(int i = 0; i <= n - m; i++){
        bool match = true;
        for(int j = 0; j < m; j++){
            if(t[i+j] != w[j]){ match = false; break; }
        }
        if(match){
            cout << i << "\n";
            found = true;
        }
    }
    if(!found) cout << "BRAK" << endl;
    return 0;
}'),
	 (14,'Szyfr Cezara','easy','Wczytaj tekst (tylko małe litery i spacje) i liczbę przesunięcia K (0 ≤ K ≤ 25). Wypisz zaszyfrowany tekst (spacje bez zmian, litery przesunięte cyklicznie o K w prawo).','Dla każdej litery c: wynik = (c - ''a'' + K) % 26 + ''a''. Spacje przepisz bez zmian.','hello world
3','khoor zruog',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string s;
    getline(cin, s);
    int k; cin >> k;
    k = ((k % 26) + 26) % 26;
    for(char& c : s){
        if(c>=''a''&&c<=''z'') c = ''a'' + (c-''a''+k)%26;
        else if(c>=''A''&&c<=''Z'') c = ''A'' + (c-''A''+k)%26;
    }
    cout << s << endl;
    return 0;
}'),
	 (16,'Algorytm Euklidesa – wersja rekurencyjna','easy','Wczytaj dwie nieujemne liczby całkowite A i B (0 ≤ A,B ≤ 10^18). Wypisz NWD używając rekurencji. Następnie wypisz liczbę wywołań rekurencyjnych (wliczając pierwsze wywołanie).','nwd(a,b): jeśli b==0 zwróć a, wpp zwróć nwd(b, a%b). Licznik++przy każdym wywołaniu. Użyj long long.','48 18','6
4',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int cnt = 0;
long long nwd(long long a, long long b){
    cnt++;
    if(b == 0) return a;
    return nwd(b, a % b);
}
int main(){
    long long a, b;
    cin >> a >> b;
    long long g = nwd(a, b);
    cout << g << "\n" << cnt << endl;
    return 0;
}'),
	 (17,'Wyszukiwanie max i min jednocześnie','easy','Wczytaj n (1 ≤ n ≤ 10^6) i n liczb całkowitych. Wypisz minimum i maksimum w dwóch liniach. Policz porównania i wypisz w trzeciej linii. Metoda dziel i zwyciężaj: porównuj parami (ceil(3n/2)-2 porównań).','Metoda par: dla każdej pary (a[i], a[i+1]) znajdź lokalny min i max (1 porównanie), potem porównaj z globalnym min/max (2 porównania). Razem ~3n/2 porównań.','6
3 1 4 1 5 9','1
9
8',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    int mn = a[0], mx = a[0];
    int cmp = 0;
    int i = 1;
    for(; i + 1 < n; i += 2){
        int lo, hi;
        cmp++;
        if(a[i] < a[i+1]){ lo = a[i]; hi = a[i+1]; }
        else { lo = a[i+1]; hi = a[i]; }
        cmp++;
        if(lo < mn) mn = lo;
        cmp++;
        if(hi > mx) mx = hi;
    }
    if(i < n){
        cmp++;
        if(a[i] < mn) mn = a[i];
        else { cmp++; if(a[i] > mx) mx = a[i]; }
    }
    cout << mn << "\n" << mx << "\n" << cmp << endl;
    return 0;
}'),
	 (18,'Sortowanie przez scalanie (Merge Sort)','hard','Wczytaj n (1 ≤ n ≤ 10^5) i n liczb całkowitych. Posortuj rosnąco algorytmem merge sort i wypisz wynik. W drugiej linii wypisz liczbę porównań wykonanych podczas scalania.','Rekurencyjnie dziel na pół, sort lewą, sort prawą, scal. Podczas scalania licz każde porównanie elementów. Złożoność O(n log n).','5
5 3 1 4 2','1 2 3 4 5
7',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int cmpCnt = 0;
void mergeSort(vector<int>& a, int l, int r){
    if(l >= r) return;
    int mid = (l + r) / 2;
    mergeSort(a, l, mid);
    mergeSort(a, mid + 1, r);
    vector<int> tmp;
    int i = l, j = mid + 1;
    while(i <= mid && j <= r){
        cmpCnt++;
        if(a[i] <= a[j]) tmp.push_back(a[i++]);
        else tmp.push_back(a[j++]);
    }
    while(i <= mid) tmp.push_back(a[i++]);
    while(j <= r) tmp.push_back(a[j++]);
    for(int k = l; k <= r; k++) a[k] = tmp[k - l];
}
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    mergeSort(a, 0, n - 1);
    for(int i = 0; i < n; i++){
        if(i) cout << " ";
        cout << a[i];
    }
    cout << "\n" << cmpCnt << endl;
    return 0;
}'),
	 (19,'Metoda połowienia – miejsce zerowe','medium','Wczytaj trzy liczby rzeczywiste a, b, eps (a < b, eps > 0). Znajdź miejsce zerowe funkcji f(x) = x^3 - x - 2 w przedziale [a,b] metodą bisekcji. Wypisz wynik z dokładnością do eps (format %.6f).','mid = (a+b)/2. Jeśli f(a)*f(mid) <= 0, to b=mid, wpp a=mid. Powtarzaj dopóki b-a > eps.','1.0 2.0 0.000001','1.521380',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
double f(double x){ return x*x*x - x - 2; }
int main(){
    double a, b, eps;
    cin >> a >> b >> eps;
    for(int i = 0; i < 200 && b - a > eps * 0.01; i++){
        double mid = (a + b) / 2.0;
        if(f(a) * f(mid) <= 0) b = mid;
        else a = mid;
    }
    printf("%.6f\n", (a + b) / 2.0);
    return 0;
}'),
	 (20,'Pierwiastek kwadratowy (metoda Newtona)','medium','Wczytaj liczbę rzeczywistą X (0 < X ≤ 10^9) i dokładność eps (domyślnie 1e-9). Wypisz sqrt(X) obliczone metodą Newtona-Raphsona z dokładnością 6 miejsc po przecinku.','x_{n+1} = (x_n + X/x_n) / 2. Startuj od x0 = X/2. Powtarzaj dopóki |x_{n+1} - x_n| > eps.','2','1.414214',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    double X;
    cin >> X;
    double eps = 1e-9;
    double x = X;
    if(x == 0){ printf("%.6f\n", 0.0); return 0; }
    while(true){
        double nx = (x + X / x) / 2.0;
        if(fabs(nx - x) < eps) break;
        x = nx;
    }
    printf("%.6f\n", x);
    return 0;
}'),
	 (21,'Schemat Hornera – wartość wielomianu','medium','Wczytaj stopień n (0 ≤ n ≤ 1000), następnie n+1 współczynników a_n, a_{n-1}, ..., a_0, a na końcu wartość x. Oblicz wartość wielomianu W(x) i wypisz ją. Użyj schematu Hornera.','W = a_n; for i in 1..n: W = W*x + a_{n-i}. Złożoność O(n), bez potęgowania.','2
1 -3 2
3','2',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<long long> a(n + 1);
    for(int i = 0; i <= n; i++) cin >> a[i];
    long long x; cin >> x;
    long long w = a[0];
    for(int i = 1; i <= n; i++) w = w * x + a[i];
    cout << w << endl;
    return 0;
}');
INSERT INTO matura_db.algo_tasks (id,title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 (22,'Szybkie potęgowanie iteracyjne','medium','Wczytaj podstawę B i wykładnik E (0 ≤ B ≤ 10^9, 0 ≤ E ≤ 10^18). Oblicz B^E mod 10^9+7 algorytmem szybkiego potęgowania iteracyjnego.','res=1, base=B%MOD. Dopóki E>0: jeśli E%2==1 to res=res*base%MOD. base=base*base%MOD. E/=2. Użyj long long!','2 10','1024',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long b, e;
    cin >> b >> e;
    long long mod = 1000000007;
    long long result = 1;
    b %= mod;
    while(e > 0){
        if(e & 1) result = result * b % mod;
        b = b * b % mod;
        e >>= 1;
    }
    cout << result << endl;
    return 0;
}'),
	 (23,'Szybkie potęgowanie rekurencyjne','medium','Wczytaj B i E (0 ≤ B ≤ 10^9, 0 ≤ E ≤ 10^9). Oblicz B^E mod 10^9+7 rekurencyjnie. Wypisz wynik i głębokość rekurencji.','fast_pow(b,e): jeśli e==0 zwróć 1; jeśli e parzyste: t=fast_pow(b,e/2); zwróć t*t%MOD; wpp zwróć b*fast_pow(b,e-1)%MOD. Głębokość = log2(E)+1.','2 10','1024
5',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
const long long MOD = 1000000007;
int depth = 0;
long long fpow(long long b, long long e){
    depth++;
    if(e == 0) return 1;
    long long t = fpow(b, e / 2);
    t = t * t % MOD;
    if(e % 2 == 1) t = t * b % MOD;
    return t;
}
int main(){
    long long b, e;
    cin >> b >> e;
    b %= MOD;
    long long res = fpow(b, e);
    cout << res << "\n" << depth << endl;
    return 0;
}'),
	 (24,'Rekurencyjne fraktale – ciąg Kocha (długość)','hard','Wczytaj długość boku L (liczba całkowita) i liczbę iteracji n (0 ≤ n ≤ 20). Wypisz łączną długość krzywej Kocha po n iteracjach. Każdy segment dzieli się na 4 segmenty o długości 1/3 pierwotnego. Wypisz jako liczbę całkowitą (L * 4^n / 3^n – wypisz licznik i mianownik w postaci nieskracalnej).','Po n krokach: liczba segmentów = 4^n, długość segmentu = L/3^n. Łączna = L * (4/3)^n. Wypisz licznik/mianownik po uproszczeniu przez NWD.','3 2','16/3',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long L, n;
    cin >> L >> n;
    long long num = L;
    long long den = 1;
    for(int i = 0; i < n; i++){
        num *= 4;
        den *= 3;
    }
    long long a = num, b = den;
    while(b != 0){ long long r = a % b; a = b; b = r; }
    cout << num / a << "/" << den / a << endl;
    return 0;
}'),
	 (26,'Najdłuższy wspólny podciąg (LCS)','hard','Wczytaj dwa ciągi znaków S1 i S2 (tylko małe litery, max 1000 znaków każdy). Wypisz długość najdłuższego wspólnego podciągu (LCS) i sam podciąg. Programowanie dynamiczne.','dp[i][j] = dp[i-1][j-1]+1 jeśli S1[i]==S2[j], wpp max(dp[i-1][j], dp[i][j-1]). Odtwórz podciąg idąc wstecz.','ABCBDAB
BDCAB','4
BCAB',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string a, b; cin >> a >> b;
    int n = a.size(), m = b.size();
    vector<vector<int>> dp(n+1, vector<int>(m+1, 0));
    for(int i = 1; i <= n; i++)
        for(int j = 1; j <= m; j++)
            if(a[i-1] == b[j-1]) dp[i][j] = dp[i-1][j-1] + 1;
            else dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
    cout << dp[n][m] << "\n";
    string lcs = "";
    int i = n, j = m;
    while(i > 0 && j > 0){
        if(a[i-1] == b[j-1]){ lcs = a[i-1] + lcs; i--; j--; }
        else if(dp[i-1][j] >= dp[i][j-1]) i--;
        else j--;
    }
    cout << lcs << endl;
    return 0;
}'),
	 (27,'Zamiana na ONP i obliczanie wartości','hard','Wczytaj wyrażenie arytmetyczne w notacji infiksowej (liczby całkowite, operatory +,-,*,/, nawiasy). Wypisz postać ONP (odwrotna notacja polska), a w drugiej linii wartość wyrażenia (dzielenie całkowite).','Algorytm stacji rozrządowej (Shunting-yard): operatory na stos, liczby do kolejki. Priorytety: */=2, +/−=1. Ewaluuj ONP stosem.','3 + 4 * 2','3 4 2 * +
11',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int prec(char c){ return (c==''*''||c==''/'')?2:1; }
int main(){
    string line;
    getline(cin, line);
    istringstream iss(line);
    vector<string> onp;
    stack<char> ops;
    string tok;
    while(iss >> tok){
        if(tok == "(") ops.push(''('');
        else if(tok == ")"){
            while(ops.top() != ''(''){
                string s(1, ops.top()); onp.push_back(s); ops.pop();
            }
            ops.pop();
        } else if(tok=="+"||tok=="-"||tok=="*"||tok=="/"){
            char c = tok[0];
            while(!ops.empty() && ops.top()!=''('' && prec(ops.top())>=prec(c)){
                string s(1, ops.top()); onp.push_back(s); ops.pop();
            }
            ops.push(c);
        } else {
            onp.push_back(tok);
        }
    }
    while(!ops.empty()){
        string s(1, ops.top()); onp.push_back(s); ops.pop();
    }
    for(int i = 0; i < (int)onp.size(); i++){
        if(i) cout << " ";
        cout << onp[i];
    }
    cout << "\n";
    stack<long long> st;
    for(auto& t : onp){
        if(t=="+"||t=="-"||t=="*"||t=="/"){
            long long b = st.top(); st.pop();
            long long a = st.top(); st.pop();
            if(t=="+") st.push(a+b);
            else if(t=="-") st.push(a-b);
            else if(t=="*") st.push(a*b);
            else st.push(a/b);
        } else {
            st.push(stoll(t));
        }
    }
    cout << st.top() << endl;
    return 0;
}'),
	 (28,'Podejście zachłanne – wydawanie reszty','medium','Wczytaj kwotę Q i liczbę nominałów k (1 ≤ k ≤ 20). Następnie k nominałów w kolejności malejącej. Wypisz minimalną liczbę monet metodą zachłanną i ich skład (po jednej linii na nominał: "nominał x ilość"). Zakładaj, że nominały pozwalają zawsze wydać resztę.','Zachłannie: bierz jak najwięcej największego nominału, potem następnego. Monety[i] = Q / nominał[i]; Q %= nominał[i].','41
3
25 10 1','8
25 x 1
10 x 1
1 x 6',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int q, k;
    cin >> q >> k;
    vector<int> nom(k);
    for(int i = 0; i < k; i++) cin >> nom[i];
    if(q == 0){ cout << 0 << endl; return 0; }
    int total = 0;
    vector<pair<int,int>> used;
    for(int i = 0; i < k; i++){
        int cnt = q / nom[i];
        if(cnt > 0){
            total += cnt;
            q -= cnt * nom[i];
        }
        used.push_back({nom[i], cnt});
    }
    cout << total << "\n";
    for(auto& p : used){
        cout << p.first << " x " << p.second << "\n";
    }
    return 0;
}'),
	 (29,'Programowanie dynamiczne – najdłuższy rosnący podciąg (LIS)','hard','Wczytaj n (1 ≤ n ≤ 10^4) i n liczb całkowitych. Wypisz długość najdłuższego ściśle rosnącego podciągu (LIS) i sam podciąg.','dp[i] = max(dp[j]+1) dla j<i gdzie a[j]<a[i]. dp[i] = 1 na starcie. Złożoność O(n^2). Odtwórz podciąg śledząc poprzedniki.','8
10 9 2 5 3 7 101 18','4
2 3 7 18',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int& x : a) cin >> x;
    vector<int> dp(n, 1), prev(n, -1);
    for(int i = 1; i < n; i++)
        for(int j = 0; j < i; j++)
            if(a[j] < a[i] && dp[j] + 1 >= dp[i]){
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
    int mx = *max_element(dp.begin(), dp.end());
    int idx = -1;
    for(int i = n - 1; i >= 0; i--)
        if(dp[i] == mx){ idx = i; break; }
    cout << mx << "\n";
    vector<int> seq;
    for(int i = idx; i != -1; i = prev[i]) seq.push_back(a[i]);
    reverse(seq.begin(), seq.end());
    for(int i = 0; i < (int)seq.size(); i++){
        if(i) cout << " ";
        cout << seq[i];
    }
    cout << endl;
    return 0;
}'),
	 (31,'Struktury dynamiczne – stos (realizacja ONP)','medium','Zaimplementuj stos na tablicy. Wczytaj n operacji: "PUSH x" (wstaw x), "POP" (usuń i wypisz), "TOP" (podejrzyj bez usuwania), "EMPTY" (wypisz 1 jeśli pusty, 0 wpp). Na wyjściu każda operacja wypisująca w osobnej linii.','Tablica int stack[MAX]; int top=-1. PUSH: stack[++top]=x. POP: return stack[top--]. TOP: return stack[top]. EMPTY: return top==-1.','5
PUSH 3
PUSH 7
TOP
POP
EMPTY','7
7
0',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    cin.ignore();
    vector<int> st;
    for(int i = 0; i < n; i++){
        string line;
        getline(cin, line);
        if(line.substr(0, 4) == "PUSH"){
            int x = stoi(line.substr(5));
            st.push_back(x);
        } else if(line == "POP"){
            cout << st.back() << "\n";
            st.pop_back();
        } else if(line == "TOP"){
            cout << st.back() << "\n";
        } else if(line == "EMPTY"){
            cout << (st.empty() ? 1 : 0) << "\n";
        }
    }
    return 0;
}'),
	 (32,'Struktury dynamiczne – kolejka','medium','Zaimplementuj kolejkę (FIFO). Wczytaj n operacji: "ENQUEUE x", "DEQUEUE" (usuń i wypisz pierwszy), "FRONT" (podejrzyj), "EMPTY". Na wyjściu operacje wypisujące w osobnych liniach.','Tablica cykliczna lub dwie zmienne head/tail. ENQUEUE: arr[tail++]=x. DEQUEUE: return arr[head++].','5
ENQUEUE 3
ENQUEUE 7
FRONT
DEQUEUE
EMPTY','3
3
0',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    cin.ignore();
    queue<int> q;
    for(int i = 0; i < n; i++){
        string line;
        getline(cin, line);
        if(line.substr(0, 7) == "ENQUEUE"){
            int x = stoi(line.substr(8));
            q.push(x);
        } else if(line == "DEQUEUE"){
            cout << q.front() << "\n";
            q.pop();
        } else if(line == "FRONT"){
            cout << q.front() << "\n";
        } else if(line == "EMPTY"){
            cout << (q.empty() ? 1 : 0) << "\n";
        }
    }
    return 0;
}'),
	 (33,'Metoda połowienia – wyszukiwanie w tablicy (rekurencja)','medium','Wczytaj n, tablicę posortowaną rosnąco i szukaną wartość x. Zaimplementuj wyszukiwanie binarne REKURENCYJNIE. Wypisz indeks (od 0) lub -1 oraz liczbę wywołań rekurencyjnych.','bin_search(arr, l, r, x, depth): mid=(l+r)/2. Jeśli arr[mid]==x zwróć {mid, depth}. Jeśli x<arr[mid] szukaj w lewej, wpp prawej. Przypadek: l>r → {-1, depth}.','7
1 3 5 7 9 11 13
7','3
1',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int depth_cnt = 0;
int bsearch(vector<int>& a, int l, int r, int x){
    depth_cnt++;
    if(l > r) return -1;
    int mid = (l + r) / 2;
    if(a[mid] == x) return mid;
    if(x < a[mid]) return bsearch(a, l, mid - 1, x);
    return bsearch(a, mid + 1, r, x);
}
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    int x; cin >> x;
    int pos = bsearch(a, 0, n - 1, x);
    cout << pos << "\n" << depth_cnt << endl;
    return 0;
}');
INSERT INTO matura_db.algo_tasks (id,title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 (34,'Rekurencja – ciąg Fibonacciego z memoizacją','medium','Wczytaj n (0 ≤ n ≤ 50). Oblicz F(n) metodą rekurencyjną z memoizacją. Wypisz F(n) i liczbę unikalnych wywołań rekurencyjnych (bez powtórek dzięki memoizacji). F(0)=0, F(1)=1.','memo[n] = -1 na starcie. Jeśli memo[n] != -1 zwróć memo[n]. Wpp oblicz rekurencyjnie i zapisz. Licznik wywołań bez memoizacji = n+1.','10','55
11',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
long long memo[51];
bool computed[51];
long long fib(int n){
    if(computed[n]) return memo[n];
    computed[n] = true;
    if(n <= 1){ memo[n] = n; return n; }
    memo[n] = fib(n-1) + fib(n-2);
    return memo[n];
}
int main(){
    int n; cin >> n;
    memset(computed, false, sizeof(computed));
    long long res = fib(n);
    cout << res << "\n" << n + 1 << endl;
    return 0;
}'),
	 (35,'Grafy – BFS (najkrótsza ścieżka)','hard','Wczytaj liczbę wierzchołków V i krawędzi E, potem E par (u v) reprezentujących krawędzie nieskierowane, a na końcu wierzchołek startowy S i docelowy T. Wypisz długość najkrótszej ścieżki od S do T lub -1 jeśli nie istnieje. Wierzchołki numerowane od 1.','BFS z kolejką: odległości dist[V+1]=-1. dist[S]=0. Dodaj S do kolejki. Dla każdego u z kolejki: dla każdego sąsiada v: jeśli dist[v]==-1 to dist[v]=dist[u]+1, dodaj v do kolejki.','5 6
1 2
1 3
2 4
3 4
4 5
3 5
1 5','2',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n, m; cin >> n >> m;
    vector<vector<int>> adj(n+1);
    for(int i = 0; i < m; i++){
        int u, v; cin >> u >> v;
        adj[u].push_back(v); adj[v].push_back(u);
    }
    int s, t; cin >> s >> t;
    vector<int> dist(n+1, -1);
    queue<int> q;
    dist[s] = 0; q.push(s);
    while(!q.empty()){
        int u = q.front(); q.pop();
        for(int v : adj[u]) if(dist[v]==-1){ dist[v]=dist[u]+1; q.push(v); }
    }
    cout << dist[t] << endl;
    return 0;
}'),
	 (36,'Sortowanie bąbelkowe (Bubble Sort)','easy','Wczytaj n (1 ≤ n ≤ 1000) i n liczb całkowitych. Posortuj rosnąco algorytmem bubble sort. Wypisz posortowaną tablicę, a w drugiej linii liczbę wykonanych zamian (swapów).','Zewnętrzna pętla i od 0 do n-1, wewnętrzna j od 0 do n-i-2. Jeśli a[j]>a[j+1] → zamień i swap++. Optymalizacja: przerwij gdy brak zamian w przejściu.','5
5 3 1 4 2','1 2 3 4 5
7',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    int swaps = 0;
    for(int i = 0; i < n-1; i++)
        for(int j = 0; j < n-1-i; j++)
            if(a[j] > a[j+1]){ swap(a[j], a[j+1]); swaps++; }
    for(int i = 0; i < n; i++){
        if(i) cout << " ";
        cout << a[i];
    }
    cout << "\n" << swaps << endl;
    return 0;
}'),
	 (37,'Sortowanie szybkie (Quick Sort)','hard','Wczytaj n (1 ≤ n ≤ 10^5) i n liczb całkowitych. Posortuj rosnąco algorytmem quicksort (pivot = ostatni element partycji). Wypisz posortowaną tablicę i liczbę porównań wykonanych w funkcji partition.','partition(arr,l,r): pivot=arr[r], i=l-1. Dla j=l..r-1: jeśli arr[j]<=pivot to i++, swap(arr[i],arr[j]), porównanie++. Swap(arr[i+1],arr[r]). Rekurencja na obu częściach.','5
3 6 8 10 1','1 3 6 8 10
10',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int cmpCnt = 0;
int partition(vector<int>& a, int l, int r){
    int pivot = a[r], i = l - 1;
    for(int j = l; j < r; j++){
        cmpCnt++;
        if(a[j] <= pivot){ i++; swap(a[i], a[j]); }
    }
    swap(a[i+1], a[r]);
    return i + 1;
}
void qsort(vector<int>& a, int l, int r){
    if(l >= r) return;
    int p = partition(a, l, r);
    int lo = p, hi = p;
    while(lo > l && a[lo-1] == a[p]) lo--;
    while(hi < r && a[hi+1] == a[p]) hi++;
    qsort(a, l, lo - 1);
    qsort(a, hi + 1, r);
}
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    qsort(a, 0, n - 1);
    for(int i = 0; i < n; i++){
        if(i) cout << " ";
        cout << a[i];
    }
    cout << "\n" << cmpCnt << endl;
    return 0;
}'),
	 (38,'Wyszukiwanie liniowe','easy','Wczytaj n (1 ≤ n ≤ 10^6), n liczb całkowitych, a następnie szukaną wartość x. Wypisz indeks (od 0) pierwszego wystąpienia x lub -1 jeśli nie znaleziono. W drugiej linii wypisz liczbę wykonanych porównań.','Iteruj od i=0 do n-1, porównanie++ przy każdym kroku. Jeśli a[i]==x zwróć i. Jeśli przeszedłeś całą tablicę → -1. Liczba porównań = i+1 (znaleziony) lub n (nieznaleziony).','5
3 1 4 1 5
4','2
3',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    int x; cin >> x;
    int pos = -1, cmp = 0;
    for(int i = 0; i < n; i++){
        cmp++;
        if(a[i] == x){ pos = i; break; }
    }
    cout << pos << "\n" << cmp << endl;
    return 0;
}'),
	 (39,'Ciąg Fibonacciego (iteracyjny)','easy','Wczytaj n (0 ≤ n ≤ 93). Wypisz F(n) – n-ty wyraz ciągu Fibonacciego obliczony iteracyjnie. F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2). Użyj long long (F(93) przekracza zakres int).','Użyj dwóch zmiennych: a=0, b=1. W pętli: temp=a+b, a=b, b=temp. Po n-1 iteracjach a = F(n). Przypadki brzegowe: F(0)=0, F(1)=1.','10','55',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n;
    cin >> n;
    if(n == 0){ cout << 0; return 0; }
    long long a = 0, b = 1;
    for(int i = 2; i <= n; i++){
        long long c = a + b;
        a = b; b = c;
    }
    cout << b << endl;
    return 0;
}'),
	 (40,'Palindromy','easy','Wczytaj słowo S (tylko małe litery, 1 ≤ |S| ≤ 10^6). Wypisz TAK jeśli S jest palindromem (czytane od przodu i od tyłu jest identyczne), NIE w przeciwnym razie.','Porównuj S[i] z S[n-1-i] dla i od 0 do n/2-1. Jeśli jakakolwiek para różna → NIE. Lub odwróć ciąg i porównaj z oryginałem.','kajak','TAK',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    string s; cin >> s;
    string r = s; reverse(r.begin(), r.end());
    cout << (s == r ? "TAK" : "NIE") << endl;
    return 0;
}');	 

ALTER TABLE matura_db.algo_tasks AUTO_INCREMENT = 41;

