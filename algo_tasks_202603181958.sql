INSERT INTO matura_db.algo_tasks (title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 ('Liczba pierwsza','easy','Wczytaj liczbę całkowitą N (0 ≤ N ≤ 10^9). Wypisz TAK jeśli jest pierwsza, NIE w przeciwnym razie.','Sprawdzaj dzielniki tylko do √N. Pętla: for(int i=2; i*i<=n; i++). Pamiętaj: 0 i 1 to nie liczby pierwsze.','17','TAK',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
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
	 ('Rozkład na czynniki pierwsze','easy','Wczytaj N (2 ≤ N ≤ 10^6). Wypisz rozkład: p1^e1 * p2^e2 * ... Pomiń "^1" gdy wykładnik = 1.','Dziel N przez kolejne liczby od 2. Licz powtórzenia. Gdy i*i > N i N > 1, N jest ostatnim czynnikiem.','360','2^3 * 3^2 * 5',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
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
	 ('Wyszukiwanie binarne','medium','Wczytaj n, następnie n posortowanych liczb, potem x. Wypisz indeks (od 0) pierwszego x lub -1.','l=0, r=n-1, mid=(l+r)/2. Porównaj a[mid] z x i zawęż przedział.','7
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
	 ('Konwersja dziesiętna → binarna','easy','Wczytaj N (0 ≤ N ≤ 10^9). Wypisz reprezentację binarną bez wiodących zer. Wyjątek: N=0 → "0".','Dziel N przez 2, zbieraj reszty od tyłu. Szczególny przypadek: N=0.','42','101010',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long n; cin >> n;
    if(n == 0){ cout << 0; return 0; }
    string bin = "";
    while(n > 0){ bin = char(''0'' + n%2) + bin; n /= 2; }
    cout << bin << endl;
    return 0;
}'),
	 ('Algorytm Euklidesa NWD','easy','Wczytaj A i B (0 ≤ A, B ≤ 10^18). Wypisz NWD(A,B). Przypadek: NWD(0,0) = 0.','nwd(a,b) = nwd(b, a%b), nwd(a,0) = a. Użyj long long!','48 18','6',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
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
	 ('Sortowanie przez wstawianie','medium','Wczytaj n, potem n liczb. Posortuj insertion sort rosnąco. Wypisz tablicę, w drugiej linii liczbę przestawień.','Klucz = a[i], cofaj elementy > klucz o jeden w prawo. Każde cofnięcie = +1 do licznika.','5
5 3 1 4 2','1 2 3 4 5
7',1,'2026-03-14 11:29:38','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    for(int i = 1; i < n; i++){
        int key = a[i], j = i-1;
        while(j >= 0 && a[j] > key){ a[j+1] = a[j]; j--; }
        a[j+1] = key;
    }
    for(int i = 0; i < n; i++) cout << a[i] << " 
"[i==n-1];
    return 0;
}'),
	 ('Sito Eratostenesa','medium','Wczytaj N (2 ≤ N ≤ 10^6). Wypisz wszystkie liczby pierwsze od 2 do N, każdą w osobnej linii.','Tablica bool is_prime[N+1]. Dla i od 2: jeśli is_prime[i], oznacz wielokrotności i (od i*i) jako false.','20','2
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
	 ('Liczba doskonała','easy','Wczytaj liczbę całkowitą N (1 ≤ N ≤ 10^7). Wypisz TAK jeśli N jest liczbą doskonałą (suma właściwych dzielników = N), NIE w przeciwnym razie.','Sumuj dzielniki d od 1 do N-1 gdzie N%d==0. Optymalizacja: iteruj do √N i dodawaj oba dzielniki, uważaj na d=√N.','6','TAK',1,'2026-03-14 12:19:36',NULL),
	 ('Konwersja: dziesiętny → hex','easy','Wczytaj liczbę całkowitą N (0 ≤ N ≤ 10^9). Wypisz jej reprezentację szesnastkową WIELKIMI LITERAMI (bez prefiksu 0x). Przypadek: N=0 → "0".','Dziel N przez 16, reszty: 10→A, 11→B, 12→C, 13→D, 14→E, 15→F. Zbieraj od tyłu.','255','FF',1,'2026-03-14 12:19:36','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long n; int b;
    cin >> n >> b;
    if(n == 0){ cout << 0; return 0; }
    string res = "";
    while(n > 0){
        int r = n % b;
        res = char(r < 10 ? ''0''+r : ''A''+(r-10)) + res;
        n /= b;
    }
    cout << res << endl;
    return 0;
}'),
	 ('Konwersja: dziesiętny → system o podstawie B','medium','Wczytaj dwie liczby: N (0 ≤ N ≤ 10^9) i B (2 ≤ B ≤ 16). Wypisz N w systemie o podstawie B (cyfry >9 jako A-F wielkie litery). N=0 → "0".','Dziel N przez B, resztę zamieniaj na znak (0-9 lub A-F). Zbieraj reszty od tyłu.','42 2','101010',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
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
INSERT INTO matura_db.algo_tasks (title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 ('NWD i NWW','easy','Wczytaj dwie dodatnie liczby całkowite A i B (1 ≤ A, B ≤ 10^9). Wypisz w dwóch liniach: NWD(A,B) i NWW(A,B). NWW = A/NWD * B (uważaj na overflow, użyj long long).','NWD algorytmem Euklidesa. NWW(a,b) = a / NWD(a,b) * b – najpierw dziel, by uniknąć overflow.','12 8','4
24',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    long long a, b;
    cin >> a >> b;
    long long p = a, q = b;
    while(q != 0){ long long r = p % q; p = q; q = r; }
    cout << (a / p) * b << endl;
    return 0;
}'),
	 ('Porównywanie tekstów (anagram)','easy','Wczytaj dwa słowa S1 i S2 (tylko małe litery, max 1000 znaków). Wypisz TAK jeśli są anagramami (zawierają te same litery w dowolnej kolejności), NIE w przeciwnym razie.','Posortuj oba ciągi i porównaj. Lub zlicz wystąpienia każdej litery (tablica int freq[26]).','listen
silent','TAK',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string a, b; cin >> a >> b;
    sort(a.begin(), a.end());
    sort(b.begin(), b.end());
    cout << (a == b ? "TAK" : "NIE") << endl;
    return 0;
}'),
	 ('Wyszukiwanie wzorca (metoda naiwna)','medium','Wczytaj tekst T i wzorzec W (tylko małe litery). Wypisz wszystkie pozycje (od 0) początku wzorca w tekście, każdą w osobnej linii. Jeśli brak – wypisz "BRAK".','Dla każdej pozycji i (0..len(T)-len(W)) sprawdź czy T[i..i+len(W)] == W. Złożoność O(n*m) jest wystarczająca.','ababcabab
ab','0
2
5
7',1,'2026-03-14 12:19:37',NULL),
	 ('Szyfr Cezara','easy','Wczytaj tekst (tylko małe litery i spacje) i liczbę przesunięcia K (0 ≤ K ≤ 25). Wypisz zaszyfrowany tekst (spacje bez zmian, litery przesunięte cyklicznie o K w prawo).','Dla każdej litery c: wynik = (c - ''a'' + K) % 26 + ''a''. Spacje przepisz bez zmian.','hello world
3','khoor zruog',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string s; int k;
    cin >> s >> k;
    k = ((k % 26) + 26) % 26;
    for(char& c : s){
        if(c>=''a''&&c<=''z'') c = ''a'' + (c-''a''+k)%26;
        else if(c>=''A''&&c<=''Z'') c = ''A'' + (c-''A''+k)%26;
    }
    cout << s << endl;
    return 0;
}'),
	 ('Algorytm Euklidesa – wersja rekurencyjna','easy','Wczytaj dwie nieujemne liczby całkowite A i B (0 ≤ A,B ≤ 10^18). Wypisz NWD używając rekurencji. Następnie wypisz liczbę wywołań rekurencyjnych (wliczając pierwsze wywołanie).','nwd(a,b): jeśli b==0 zwróć a, wpp zwróć nwd(b, a%b). Licznik++przy każdym wywołaniu. Użyj long long.','48 18','6
4',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
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
	 ('Wyszukiwanie max i min jednocześnie','easy','Wczytaj n (1 ≤ n ≤ 10^6) i n liczb całkowitych. Wypisz minimum i maksimum w dwóch liniach. Policz porównania i wypisz w trzeciej linii. Metoda dziel i zwyciężaj: porównuj parami (ceil(3n/2)-2 porównań).','Metoda par: dla każdej pary (a[i], a[i+1]) znajdź lokalny min i max (1 porównanie), potem porównaj z globalnym min/max (2 porównania). Razem ~3n/2 porównań.','6
3 1 4 1 5 9','1
9
8',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int& x : a) cin >> x;
    cout << *max_element(a.begin(), a.end()) << " "
         << *min_element(a.begin(), a.end()) << endl;
    return 0;
}'),
	 ('Sortowanie przez scalanie (Merge Sort)','hard','Wczytaj n (1 ≤ n ≤ 10^5) i n liczb całkowitych. Posortuj rosnąco algorytmem merge sort i wypisz wynik. W drugiej linii wypisz liczbę porównań wykonanych podczas scalania.','Rekurencyjnie dziel na pół, sort lewą, sort prawą, scal. Podczas scalania licz każde porównanie elementów. Złożoność O(n log n).','5
5 3 1 4 2','1 2 3 4 5
8',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
void msort(vector<int>& a, int l, int r){
    if(l >= r) return;
    int mid=(l+r)/2;
    msort(a,l,mid); msort(a,mid+1,r);
    inplace_merge(a.begin()+l, a.begin()+mid+1, a.begin()+r+1);
}
int main(){
    int n; cin>>n;
    vector<int> a(n);
    for(int& x:a) cin>>x;
    msort(a,0,n-1);
    for(int i=0;i<n;i++) cout<<a[i]<<" 
"[i==n-1];
    return 0;
}'),
	 ('Metoda połowienia – miejsce zerowe','medium','Wczytaj trzy liczby rzeczywiste a, b, eps (a < b, eps > 0). Znajdź miejsce zerowe funkcji f(x) = x^3 - x - 2 w przedziale [a,b] metodą bisekcji. Wypisz wynik z dokładnością do eps (format %.6f).','mid = (a+b)/2. Jeśli f(a)*f(mid) <= 0, to b=mid, wpp a=mid. Powtarzaj dopóki b-a > eps.','1.0 2.0 0.000001','1.521380',1,'2026-03-14 12:19:37',NULL),
	 ('Pierwiastek kwadratowy (metoda Newtona)','medium','Wczytaj liczbę rzeczywistą X (0 < X ≤ 10^9) i dokładność eps (domyślnie 1e-9). Wypisz sqrt(X) obliczone metodą Newtona-Raphsona z dokładnością 6 miejsc po przecinku.','x_{n+1} = (x_n + X/x_n) / 2. Startuj od x0 = X/2. Powtarzaj dopóki |x_{n+1} - x_n| > eps.','2','1.414214',1,'2026-03-14 12:19:37',NULL),
	 ('Schemat Hornera – wartość wielomianu','medium','Wczytaj stopień n (0 ≤ n ≤ 1000), następnie n+1 współczynników a_n, a_{n-1}, ..., a_0, a na końcu wartość x. Oblicz wartość wielomianu W(x) i wypisz ją. Użyj schematu Hornera.','W = a_n; for i in 1..n: W = W*x + a_{n-i}. Złożoność O(n), bez potęgowania.','2
1 -3 2
3','2',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
long long power(long long base, long long exp, long long mod){
    long long result = 1;
    base %= mod;
    while(exp > 0){
        if(exp & 1) result = result * base % mod;
        base = base * base % mod;
        exp >>= 1;
    }
    return result;
}
int main(){
    long long a, b, m;
    cin >> a >> b >> m;
    cout << power(a, b, m) << endl;
    return 0;
}');
INSERT INTO matura_db.algo_tasks (title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 ('Szybkie potęgowanie iteracyjne','medium','Wczytaj podstawę B i wykładnik E (0 ≤ B ≤ 10^9, 0 ≤ E ≤ 10^18). Oblicz B^E mod 10^9+7 algorytmem szybkiego potęgowania iteracyjnego.','res=1, base=B%MOD. Dopóki E>0: jeśli E%2==1 to res=res*base%MOD. base=base*base%MOD. E/=2. Użyj long long!','2 10','1024',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
long long power(long long base, long long exp, long long mod){
    long long result = 1; base %= mod;
    while(exp > 0){
        if(exp & 1) result = result * base % mod;
        base = base * base % mod;
        exp >>= 1;
    }
    return result;
}
int main(){
    long long a, b, m; cin >> a >> b >> m;
    cout << power(a, b, m) << endl;
    return 0;
}'),
	 ('Szybkie potęgowanie rekurencyjne','medium','Wczytaj B i E (0 ≤ B ≤ 10^9, 0 ≤ E ≤ 10^9). Oblicz B^E mod 10^9+7 rekurencyjnie. Wypisz wynik i głębokość rekurencji.','fast_pow(b,e): jeśli e==0 zwróć 1; jeśli e parzyste: t=fast_pow(b,e/2); zwróć t*t%MOD; wpp zwróć b*fast_pow(b,e-1)%MOD. Głębokość = log2(E)+1.','2 10','1024
5',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
long long power(long long base, long long exp, long long mod){
    long long result = 1;
    base %= mod;
    while(exp > 0){
        if(exp & 1) result = result * base % mod;
        base = base * base % mod;
        exp >>= 1;
    }
    return result;
}
int main(){
    long long a, b, m;
    cin >> a >> b >> m;
    cout << power(a, b, m) << endl;
    return 0;
}'),
	 ('Rekurencyjne fraktale – ciąg Kocha (długość)','hard','Wczytaj długość boku L (liczba całkowita) i liczbę iteracji n (0 ≤ n ≤ 20). Wypisz łączną długość krzywej Kocha po n iteracjach. Każdy segment dzieli się na 4 segmenty o długości 1/3 pierwotnego. Wypisz jako liczbę całkowitą (L * 4^n / 3^n – wypisz licznik i mianownik w postaci nieskracalnej).','Po n krokach: liczba segmentów = 4^n, długość segmentu = L/3^n. Łączna = L * (4/3)^n. Wypisz licznik/mianownik po uproszczeniu przez NWD.','3 2','16/3',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
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
	 ('Najdłuższy wspólny podciąg (LCS)','hard','Wczytaj dwa ciągi znaków S1 i S2 (tylko małe litery, max 1000 znaków każdy). Wypisz długość najdłuższego wspólnego podciągu (LCS) i sam podciąg. Programowanie dynamiczne.','dp[i][j] = dp[i-1][j-1]+1 jeśli S1[i]==S2[j], wpp max(dp[i-1][j], dp[i][j-1]). Odtwórz podciąg idąc wstecz.','ABCBDAB
BDCAB','4
BCAB',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string a, b; cin >> a >> b;
    int n=a.size(), m=b.size();
    vector<vector<int>> dp(n+1,vector<int>(m+1,0));
    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
            if(a[i-1]==b[j-1]) dp[i][j]=dp[i-1][j-1]+1;
            else dp[i][j]=max(dp[i-1][j],dp[i][j-1]);
    cout<<dp[n][m]<<endl;
    return 0;
}'),
	 ('Zamiana na ONP i obliczanie wartości','hard','Wczytaj wyrażenie arytmetyczne w notacji infiksowej (liczby całkowite, operatory +,-,*,/, nawiasy). Wypisz postać ONP (odwrotna notacja polska), a w drugiej linii wartość wyrażenia (dzielenie całkowite).','Algorytm stacji rozrządowej (Shunting-yard): operatory na stos, liczby do kolejki. Priorytety: */=2, +/−=1. Ewaluuj ONP stosem.','3 + 4 * 2','3 4 2 * +
11',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string s; cin >> s;
    stack<char> st;
    bool ok = true;
    for(char c : s){
        if(c==''('' || c==''['' || c==''{'') st.push(c);
        else if(c=='')'' || c=='']'' || c==''}''){
            if(st.empty()){ ok=false; break; }
            char top = st.top(); st.pop();
            if((c=='')'' && top!=''('') ||
               (c=='']'' && top!=''['') ||
               (c==''}'' && top!=''{'')){ ok=false; break; }
        }
    }
    if(!st.empty()) ok = false;
    cout << (ok ? "TAK" : "NIE") << endl;
    return 0;
}'),
	 ('Podejście zachłanne – wydawanie reszty','medium','Wczytaj kwotę Q i liczbę nominałów k (1 ≤ k ≤ 20). Następnie k nominałów w kolejności malejącej. Wypisz minimalną liczbę monet metodą zachłanną i ich skład (po jednej linii na nominał: "nominał x ilość", pomiń zera). Zakładaj, że nominały pozwalają zawsze wydać resztę.','Zachłannie: bierz jak najwięcej największego nominału, potem następnego. Monety[i] = Q / nominał[i]; Q %= nominał[i].','41
3
25 10 1','4
25 x 1
10 x 1
1 x 6',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n, k; cin >> n >> k;
    vector<int> monety(k);
    for(int& x : monety) cin >> x;
    vector<int> dp(n+1, INT_MAX);
    dp[0] = 0;
    for(int i = 1; i <= n; i++)
        for(int m : monety)
            if(m <= i && dp[i-m] != INT_MAX)
                dp[i] = min(dp[i], dp[i-m]+1);
    cout << (dp[n]==INT_MAX ? -1 : dp[n]) << endl;
    return 0;
}'),
	 ('Programowanie dynamiczne – najdłuższy rosnący podciąg (LIS)','hard','Wczytaj n (1 ≤ n ≤ 10^4) i n liczb całkowitych. Wypisz długość najdłuższego ściśle rosnącego podciągu (LIS) i sam podciąg.','dp[i] = max(dp[j]+1) dla j<i gdzie a[j]<a[i]. dp[i] = 1 na starcie. Złożoność O(n^2). Odtwórz podciąg śledząc poprzedniki.','8
10 9 2 5 3 7 101 18','4
2 3 7 18',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
// Przykład: najdłuższy rosnący podciąg (LIS)
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int& x : a) cin >> x;
    vector<int> dp(n, 1);
    for(int i=1;i<n;i++)
        for(int j=0;j<i;j++)
            if(a[j]<a[i]) dp[i]=max(dp[i], dp[j]+1);
    cout << *max_element(dp.begin(), dp.end()) << endl;
    return 0;
}'),
	 ('Struktury dynamiczne – stos (realizacja ONP)','medium','Zaimplementuj stos na tablicy. Wczytaj n operacji: "PUSH x" (wstaw x), "POP" (usuń i wypisz), "TOP" (podejrzyj bez usuwania), "EMPTY" (wypisz 1 jeśli pusty, 0 wpp). Na wyjściu każda operacja wypisująca w osobnej linii.','Tablica int stack[MAX]; int top=-1. PUSH: stack[++top]=x. POP: return stack[top--]. TOP: return stack[top]. EMPTY: return top==-1.','5
PUSH 3
PUSH 7
TOP
POP
EMPTY','7
7
0',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    string s; cin >> s;
    stack<char> st;
    bool ok = true;
    for(char c : s){
        if(c==''(''||c==''[''||c==''{'') st.push(c);
        else if(c=='')''||c=='']''||c==''}''){
            if(st.empty()){ ok=false; break; }
            char top = st.top(); st.pop();
            if((c=='')''&&top!=''('') || (c=='']''&&top!=''['') || (c==''}''&&top!=''{'')){ ok=false; break; }
        }
    }
    if(!st.empty()) ok = false;
    cout << (ok ? "TAK" : "NIE") << endl;
    return 0;
}'),
	 ('Struktury dynamiczne – kolejka','medium','Zaimplementuj kolejkę (FIFO). Wczytaj n operacji: "ENQUEUE x", "DEQUEUE" (usuń i wypisz pierwszy), "FRONT" (podejrzyj), "EMPTY". Na wyjściu operacje wypisujące w osobnych liniach.','Tablica cykliczna lub dwie zmienne head/tail. ENQUEUE: arr[tail++]=x. DEQUEUE: return arr[head++].','5
ENQUEUE 3
ENQUEUE 7
FRONT
DEQUEUE
EMPTY','3
3
0',1,'2026-03-14 12:19:37',NULL),
	 ('Metoda połowienia – wyszukiwanie w tablicy (rekurencja)','medium','Wczytaj n, tablicę posortowaną rosnąco i szukaną wartość x. Zaimplementuj wyszukiwanie binarne REKURENCYJNIE. Wypisz indeks (od 0) lub -1 oraz głębokość rekurencji.','bin_search(arr, l, r, x, depth): mid=(l+r)/2. Jeśli arr[mid]==x zwróć {mid, depth}. Jeśli x<arr[mid] szukaj w lewej, wpp prawej. Przypadek: l>r → {-1, depth}.','7
1 3 5 7 9 11 13
7','3
2',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
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
}');
INSERT INTO matura_db.algo_tasks (title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES
	 ('Rekurencja – ciąg Fibonacciego z memoizacją','medium','Wczytaj n (0 ≤ n ≤ 50). Oblicz F(n) metodą rekurencyjną z memoizacją. Wypisz F(n) i liczbę unikalnych wywołań rekurencyjnych (bez powtórek dzięki memoizacji). F(0)=0, F(1)=1.','memo[n] = -1 na starcie. Jeśli memo[n] != -1 zwróć memo[n]. Wpp oblicz rekurencyjnie i zapisz. Licznik wywołań bez memoizacji = n+1.','10','55
11',1,'2026-03-14 12:19:37','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n;
    cin >> n;
    long long a = 0, b = 1;
    if(n == 0){ cout << 0; return 0; }
    for(int i = 2; i <= n; i++){
        long long c = a + b;
        a = b; b = c;
    }
    cout << b << endl;
    return 0;
}'),
	 ('Grafy – BFS (najkrótsza ścieżka)','hard','Wczytaj liczbę wierzchołków V i krawędzi E, potem E par (u v) reprezentujących krawędzie nieskierowane, a na końcu wierzchołek startowy S i docelowy T. Wypisz długość najkrótszej ścieżki od S do T lub -1 jeśli nie istnieje. Wierzchołki numerowane od 1.','BFS z kolejką: odległości dist[V+1]=-1. dist[S]=0. Dodaj S do kolejki. Dla każdego u z kolejki: dla każdego sąsiada v: jeśli dist[v]==-1 to dist[v]=dist[u]+1, dodaj v do kolejki.','5 6
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
	 ('Sortowanie bąbelkowe (Bubble Sort)','easy','Wczytaj n (1 ≤ n ≤ 1000) i n liczb całkowitych. Posortuj rosnąco algorytmem bubble sort. Wypisz posortowaną tablicę, a w drugiej linii liczbę wykonanych zamian (swapów).','Zewnętrzna pętla i od 0 do n-1, wewnętrzna j od 0 do n-i-2. Jeśli a[j]>a[j+1] → zamień i swap++. Optymalizacja: przerwij gdy brak zamian w przejściu.','5
5 3 1 4 2','1 2 3 4 5
7',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    for(int i = 0; i < n-1; i++)
        for(int j = 0; j < n-1-i; j++)
            if(a[j] > a[j+1]) swap(a[j], a[j+1]);
    for(int i = 0; i < n; i++) cout << a[i] << " 
"[i==n-1];
    return 0;
}'),
	 ('Sortowanie szybkie (Quick Sort)','hard','Wczytaj n (1 ≤ n ≤ 10^5) i n liczb całkowitych. Posortuj rosnąco algorytmem quicksort (pivot = ostatni element partycji). Wypisz posortowaną tablicę i liczbę porównań wykonanych w funkcji partition.','partition(arr,l,r): pivot=arr[r], i=l-1. Dla j=l..r-1: jeśli arr[j]<=pivot to i++, swap(arr[i],arr[j]), porównanie++. Swap(arr[i+1],arr[r]). Rekurencja na obu częściach.','5
3 6 8 10 1','1 3 6 8 10
10',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
void qsort(vector<int>& a, int l, int r){
    if(l >= r) return;
    int pivot = a[(l+r)/2], i = l, j = r;
    while(i <= j){
        while(a[i] < pivot) i++;
        while(a[j] > pivot) j--;
        if(i <= j) swap(a[i++], a[j--]);
    }
    qsort(a, l, j);
    qsort(a, i, r);
}
int main(){
    int n; cin >> n;
    vector<int> a(n);
    for(int& x : a) cin >> x;
    qsort(a, 0, n-1);
    for(int i = 0; i < n; i++) cout << a[i] << " \\n"[i==n-1];
    return 0;
}'),
	 ('Wyszukiwanie liniowe','easy','Wczytaj n (1 ≤ n ≤ 10^6), n liczb całkowitych, a następnie szukaną wartość x. Wypisz indeks (od 0) pierwszego wystąpienia x lub -1 jeśli nie znaleziono. W drugiej linii wypisz liczbę wykonanych porównań.','Iteruj od i=0 do n-1, porównanie++ przy każdym kroku. Jeśli a[i]==x zwróć i. Jeśli przeszedłeś całą tablicę → -1. Liczba porównań = i+1 (znaleziony) lub n (nieznaleziony).','5
3 1 4 1 5
4','2
3',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    int n; cin >> n;
    map<int, int> cnt;
    for(int i = 0; i < n; i++){
        int x; cin >> x; cnt[x]++;
    }
    for(auto& [val, c] : cnt)
        cout << val << ": " << c << "\\n";
    return 0;
}'),
	 ('Ciąg Fibonacciego (iteracyjny)','easy','Wczytaj n (0 ≤ n ≤ 93). Wypisz F(n) – n-ty wyraz ciągu Fibonacciego obliczony iteracyjnie. F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2). Użyj long long (F(93) przekracza zakres int).','Użyj dwóch zmiennych: a=0, b=1. W pętli: temp=a+b, a=b, b=temp. Po n-1 iteracjach a = F(n). Przypadki brzegowe: F(0)=0, F(1)=1.','10','55',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
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
	 ('Palindromy','easy','Wczytaj słowo S (tylko małe litery, 1 ≤ |S| ≤ 10^6). Wypisz TAK jeśli S jest palindromem (czytane od przodu i od tyłu jest identyczne), NIE w przeciwnym razie.','Porównuj S[i] z S[n-1-i] dla i od 0 do n/2-1. Jeśli jakakolwiek para różna → NIE. Lub odwróć ciąg i porównaj z oryginałem.','kajak','TAK',1,'2026-03-14 12:28:28','#include <bits/stdc++.h>
using namespace std;
int main(){
    string s; cin >> s;
    string r = s; reverse(r.begin(), r.end());
    cout << (s == r ? "TAK" : "NIE") << endl;
    return 0;
}');
