------------------------------------------------------------------------------
-- Proiect final, completări cerințe opționale - Due June 12, 2025 10:59 PM --
------------------------------------------------------------------------------

------------
-- TABELE --
------------

-- TRUPA (#id_trupa, nume, an_debut, id_utilizator) 
-- PREMIU (#id_premiu, loc_podium) 
-- COMPETITIE (#id_competitie, nume, locatie) 
-- TRUPA_PREMIU_COMPETITIE (id_trupa, id_premiu, id_competitie)
-- LISTA (#id_lista, id_cantare, id_utilizator, nume, data_programare, locatie_programare) 
-- BISERICA (#id_biserica, nume) 
-- COR (#id_cor, id_biserica, numar_membrii, id_utilizator) 
-- UTILIZATOR (#id_utilizator, id_trupa, id_lista, id_cor, nume) 
-- VOCALIST (#id_utilizator, rol) 
-- INSTRUMENTIST (#id_utilizator) 
-- INSTRUMENT (id_instrumentist, denumire) 
-- CANTARE (#id_cantare, id_autor, id_lista, id_categorie, nume, gama, bpm) 
-- AUTOR (#id_autor, id_cantare, nume, an_debut) 
-- CATEGORIE (id_cantare, denumire) 

SELECT * FROM TRUPA; -- ID CUPRINS IN [1-10]
SELECT * FROM PREMIU; -- ID CUPRINS IN [11-20]
SELECT * FROM COMPETITIE; -- ID CUPRINS IN [21-30]
SELECT * FROM TRUPA_PREMIU_COMPETITIE; 
SELECT * FROM LISTA; -- ID CUPRINS IN [31-40]
SELECT * FROM BISERICA; -- ID CUPRINS IN [41-50]
SELECT * FROM COR; -- ID CUPRINS IN [51-60]
SELECT * FROM UTILIZATOR; -- ID CUPRINS IN [61-70]
SELECT * FROM VOCALIST; 
SELECT * FROM INSTRUMENTIST; 
SELECT * FROM INSTRUMENT; 
SELECT * FROM CANTARE; -- ID CUPRINS IN [71-80]
SELECT * FROM AUTOR; -- ID CUPRINS IN [81-90]
SELECT * FROM CATEGORIE; 

-------------
-- CERINTE --
-------------

------------------------------------------------------------------------------------------------------------------------
-- 12. Formulați în limbaj natural și implementați 5 cereri SQL complexe ce vor utiliza, în ansamblul lor, următoarele elemente: 
-- (a) Subcereri sincronizate în care intervin cel puțin 3 tabele; 
-- (b) Subcereri nesincronizate în clauza FROM; 
-- (c) Grupări de date, funcții grup, filtrare la nivel de grupuri cu subcereri nesincronizate (în clauza de HAVING); 
-- (d) Ordonări și utilizarea funcțiilor NVL și DECODE (în cadrul aceleiași cereri); 
-- (e) Utilizarea a cel puțin 2 funcții pe șiruri de caractere, 2 funcții pe date calendaristice, a cel puțin unei expresii CASE; 
-- (f) Utilizarea a cel puțin 1 bloc de cerere (clauza WITH); 
-- (Observație: Într-o cerere se vor regăsi mai multe elemente dintre cele enumerate mai sus, astfel încât cele 5 cereri să le cuprindă pe toate.)
------------------------------------------------------------------------------------------------------------------------

-- (a) Subcereri sincronizate în care intervin cel puțin 3 tabele
-- Cerinta: Sa se afiseze numele fiecarui utilizator, impreuna cu numele listei si numele cantarii din categoria pop, rock sau jazz. Se va ordona dupa ordinea alfabetica a numelor utilizatorilor, precum si a cantarior, acestea din urma, cantarile, vor fi ordonate in ordine inversa. Daca o cantare apartine mai multor categorii, se va afisa de cate ori este nevoie pentru a fi afisata fiecare categorie!
SELECT U.NUME AS "UTILIZATOR", L.NUME AS "LISTA", C.NUME AS "CANTARE", CATEGORIE.DENUMIRE AS "CATEGORIE"
FROM UTILIZATOR U
JOIN LISTA L ON L.ID_LISTA = U.ID_LISTA
JOIN CANTARE C ON C.ID_LISTA = L.ID_LISTA
JOIN CATEGORIE ON CATEGORIE.ID_CANTARE = C.ID_CANTARE
WHERE C.ID_CANTARE IN (
	SELECT ID_CANTARE
	FROM CATEGORIE
	WHERE UPPER(DENUMIRE) = 'POP' OR UPPER(DENUMIRE) = 'ROCK' OR UPPER(DENUMIRE) = 'JAZZ'
)
ORDER BY U.NUME ASC, C.NUME DESC;

-- (b) Subcereri nesincronizate în clauza FROM
-- Cerinta: Sa se afiseze numele, anul de debut si vechimea fiecarui autor a unei cantari care are BPM mai mic strict decat 100. Se vor afisa doar acei autori care au o vechime strict mai mare decat 10, in ordine descrescatoare a vechimii. 
SELECT A.NUME, A.AN_DEBUT, EXTRACT(YEAR FROM SYSDATE) - A.AN_DEBUT AS "VECHIME"
FROM (
	SELECT * FROM AUTOR
) A JOIN CANTARE C ON C.ID_CANTARE = A.ID_CANTARE
WHERE C.BPM < 100 AND  EXTRACT(YEAR FROM SYSDATE) - A.AN_DEBUT > 10
ORDER BY A.AN_DEBUT ASC;

-- (c) Grupări de date, funcții grup, filtrare la nivel de grupuri cu subcereri nesincronizate (în clauza de HAVING)
-- Cerinta: Sa se afiseze id-ul, numele si tipul fiecarui utilizator a carui lista contine maximul numarului de cantari dintre toate listele. De asemenea, se va afisa id-ul si numarul de cantari ale acestei liste. In plus, se va ordona descrescator dupa id-ul listei si crescator dupa id-ul utilizatorului.
SELECT U.ID_UTILIZATOR AS "ID UTILIZATOR", U.NUME AS "NUME UTILIZATOR", C.ID_LISTA AS "ID LISTA", COUNT(*) AS "TOTAL CANTARI"
FROM UTILIZATOR U
JOIN LISTA L ON L.ID_LISTA = U.ID_LISTA
JOIN CANTARE C ON C.ID_LISTA = L.ID_LISTA
GROUP BY U.ID_UTILIZATOR, U.NUME, C.ID_LISTA
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*) 
	FROM CANTARE 
	GROUP BY ID_LISTA
)
ORDER BY C.ID_LISTA DESC, U.ID_UTILIZATOR ASC;

-- (d) Ordonări și utilizarea funcțiilor NVL și DECODE (în cadrul aceleiași cereri)
-- Cerinta: Sa se afiseze numele, daca este vocalist DA, daca nu este vocalist NU, rolul si trupa utilizatorilor care sunt intr-un cor cu id-ul cuprins intre 52 si 58. Daca utilizatorul nu este vocalist atunci se va scrie NECUNOSCUT in drepul coloanei rol vocalist. In dreptul coloanei trupa, daca utilizatorul este in trupa cu id-ul 1 se va scrie NOT AN IDOL, daca este in trupa cu id-ul 4 se va scrie CRISTOCENTRIC, altfel se va scrie ALTA, intrucat presupunem ca nu cunoastem id-ul celorlalte trupe. Rezultatul va fi ordonat in ordine alfabetica a numelor si a rolurilor.
SELECT DISTINCT U.NUME, CASE WHEN V.ID_UTILIZATOR IS NOT NULL THEN 'DA' ELSE 'NU' END AS "E VOCALIST", NVL(V.ROL, 'NECUNOSCUT') AS "ROL VOCALIST", DECODE(U.ID_TRUPA, 1, 'NOT AN IDOL', 4, 'CRISTOCENTRIC', 'ALTA') AS "TRUPA"
FROM UTILIZATOR U
LEFT JOIN VOCALIST V ON V.ID_UTILIZATOR = U.ID_UTILIZATOR
WHERE U.ID_COR BETWEEN 52 AND 58
ORDER BY U.NUME, NVL(V.ROL, 'NECUNOSCUT');

-- (e) Utilizarea a cel puțin 2 funcții pe șiruri de caractere, 2 funcții pe date calendaristice, a cel puțin unei expresii CASE & (f) Utilizarea a cel puțin 1 bloc de cerere (clauza WITH)
-- Cerinta: Sa se afiseze numele autorului, numele cantarii, anul de debut al autorului, precum si statutul autorului anume ca daca are anul de debut mai mic strict decat 2005 atunci este veteran altfel este nou. In plus, se vor alege primii 5 autori, ordonati in ordine crescatoare dupa anul de debut.
WITH TOP_AUTORI AS (
	SELECT A.NUME AS NUME_AUTOR, A.AN_DEBUT, C.NUME AS NUME_CANTARE
	FROM AUTOR A
	JOIN CANTARE C ON C.ID_CANTARE = A.ID_CANTARE
) SELECT INITCAP(NUME_AUTOR) AS "AUTOR", UPPER(NUME_CANTARE) AS "CANTARE", EXTRACT(YEAR FROM TO_DATE(AN_DEBUT, 'YYYY')) AS AN_DEBUT, CASE WHEN AN_DEBUT < 2005 THEN 'VETERAN' ELSE 'NOU' END AS "STATUT"
FROM TOP_AUTORI
ORDER BY AN_DEBUT ASC
FETCH FIRST 5 ROWS ONLY;

------------------------------------------------------------------------------------------------------------------------
-- 13. Implementarea a 3 operații de actualizare și de suprimare a datelor utilizând subcereri. 
------------------------------------------------------------------------------------------------------------------------

-- (a) Schimba locatia unei liste unde sunt mai mult de 3 cântări
-- In acest caz, modificam locatia programarii pentru lista cu id-ul 31, respectiv 34. Asta se intampla, deoarece aceste doua liste contin mai mult strict decat o singura cantare.
-- ID_CANTARE | ID_LISTA | contor
-- 71 			    31         a1
-- 72 			    37
-- 73 			    34				 b1
-- 74 			    32
-- 75 			    39
-- 76 			    31				 a2
-- 77 			    36
-- 78 			    33
-- 79 			    34				 b2
-- 80 			    40
UPDATE LISTA
SET LOCATIE_PROGRAMARE = 'BUCURESTI'
WHERE ID_LISTA IN (
	SELECT ID_LISTA
	FROM CANTARE
	GROUP BY ID_LISTA
	HAVING COUNT(*) > 1
);

-- (b) Sterge categoria rock pentru fiecare cantare
DELETE FROM CATEGORIE
WHERE UPPER(CATEGORIE.DENUMIRE) = 'ROCK';
-- BONUS: Adauga inapoi categoria rock. Metoda de mai jos nu functioneaza daca am sters mai inainte categoria. Cu update pot doar modifica. Daca vreau sa le adaug inapoi, trebuie sa le inserez din nou cu insert into.
-- UPDATE CATEGORIE
-- SET CATEGORIE.DENUMIRE = 'ROCK'
-- WHERE CATEGORIE.ID_CANTARE IN (72, 75);
INSERT INTO CATEGORIE(ID_CANTARE, DENUMIRE) VALUES (72, 'ROCK');
INSERT INTO CATEGORIE(ID_CANTARE, DENUMIRE) VALUES (75, 'ROCK');

-- (c) Modifica gama in C si bpm in 80 pentru fiecare cantare care are bpm mai mic strict decat media aritmetica a bpm-ului tuturor cantarilor
UPDATE CANTARE
SET GAMA = 'C', BPM = 80
WHERE BPM < (
	SELECT AVG(BPM) FROM CANTARE
);
-- Revino la tabelul initial (cel din documentul word)
UPDATE CANTARE
SET GAMA = 'C', BPM = 70
WHERE ID_CANTARE = 72;
UPDATE CANTARE
SET GAMA = 'D#', BPM = 90
WHERE ID_CANTARE = 76;
UPDATE CANTARE
SET GAMA = 'A#', BPM = 50
WHERE ID_CANTARE = 77;
UPDATE CANTARE
SET GAMA = 'C', BPM = 70
WHERE ID_CANTARE = 78;
UPDATE CANTARE
SET GAMA = 'E', BPM = 90
WHERE ID_CANTARE = 79;
UPDATE CANTARE
SET GAMA = 'A#', BPM = 40
WHERE ID_CANTARE = 80;

------------------------------------------------------------------------------------------------------------------------
-- 14. Crearea unei vizualizări complexe. Dați un exemplu de operație LMD permisă pe vizualizarea respectivă și un exemplu de operație LMD nepermisă. 
------------------------------------------------------------------------------------------------------------------------

-- (a) O vizualizare complexa
-- In limbaj natural, se afiseaza numele de utilizator, trupa, corul bisericii si numarul de membrii ai acesteia
CREATE OR REPLACE VIEW V_UTILIZATOR_TRUPA_COR AS
SELECT U.NUME AS "UTILIZATOR", T.NUME AS "TRUPA", B.NUME AS "CORUL BISERICII", C.NUMAR_MEMBRII AS "NUMAR MEMBRII"
FROM UTILIZATOR U
JOIN TRUPA T ON T.ID_TRUPA = U.ID_TRUPA
JOIN COR C ON C.ID_COR = U.ID_COR
JOIN BISERICA B ON B.ID_BISERICA = C.ID_BISERICA;

-- (b) Un exemplu de operatie LMD permisa (Explicatie: Vizualizarea contine un singur tabel fiind posibila inserarea datelor)
-- Pentru vizualizarea V_TRUPE
CREATE OR REPLACE VIEW V_TRUPE AS SELECT * FROM TRUPA;
-- Inseram o trupa temporara cu id-ul 101 si anul de debut 1998
INSERT INTO V_TRUPE VALUES (101, 'TRUPA TEMPORARA', 1998);
-- Mai jos putem sterge linia adaugata
DELETE FROM V_TRUPE WHERE ID_TRUPA = 101;

-- (c) Un exemplu de operatie LMD nepermisa
-- In limbaj natural se vrea inserarea unui utilizator cu trupa, cor si numar de membrii in vizualizarea V_UTILIZATOR_TRUPA_COR, insa acest lucru nu este posibil, intrucat vizualizarea respectiva implica join pe patru tabele si nu este clar unde sa fie inserate datele
INSERT INTO V_UTILIZATOR_TRUPA_COR VALUES ("IOAN TUDOR", "ELEVATION WORSHIP", "MARANATHA, CHICAGO", 20000);

------------------------------------------------------------------------------------------------------------------------
-- 15. Formulați în limbaj natural și implementați în SQL: (a) o cerere ce utilizează operația outerjoin pe minimum 4 tabele, (b) o cerere ce utilizează operația division și (c) o cerere care implementează analiza top-n. (Observație: Cele 3 cereri sunt diferite de cererile de la exercițiul 12.)
------------------------------------------------------------------------------------------------------------------------

-- (a) O cerere ce utilizeaza operatie outer join pe minimum 4 tabele
-- Cerinta: Sa se afiseze id-ul, numele, rolul, instrumentul si trupa fiecarui utilizator in ordine crescatoare dupa id-ul utilizatorului. Daca utilizatorul nu canta la vreun instrument se va scrie in dreptul coloanei instrument DOAR VOCALIST. Daca utilizatorul nu e vocalist se va scrie in dreptul coloanei rol DOAR INSTRUMENTIST. Se vor pastra toti utilizatorii chiar daca au sau nu un rol, instrument, trupa.
SELECT DISTINCT U.ID_UTILIZATOR as "ID", U.NUME AS UTILIZATOR, NVL(V.ROL, 'DOAR INSTRUMENTIST') AS ROL, NVL(I.DENUMIRE, 'DOAR VOCALIST') AS INSTRUMENT, T.NUME AS TRUPA
FROM UTILIZATOR U
LEFT OUTER JOIN VOCALIST V ON V.ID_UTILIZATOR = U.ID_UTILIZATOR
LEFT OUTER JOIN INSTRUMENTIST II ON II.ID_UTILIZATOR = U.ID_UTILIZATOR
LEFT OUTER JOIN INSTRUMENT I ON I.ID_UTILIZATOR = II.ID_UTILIZATOR
LEFT OUTER JOIN TRUPA T ON T.ID_TRUPA = U.ID_TRUPA
ORDER BY U.ID_UTILIZATOR ASC;

-- (b) O cerere ce utilizeaza operatia division
-- Cerinta: Sa se afiseze id-ul si numele tuturor utilizatorilor care au cantari in lista cu id-ul 31.
SELECT U1.ID_UTILIZATOR, U1.NUME
FROM UTILIZATOR U1
WHERE NOT EXISTS (
	SELECT ID_LISTA
	FROM LISTA
	WHERE ID_LISTA = 31
	MINUS
	SELECT C.ID_LISTA
	FROM CANTARE C
	JOIN UTILIZATOR U2 ON U2.ID_LISTA = C.ID_LISTA
	WHERE U2.ID_UTILIZATOR = U1.ID_UTILIZATOR
);

-- (c) O cerere care implementeaza analiza top n
-- Cerinta: Sa se afiseze numele, gama si bpm-ul a top trei cantari care au bpm-ul cel mai mare
-- Cu where rownum <= n:
SELECT NUME, GAMA, BPM
FROM (
	SELECT *
	FROM CANTARE
	ORDER BY BPM DESC
) WHERE ROWNUM <= 3;
-- Cu fetch first n rows only:
SELECT NUME, GAMA, BPM
FROM CANTARE
ORDER BY BPM DESC
FETCH FIRST 3 ROWS ONLY;

------------------------------------------------------------------------------------------------------------------------
-- 16. La alegere: 
-- (a) Optimizarea unei cereri, aplicând regulile de optimizare ce derivă din proprietățile operatorilor algebrei relaționale. Cererea va fi exprimată prin expresie algebrică, arbore algebric și limbaj (SQL), atât anterior cât și ulterior optimizării; 
-- (b) Prezentarea planului de execuție a unei cereri complexe, optimizare/compare plan alternativ folosind hint-uri și obiecte specifice optimizării cererilor (spre exemplu indecsi).  
------------------------------------------------------------------------------------------------------------------------

-- (b) Prezentarea planului de execuție a unei cereri complexe, optimizare/compare plan alternativ folosind hint-uri și obiecte specifice optimizării cererilor (spre exemplu indecsi)

-- Exemplu de o cerere complexa
-- In limbaj natural: Afisati numele utilizatorului, a cantarii, precum si bpm-ul cantarii fiecarui utilizator, unde fiecare cantare are bpm-ul mai mare stric decat 90. Rezultatul va fi ordonat descrescator dupa bpm-ul cantarii.
SELECT U.NUME, C.NUME AS CANTARE, C.BPM
FROM UTILIZATOR U
JOIN LISTA L ON L.ID_LISTA = U.ID_LISTA
JOIN CANTARE C ON C.ID_LISTA = L.ID_LISTA
WHERE C.BPM > 90
ORDER BY C.BPM DESC;

-- Explicarea planului de executie
EXPLAIN PLAN FOR
SELECT U.NUME, C.NUME AS CANTARE, C.BPM
FROM UTILIZATOR U
JOIN LISTA L ON L.ID_LISTA = U.ID_LISTA
JOIN CANTARE C ON C.ID_LISTA = L.ID_LISTA
WHERE C.BPM > 90
ORDER BY C.BPM DESC;

-- Afisarea (selectarea) planului de executie
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Creearea unui index
DROP INDEX INDEX_BPM;
CREATE INDEX INDEX_BPM ON CANTARE(BPM);

-- Refacerea interogarii cu hint (fortam folosirea indexului creat prin hintul /* + ... */)
SELECT /* + INDEX(C INDEX_BPM) */ U.NUME, C.NUME AS CANTARE, C.BPM 
FROM UTILIZATOR U
JOIN LISTA L ON L.ID_LISTA = U.ID_LISTA
JOIN CANTARE C ON C.ID_LISTA = L.ID_LISTA
WHERE C.BPM > 90
ORDER BY C.BPM DESC;

-- Explicarea planului de executie
EXPLAIN PLAN FOR
SELECT U.NUME, C.NUME AS CANTARE, C.BPM
FROM UTILIZATOR U
JOIN LISTA L ON L.ID_LISTA = U.ID_LISTA
JOIN CANTARE C ON C.ID_LISTA = L.ID_LISTA
WHERE C.BPM > 90
ORDER BY C.BPM DESC;

-- Afisarea (selectarea) planului de executie
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

------------------------------------------------------------------------------------------------------------------------
-- 17. Realizarea normalizării BCNF, FN4, FN5. Aplicarea denormalizării, justificând necesitatea acesteia.  
------------------------------------------------------------------------------------------------------------------------

-- Tabelul CATEGORIE(id_cantare, denumire) se afla deja in BCNF, FN4 si FN5
-- Denormalizarea este justificata prin performanta in interogari, evitand join-ul
-- Dupa aplicarea denormalizării, tabelul arata in modul urmator
-- CANTARE_DENORMALIZAT(id_cantare, nume, gama, bpm, autor, categorie, id_lista)

------------------------------------------------------------------------------------------------------------------------
-- 18. Exemplificarea isolation levels prin exemple de tranzacții care se execută în paralel în condiții de concurență, evidențiind efectele diferitelor niveluri de izolare asupra concurenței și integrității datelor. 
------------------------------------------------------------------------------------------------------------------------

-- Prima tranzactie 
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED; -- tranzactia poate vedea doar datele confirmate (committed)
-- BEGIN;
-- SELECT * FROM cantare WHERE id_cantare = 71; -- nu vede ce modifica a doua tranzactie daca aceasta nu face commit
-- COMMIT;

-- A doua tranzactie
-- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- tranzactia poate vedea si datele neconfirmate (uncommitted)
-- BEGIN:
-- UPDATE cantare SET bpm = 150 WHERE id_cantare = 71; -- modifica bpm in 150 fara a da commit inca
-- ROLLBACK; -- anuleaza modificarea, bpm revenind la valoarea initiala

------------------------------------------------------------------------------------------------------------------------
-- 19. Justificarea necesități/utilității migrării la o bază de date de tip NoSql. Identificarea scenariilor în care utilizarea unei baze de date NoSQL este mai avantajoasă decât a unei baze de date relaționale. 
-- (a) Prezentarea structurii baze de date de tip NoSql. 
-- (b) Prezentarea comenzilor pentru crearea bazei de date (spre exemplu a colecțiilor într-o bază de date de tip document) 
-- (c) Prezentarea comenzilor pentru inserarea, modificarea și ștergerea documentelor sau înregistrărilor într-o bază de date NoSQL. 
-- (d) Exemplificarea comenzilor pentru interogarea datelor, incluzând operațiuni de filtrare și sortare. 
------------------------------------------------------------------------------------------------------------------------

-- (a) Prezentarea structurii baze de date de tip NoSql
-- Structura unei baze de date de tip NoSql este flexibila in sensul ca nu mai trebuie ca toate randurile dintr-un tabel sa aiba aceleasi coloane.
-- ```JS
-- {
-- 	"_id": ObjectId,
-- 	"nume": "DOMNUL MINUNILOR",
-- 	"gama": "G#",
-- 	"bpm": 120,
-- 	"autori": ["Sunny Tranca", "Miriam Popescu"],
-- 	"categorii": ["Jazz", "Bisericeasca", "Pop"]
-- }
-- ```

-- (b) Prezentarea comenzilor pentru crearea bazei de date
-- ```JS
-- use liste_cantari; /// selecteaza sau creeaza baza de date daca nu exista
-- db.createCollection("cantari"); 
-- ```

-- (c) Prezentarea comenzilor pentru inserarea, modificarea și ștergerea documentelor sau înregistrărilor
-- ```JS
-- db.cantari.insertOne({ nume: "NOI", gama: "D", bpm: 100 }); /// inserare
-- db.cantari.updateOne({ nume: "NOI" }, { $set: { bpm: 110 } }); /// modificare
-- db.cantari.deleteOne({ nume: "NOI" }); /// stergere
-- ```

-- (d) Exemplificarea comenzilor pentru interogarea datelor, incluzând operațiuni de filtrare și sortare
-- ```JS
-- db.cantari.find({ categorii: "Rock" }); /// catarile filtrate dupa categoria rock
-- db.cantari.find({ bpm: { $gt: 90 } }).sort({ bpm: -1 }); /// cantarile cu bpm > 90 sortate descrescator
-- ```

------------------------------------------------------------------------------------------------------------------------
-- 20. Cerință rezervată (flexibilă) pentru alte concepte studiate relevant pentru dezvoltarea aplicațiilor cu suport pentru baze de date.
------------------------------------------------------------------------------------------------------------------------

-- Functie de validare (returneaza 1 daca bpm este in [40, 200] si 0 in caz contrar)
CREATE OR REPLACE FUNCTION VALIDARE_BPM(p_bpm NUMBER)
RETURN NUMBER IS
BEGIN
  IF p_bpm < 40 OR p_bpm > 200 THEN
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END; 
/ 
-- `/` pentru a compila cu succes si a nu primi 'ORA-24344: A compilation error occurred while creating an object.'

-- Tabel pentru audit
DROP TABLE AUDIT_CANTARE;
CREATE TABLE AUDIT_CANTARE (
  ID_LOG NUMBER GENERATED ALWAYS AS IDENTITY,
  ID_CANTARE NUMBER,
  DATA_ACTIUNE DATE,
  TIP_ACTIUNE VARCHAR(10),
  UTILIZATOR VARCHAR(44)
);

-- Trigger de audit si validare
CREATE OR REPLACE TRIGGER TRIGGER_CANTARE_AUDIT
BEFORE INSERT OR UPDATE ON CANTARE
FOR EACH ROW
DECLARE
  tip_actiune VARCHAR2(10);
BEGIN
  -- validare BPM
  IF VALIDARE_BPM(:NEW.BPM) = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'BPM INVALID. Trebuie sa fie intre 40 si 200.');
  END IF;

  -- determinare tip acțiune
  IF INSERTING THEN
    tip_actiune := 'INSERT';
  ELSIF UPDATING THEN
    tip_actiune := 'UPDATE';
  END IF;

  -- logare in audit
  INSERT INTO AUDIT_CANTARE(ID_CANTARE, DATA_ACTIUNE, TIP_ACTIUNE, UTILIZATOR)
  VALUES (
    :NEW.ID_CANTARE,
    SYSDATE,
    tip_actiune,
    USER
  );
END;
/

-- Testarea functiei de validare
SELECT VALIDARE_BPM(210) FROM DUAL;

-- Inserarea unei cantari cu bpm < 40
INSERT INTO CANTARE (ID_CANTARE, NUME, GAMA, BPM, ID_LISTA)
VALUES (101, 'TEST CANTARE', 'A', 25, 32);

-- Inserarea unei cantari cu bpm > 200
INSERT INTO CANTARE (ID_CANTARE, NUME, GAMA, BPM, ID_LISTA)
VALUES (101, 'TEST CANTARE', 'A', 220, 32);

-- Inserarea unei cantari cu bpm in [40, 200]
INSERT INTO CANTARE (ID_CANTARE, NUME, GAMA, BPM, ID_LISTA)
VALUES (101, 'TEST CANTARE', 'A', 88, 32);

-- Afisarea tabelului CANTARE
SELECT * FROM CANTARE;

-- Afisarea tabelului AUDIT_CANTARE
SELECT ID_LOG, ID_CANTARE, TO_CHAR(DATA_ACTIUNE, 'YYYY-MM-DD, HH24:MM:SS'), TIP_ACTIUNE, UTILIZATOR
FROM AUDIT_CANTARE;

-- Stergerea cantarii cu id-ul 101
DELETE FROM CANTARE WHERE ID_CANTARE = 101;

------------------------------------------
-- ASIDE: INTELEGE MODELUL DE REZOLVARE --
------------------------------------------

-- Se da:
-- OBIECTIV_TURISTIC(#id_obiectiv, nume, descriere, adresa, oras, tip_obiectiv)
-- PARC(#id_obiectiv, suprafata, tip_vegetatie, facilitati)
-- MONUMENT(#id_obiectiv, data_constructie, stil_arhitectural, istorie)
-- FOTOGRAFII_OBIECTIV(#id_obiectiv, #id_fotografie, url_fotografie, descriere_fotografie, data_incarcare)
-- UTILIZATOR(#id_utilizator, nume_user, email, parola, data_inregistrare)
-- RATING(#id_utilizator, id_obiectiv, rating, comentariu, data_rating)
-- FAVORITE(#id_utilizator, #id_obiectiv)
-- PROGRAM(#id_program, #id_obiectiv, zi, ora_deschidere, ora_inchidere, tarif)
-- URMARESTE(#id_urmareste, id_utilizator, id_followewd)

-- Se cer:
-- (a) Subcereri sincronizate în care intervin cel puțin 3 tabele 
-- (b) Subcereri nesincronizate în clauza FROM 
-- (c) Grupări de date, funcții grup, filtrare la nivel de grupuri cu subcereri nesincronizate (în clauza de HAVING) 
-- (d) Ordonări și utilizarea funcțiilor NVL și DECODE (în cadrul aceleiași cereri) 
-- (e) Utilizarea a cel puțin 2 funcții pe șiruri de caractere, 2 funcții pe date calendaristice,  a cel puțin unei expresii CASE 
-- (f) Utilizarea a cel puțin 1 bloc de cerere (clauza WITH) 

-- 1. (b), (c) Sa se afiseze obiectivele care au media ratingurilor mai mare decat media tuturor ratingurilor. Pentru fiecare obiectiv se va afisa si numarul de turisti pentru care obiectivul este favorit si media ratingurilor.
SELECT R.ID_OBIECTIV AS "COD OBIECTIV", COUNT(*) AS "NUMAR TURISTI PENTRU CARE OBIECTIVUL ESTE FAVORIT", F.FAVORIT AS "NUMAR FAVORIT", AVG(RATING) AS "MEDIA RATING-URILOR"
FROM RATING R
JOIN (
    SELECT ID_OBIECTIV, COUNT(*) AS "NUMAR FAVORIT"
    FROM FAVORITE
    GROUP BY ID_OBIECTIV
) F ON R.ID_OBIECTIV = F.ID_OBIECTIV
GROUP BY R.ID_OBIECTIV = "NUMAR FAVORIT"
HAVING AVG(RATING) > (
    SELECT AVG(RATING)
    FROM RATING
);

-- 2. (a), (f) Se se afiseze pentru fiecare utilizator obiectivul care are ratingul maxim dat de utilizatori pe care ii urmareste si pe care nu l-a adaugat inca in lista sa de favorite. Angajatii cu sal max in departament
-- select last_name, department_id, salary
-- from employees e
-- where salary = (
--     select max(salary) from employees 
--     where department_id = e.department_id)
-- order by department_id
-- ;
WITH rating_firends as (
    SELECT u.id_utilizator, u.nume_user, o.id_obiectiv, f.id_followed, r.rating
    FROM utilizator u, obiectiv_turistic o, urmareste f, rating r 
    WHERE u.id_utilizator = f.id_utilizator AND r.id_utilizator = f.id_followed AND r.id_obiectiv = o.id_obiectiv AND o.id_obiectiv NOT IN (
        SELECT o.id_obiectiv = favorite.ID_OBIECTIV
        FROM favorite 
        WHERE id_utilizator = u.id_utilizator
    )
)
SELECT id_utilizator, nume_user, id_obiectiv, rating 
FROM rating_firends r
WHERE rating = (
    SELECT MAX(rating) 
    FROM rating_firends 
    WHERE id_utilizator = r.id_utilizator
);

-- 3. (d), (e)
SELECT NVL(comentariu, 'N/A') comentariu,
  CASE 
    WHEN data_rating > to_date('01-01-2024', 'dd-mm-yyyy')
    THEN 'recent'
    WHEN data_rating < to_date ('20-02-2023', 'dd-mm-yyyy')
    THEN 'neactualizat'
    ELSE 'actual' 
   END relevanta,
   s.status_user
FROM rating r JOIN 
    (SELECT id_utilizator, 
     decode ( COUNT(distinct id_obiectiv), nrmax, 'activ',
              nrmax-1 , 'activ', 
              'N/A') status_user
    FROM rating  , (SELECT MAX(COUNT(distinct id_obiectiv)) nrmax
                    FROM rating 
                    GROUP BY id_utilizator)
    GROUP BY id_utilizator, nrmax) s
on r.id_utilizator = s.id_utilizator;
    
-- Sa se actualizeze media ratingurilor pentru toate obiectivele turistice de tip parc astfel incat sa reprezinte media ratingurilor din ultimele 15 luni.
UPDATE obiectiv_turistic o
SET medie_rating = (
    SELECT AVG(rating) 
    FROM rating 
    WHERE id_obiectiv = o.id_obiectiv AND MONTHS_BETWEEN(sysdate, data_rating) <= 15
)
WHERE tip_obiectiv = 'Parc';

-- Sa se stearga din tabela fotografii fotografiile obiectivelor care nu se regăsesc în lista de favorite ale utilizatorilor care au inregistrat cele mai multe ratinguri.
DELETE fotografii_obiectiv f
WHERE NOT EXISTS (
    SELECT 'x' FROM favorite fv 
    WHERE fv.id_obiectiv = f.id_obiectiv AND fv.id_utilizator = ( 
        SELECT id_utilizator  
        FROM rating GROUP BY id_utilizator
        HAVING COUNT(*) = (
            SELECT max(COUNT(*)) nr  
            FROM rating 
            GROUP BY id_utilizator
        )
    )
);
