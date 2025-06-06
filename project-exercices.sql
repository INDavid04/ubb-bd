------------------------------------------------------------------------------
-- Proiect final, completări cerințe opționale - Due June 12, 2025 10:59 PM --
------------------------------------------------------------------------------

-- Încărcați: 
-- (a) Un fișier docx care să integreze toate rezolvările cerințelor 1-17; 
-- (b) Un fișier text care să conțină codul SQL pentru cerințele de la punctele 10-11(comenzile de creare a secvenței, a tabelelor și comenzile pentru inserarea datelor în aceste tabele); 
-- (c) Un fișier text care să conțină codul SQL pentru cerințele de la punctele 12-17; 
-- (d) Fișiere pentru subiectele suplimentare 18, 19, 20; 
-- (e) Subliniați modificările față de versiunea precedentă care contribuie la creșterea complexitații proiectului.

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

-- 12. Formulați în limbaj natural și implementați 5 cereri SQL complexe ce vor utiliza, în ansamblul lor, următoarele elemente: 
-- (a) Subcereri sincronizate în care intervin cel puțin 3 tabele; 
-- (b) Subcereri nesincronizate în clauza FROM; 
-- (c) Grupări de date, funcții grup, filtrare la nivel de grupuri cu subcereri nesincronizate (în clauza de HAVING); 
-- (d) Ordonări și utilizarea funcțiilor NVL și DECODE (în cadrul aceleiași cereri); 
-- (e) Utilizarea a cel puțin 2 funcții pe șiruri de caractere, 2 funcții pe date calendaristice, a cel puțin unei expresii CASE; 
-- (f) Utilizarea a cel puțin 1 bloc de cerere (clauza WITH); 
-- (Observație: Într-o cerere se vor regăsi mai multe elemente dintre cele enumerate mai sus, astfel încât cele 5 cereri să le cuprindă pe toate.)

-- 13. Implementarea a 3 operații de actualizare și de suprimare a datelor utilizând subcereri. 

-- 14. Crearea unei vizualizări complexe. Dați un exemplu de operație LMD permisă pe vizualizarea respectivă și un exemplu de operație LMD nepermisă. 

-- 15. Formulați în limbaj natural și implementați în SQL: o cerere ce utilizează operația outerjoin pe minimum 4 tabele, o cerere ce utilizează operația division și o cerere care implementează analiza top-n. Observație: Cele 3 cereri sunt diferite de cererile de la exercițiul 12. 

-- 16. La alegere: 
-- (a) Optimizarea unei cereri, aplicând regulile de optimizare ce derivă din proprietățile operatorilor algebrei relaționale. Cererea va fi exprimată prin expresie algebrică, arbore algebric și limbaj (SQL), atât anterior cât și ulterior optimizării; 
-- (b) Prezentarea planului de execuție a unei cereri complexe, optimizare/compare plan alternativ folosind hint-uri și obiecte specifice optimizării cererilor (spre exemplu indexi).  

-- 17. Realizarea normalizării BCNF, FN4, FN5. Aplicarea denormalizării, justificând necesitatea acesteia.  

-- 18. Exemplificarea isolation levels prin exemple de tranzacții care se execută în paralel în condiții de concurență, evidențiind efectele diferitelor niveluri de izolare asupra concurenței și integrității datelor. 

-- 19. Justificarea necesități/utilității migrării la o bază de date de tip NoSql. Identificarea scenariilor în care utilizarea unei baze de date NoSQL este mai avantajoasă decât a unei baze de date relaționale. 
-- (a) Prezentarea structurii baze de date de tip NoSql. 
-- (b) Prezentarea comenzilor pentru crearea bazei de date (spre exemplu a colecțiilor într-o bază de date de tip document) 
-- (c) Prezentarea comenzilor pentru inserarea, modificarea și ștergerea documentelor sau înregistrărilor într-o bază de date NoSQL. 
-- (d) Exemplificarea comenzilor pentru interogarea datelor, incluzând operațiuni de filtrare și sortare. 

-- 20. Cerință rezervată (flexibilă) pentru alte concepte studiate relevant pentru dezvoltarea aplicațiilor cu suport pentru baze de date.

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
