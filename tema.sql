-- Tema 1: Informatii utile (continutul diagramei)
    -- ARTISTI (id_artist, nume, tip, an_debut)
    -- PREMII (id_premiu, nume_premiu, nume_eveniment)
    -- ALBUME (id_album, id_artist, nume_album, an_lansare)
    -- PREMII_CASTIGATE (id_artist, id_premiu, an_decernare)
    -- TURNEE (id_turneu, id_artist, nume_turneu, data_start, data_incheiere)
    -- CONCERTE (id_concert, id_turneu, id_artist_deschidere, oras, tara, data, venit)

-- 1.1 Sa se afiseze pentru fiecare artist numele si cate formatii a avut in deschidere (ATENTIE: daca o formatie a cantat de mai multe ori in deschiderea unui artist, atunci se va contoriza o singura data) (0.1p)
SELECT A.NUME, COUNT(DISTINCT C.ID_ARTIST_DESCHIDERE) AS "NUMAR FORMATII"
FROM ARTISTI A
JOIN TURNEE T ON T.ID_ARTIST = A.ID_ARTIST
JOIN CONCERTE C ON C.ID_TURNEU = T.ID_TURNEU
GROUP BY A.NUME;

-- TODO 1.2 Sa se afiseze pentru fiecare artist numele si numarul de albume lansate inainte de data ultimului premiu castigat. Se vor lua in considerare doar acei artisti care au sustinut cel putin 3 concerte in anul 2024. (0.1p)
-- Understanding:

SELECT 
    AR.NUME, 
    COUNT(AL.ID_ALBUM) AS "NUMAR ALBUME"
FROM ARTISTI AR
JOIN ALBUME AL ON AR.ID_ARTIST = AL.ID_ARTIST
JOIN (
    SELECT ID_ARTIST, MAX(AN_DECERNARE) AS ULTIMUL_PREMIU
    FROM PREMII_CASTIGATE
    GROUP BY ID_ARTIST
) P ON P.ID_ARTIST = AR.ID_ARTIST
WHERE 
    AL.AN_LANSARE < P.ULTIMUL_PREMIU 
    AND AR.ID_ARTIST IN (
        SELECT T.ID_ARTIST
        FROM CONCERTE C
        JOIN TURNEE T ON C.ID_TURNEU = T.ID_TURNEU
        WHERE EXTRACT(YEAR FROM C.DATA) = 2024
        GROUP BY T.ID_ARTIST
        HAVING COUNT(*) >= 3
    )
GROUP BY AR.NUME;

-- 1.3 Sa se afiseze pentru fiecare artist venitul obtinut in anul 2025 la concerte unde au avut in deschidere un artist care a castigat cel putin 3 premii. (0.1p)
SELECT 
    SUM(C.VENIT) AS "VENIT TOTAL"
FROM CONCERTE C
JOIN TURNEE T ON C.ID_TURNEU = T.ID_TURNEU
WHERE 
    EXTRACT(YEAR FROM C.DATA) = 2025
    AND C.ID_ARTIST_DESCHIDERE IN (
        SELECT P.ID_ARTIST
        FROM PREMII_CASTIGATE P
        GROUP BY P.ID_ARTIST
        HAVING COUNT(P.ID_PREMIU) > 2
    )
GROUP BY T.ID_ARTIST;

-- Aside: Afiseaza artistii care au castigat cel putin trei premii!
SELECT AR.NUME
FROM ARTISTI AR
JOIN PREMII_CASTIGATE P ON P.ID_ARTIST = AR.ID_ARTIST
GROUP BY AR.NUME
HAVING COUNT(P.ID_PREMIU) > 2;

-- Tema 2: Informatii utile (continutul diagramei)
    -- CLIENTI (id_client, nume, email, data_inregistrare)
    -- PROPRIETARI (id_proprietar, nume, email)
    -- PROPRIETATI (id_proprietate, id_proprietar, oras, pret_per_noapte)
    -- REZERVARI (id_rezervare, id_client, id_proprietate, data_check_in, data_check_out, status)
    -- REVIEWS (id_review, id_client, id_proprietate, rating, comentariu)
    -- PLATI (id_plata, id_rezervare, metoda)

-- 2.1 Sa se afiseze pentru fiecare oras numele si numarul de clienti care au avut vizite in orasul respectiv (o vizita este valida daca rezervarea a fost confirmata). (0.1p)
SELECT P.ORAS, COUNT(R.DATA_CHECK_IN) AS "NUMAR CLIENTI"
FROM PROPRIETATI P
JOIN REZERVARI R ON P.ID_PROPRIETATE = R.ID_PROPRIETATE
WHERE UPPER(R.STATUS) = 'CONFIRMATA'
GROUP BY P.ORAS;

-- 2.2 Sa se afiseze clientii (id si nume) care au efectuat exclusiv plati cash si au cel putin 3 review-uri cu rating mai mare sau egal cu 2. (0.1p)
SELECT C.ID_CLIENT, C.NUME
FROM CLIENTI C
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM REZERVARI R 
        JOIN PLATI P ON P.ID_REZERVARE = R.ID_REZERVARE
        WHERE R.ID_CLIENT = C.ID_CLIENT AND UPPER(P.METODA) <> 'CASH'
    )
    AND (
        SELECT COUNT(*) 
        FROM REVIEWS W 
        WHERE W.ID_CLIENT = C.ID_CLIENT AND W.RATING > 1
    ) > 2;

-- 2.3 Sa se afize primii N clienti (id si nume) in functie de totalul cheltuielilor pe rezervari, unde N reprezinta numarul de proprietati care au fost rezervate in 2025 (indiferent daca rezervarea a fost confirmata sau anulata.) (0.1p)
SELECT C.ID_CLIENT, C.NUME, SUM(PRET.PRET_PER_NOAPTE) AS CHELTUIELI
FROM CLIENTI C
JOIN REZERVARI R ON R.ID_CLIENT = C.ID_CLIENT
JOIN PROPRIETATI PRET ON PRET.ID_PROPRIETATE = R.ID_PROPRIETATE
GROUP BY C.ID_CLIENT, C.NUME
ORDER BY CHELTUIELI DESC
FETCH FIRST (
    SELECT COUNT(DISTINCT R2.ID_PROPRIETATE)
    FROM REZERVARI R2
    WHERE EXTRACT(YEAR FROM R2.DATA_CHECK_IN) = 2025
) ROWS ONLY;
