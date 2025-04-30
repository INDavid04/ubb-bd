-- Tema 1: Informatii utile (continutul diagramei)
    -- ARTISTI (id_artist, nume, tip, an_debut)
    -- PREMII (id_premiu, nume_premiu, nume_eveniment)
    -- ALBUME (id_album, id_artist, nume_album, an_lansare)
    -- PREMII_CASTIGATE (id_artist, id_premiu, an_decernare)
    -- TURNEE (id_turneu, id_artist, nume_turneu, data_start, data_incheiere)
    -- CONCERTE (id_concert, id_turneu, id_artist_deschidere, oras, tara, data, venit)

-- 1. Sa se afiseze pentru fiecare artist numele si cate formatii a avut in deschidere (ATENTIE: daca o formatie a cantat de mai multe ori in deschiderea unui artist, atunci se va contoriza o singura data) (0.1p)
SELECT A.NUME, T.ID_TURNEU
FROM ARTISTI A
JOIN TURNEE T ON A.ID_ARTIST = T.ID_ARTIST; -- Nu prea am inteles partea in care se cere "cate formatii a avut in deschidere"

-- 1.2 Sa se afiseze pentru fiecare artist numele si numarul de albume lansate inainte de data ultimului premiu castigat. Se vor lua in considerare doar acei artisti care au sustinut cel putin 3 concerte in anul 2024. (0.1p)
SELECT 
    AR.NUME, 
    COUNT(AL.ID_ALBUM) AS "NUMAR ALBUME"
FROM ARTISTI AR
JOIN ALBUME AL ON AR.ID_ARTIST = AL.ID_ARTIST
JOIN PREMII_CASTIGATE P ON P.ID_ARTIST = AR.ID_ARTIST
GROUP BY AR.NUME
WHERE AL.AN_LANSARE < P.AN_DECERNARE AND COUNT(C.DATA) > 3;

-- 1.3 Sa se afiseze pentru fiecare artist venitul obtinut in anul 2025 la concerte unde au avut in deschidere un artist care a castigat cel putin 3 premii. (0.1p)
SELECT C.VENIT, C.ID_CONCERT
FROM CONCERTE C
JOIN ARTISTI AR ON AR.ID_ARTIST = C.ID_ARTIST_DESCHIDERE
JOIN PREMII_CASTIGATE PC ON PC.ID_ARTIST = AR.ID_ARTIST
WHERE DATA LIKE '%/25' AND COUNT(PC.ID_ARTIST) > 2
GROUP BY AR.ID_ARTIST;

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
JOIN REZERVARI R ON R.ID_CLIENT = C.ID_CLIENT
JOIN PLATI P ON P.ID_REZERVARE = R.ID_REZERVARE
JOIN REVIEWS W ON W.ID_CLIENT = C.ID_CLIENT
WHERE UPPER(P.METODA) = 'CASH' AND W.RATING > 1;

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
