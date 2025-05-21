# Proiect Baze de Date
## Intro
- Tema: Liste cantari
- Numar proiect: 25
- Link partea I: [apasa aici](https://file.notion.so/f/f/fe828575-4b93-4af4-b5c5-87aadc15d6f2/d9204bd1-6946-4696-82f1-b1b1c451a183/141_Irimia_David-proiect.pdf?table=block&id=1c53959e-a721-805c-89c5-fe595c4aa630&spaceId=fe828575-4b93-4af4-b5c5-87aadc15d6f2&expirationTimestamp=1747245600000&signature=nQsbruBI_JFo3hC6UgeFuksoOmM35T4nmxyzSYieTtM&downloadName=141_Irimia_David-proiect.pdf)
## Feedback
### 1. Care sunt specificațiile din descrierea modelului (punctul 1) care nu se regăsesc în diagrame.
#### Iulia Teodora Banu Demergian
- Mențiunea despre autori. Cantare are autor. Un autor are mai multe cântări.
#### Nedelcu Alexandru-Constantin
- La punctul 1 este menționat faptul că instrumentiștii pot salva versuri și acorduri, iar vocaliștii doar versuri, însă aceste constrângeri nu sunt clar ilustrate în diagrame.
#### Miu Georgian-Fabian
- Gama este menționată în descriere ca parte esențială a melodiei și un criteriu de selecție pentru utilizatorii vocaliști, însă lipsește complet din modelul de date, atât ca atribut, cât și ca entitate.
- Versurile și acordurile sunt reprezentate, dar nu apare nicăieri explicit faptul că vocaliștii pot salva doar versuri și gamă, iar instrumentiștii pot salva versuri și acorduri.
- Deși în descriere se menționează că versurile au autor, în diagramă nu apare entitatea Autor și nici vreo relație care să lege versurile de cineva.
- Nu se reflectă opționalitatea partiturii. Ar fi fost util să se marcheze faptul că partitura este opțională în legătură cu cântarea.
---
### 2. Care sunt diferențele între descriere și cardinalitățile reprezentate în ERD?
#### Iulia Teodora Banu Demergian
- Cred ca ar trebui separate relațiile cantare – partitura si cantare - versuri. O cantare poate avea mai multe partituri (aranajament pentru cor, orchestra etc. Partitura poate avea de asemenea un autor)
- O cantare poate avea mai multe versiuni de versuri (spre exemplu traduceri)
- Acordurile si armura, tempo etc pot fi trecute ca atribute, notele in schimb cred ca sunt sub forma de document (partitura) nu ca linii in alt tabel.
- Ca tip de date se poate folosi atât pentru partituri cat si pentru versuri fie un sir de bytes cu continutul unui document, fie url cu adresa unde este memorat documentul.
- Relația face_parte este figurata astfel încât să se implementeze ca un tabel cu cheile (id_utilizator, id_cor, id_trupa), ceea ce induce o relație între id_cor si id_trupa. Si aici, ca la partituri si versuri trebuie separate relațiile. Utilizator poate canta in cor (unul sau mai multe?) si poate independent de cor sa cânte in trupe ( una sau mai multe trupe?).
#### Nedelcu Alexandru-Constantin
- Nu am observat diferențe între descriere și cardinalitățile reprezentate în ERD.
#### Miu Georgian-Fabian
- Relația FACE PARTE între UTILIZATOR și COR/TRUPĂ este interesantă, dar în descriere nu este menționată – pare o extensie logică, dar care trebuie justificată.
- Conectarea BISERICĂ la COR și COMPETIȚIE la TRUPĂ apare doar în ERD – nu sunt menționate deloc în descriere.
---
### 3. Ce elemente din ERD nu sunt transformate corect în diagrama conceptuală?
#### Iulia Teodora Banu Demergian
- De ce apare cheie externa si la cor si la biserica? - Daca este relatie one-to-one punem cheia doar la cor pentru ca nu toate bisericile au cor.
- Daca trupa-competitie este relatie many-to-many atunci este nevoie de un tabel asociativ (ca "are")
#### Nedelcu Alexandru-Constantin
- Elementele din ERD par a fi transformate corect în diagrama conceptuală. Singura observație pe care o am este că la “SE ÎMPARTE” ar putea fi evidențiată mai bine existența unei entități intermediare prin precizarea primary și foreign keyurilor.
#### Miu Georgian-Fabian
- Diagrama conceptuală omite să transpună relațiile many-to-many prin tabele asociative
- De exemplu:
    - Relația ARE (UTILIZATOR–LISTĂ)
    - Relația CONȚINE (LISTĂ–CÂNTARE)
    - Relația SE IMPARTE (CÂNTARE–PARTITURĂ/VERS)
- Acestea ar fi trebuit transformate în tabel asociative cu chei primare compuse.
- Nu sunt definite cheile primare și cheile străine pentru tabele.
---
### 4. Care sunt alte entități sau relații care ar putea extinde proiectul?
#### Iulia Teodora Banu Demergian
- Adaugare categorii de cantari (imnuri, pentru evenimente speciale etc.)
- Adaugare entitate sau atribute instrumente (partiturile pot fi scrise pentru unul sau mai multe instrumente)
- Planificare repetitii cu lista cantarilor care vor fi repetate si in ce tonaliate, programul la care vor fi cantate si alte info utile repetitiei.
#### Nedelcu Alexandru-Constantin
- Poate fi adăugat un sistem de rating pentru cântări sau pentru liste în general.
- De asemenea, pot fi adăugate evenimente/repetiții care să aibă asociate anumite liste care sunt cântate în cadrul activităților respective.
- O altă entitate ar putea fi stilul/genul muzical pentru a putea filtra după aceste caracteristici.
- Poate fi adăugat și un mod de a grupa utilizatorii după trupe/relații de prietenie/relații de colaborare anterioară.
#### Miu Georgian-Fabian
- Autor_versuri – o entitate care să descrie cine a scris textul cântecului.
- Instrumente asociate utilizatorilor de tip instrumentist.
- O entitate Playlist colaborativ sau Etichete/Gen muzical pentru cântări.
---
### 5. Exemple de interogări la care modelul ar trebui să răspundă.
#### Iulia Teodora Banu Demergian
- Care sunt imnurile compuse de Philip Bliss care au fost incluse in cele mai multe liste alte utilizatorilor (top n).
- Care sunt cantarile pe care le au in lista cel putin 10 membri ai corului bisericii Betania.
- Pentru dezvoltarea pentru repetitii: numarul membrilor trupei ... care nu au planificate repetitii la data ....
#### Nedelcu Alexandru-Constantin
```SQL
-- a) Afișează toate cântările dintr-o listă dată
SELECT c.cantare_id, c.nume
FROM lista l
JOIN contine ct ON l.lista_id = ct.lista_id
JOIN cantare c ON ct.cantare_id = c.cantare_id
WHERE l.lista_id = (ID CAUTAT);
-- b) Afișează toate listele create de un utilizator de tip instrumentist:
SELECT l.lista_id, l.nume
FROM utilizator u
JOIN are a ON u.utilizator_id = a.utilizator_id
JOIN lista l ON a.lista_id = l.lista_id
WHERE u.tip = 'instrumentist';
-- c) Afișează utilizatorii care au peste N liste salvate:
SELECT u.utilizator_id, u.nume, COUNT(a.lista_id) AS nr_liste
FROM utilizator u
JOIN are a ON u.utilizator_id = a.utilizator_id
GROUP BY u.utilizator_id, u.nume
HAVING COUNT(a.lista_id) > N;
```
#### Miu Georgian-Fabian
- Afișează toate cântările din lista unui anumit utilizator.
- Afișează toate listele în care apare o anumită cântare.
- Afișează toate cântările cu acorduri în gama Do major.
- Afișează toate trupele care au participat la o competiție dată.
- Afișează vocaliștii care au versuri salvate într-o anumită listă.
---
### 6. Alte observații
#### Iulia Teodora Banu Demergian
- N/A
#### Nedelcu Alexandru-Constantin
- Tema proiectului este creativă și aplicabilitatea reală este bine evidențiată. Descrierea prezintă foarte bine contextul, relațiile dintre entități și constrângerile.
- Diagramele sunt desenate clar, iar organizarea entităților face citirea și urmărirea relațiilor ușoară.
- Consider că este necesar să mai fie adăugate câteva entități pentru a face proiectul mai complex. În plus, ar putea fi adăugate primary si foreign key-urile pentru toate entitățile pentru a evita confuzii asupra tipului unei entități.
#### Miu Georgian-Fabian
- Tema este foarte originală, interesantă, realistă și bine ancorată într-un context muzical autentic. Felicitări pentru creativitate!