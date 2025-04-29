-- Informatii utile (continutul diagramei)
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

-- 2. Sa se afiseze pentru fiecare artist numele si numarul de albume lansate inainte de data ultimului premiu castigat. Se vor lua in considerare doar acei artisti care au sustinut cel putin 3 concerte in anul 2024. (0.1p)
SELECT 
    AR.NUME, 
    COUNT(AL.ID_ALBUM) AS "NUMAR ALBUME"
FROM ARTISTI AR
JOIN ALBUME AL ON AR.ID_ARTIST = AL.ID_ARTIST
JOIN PREMII_CASTIGATE P ON P.ID_ARTIST = AR.ID_ARTIST
GROUP BY AR.NUME
WHERE AL.AN_LANSARE < P.AN_DECERNARE AND COUNT(C.DATA) > 3;

-- 3. Sa se afiseze pentru fiecare artist venitul obtinut in anul 2025 la concerte unde au avut in deschidere un artist care a castigat cel putin 3 premii. (0.1p)
SELECT C.VENIT, C.ID_CONCERT
FROM CONCERTE C
JOIN ARTISTI AR ON AR.ID_ARTIST = C.ID_ARTIST_DESCHIDERE
JOIN PREMII_CASTIGATE PC ON PC.ID_ARTIST = AR.ID_ARTIST
WHERE DATA LIKE '%/25' AND COUNT(PC.ID_ARTIST) > 2
GROUP BY AR.ID_ARTIST;
