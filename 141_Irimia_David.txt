-------------------------------------------------------------------------------
-- Colocviu Baze de date - Irimia David - Grupa 141 - 06-06-2025 - Numarul 1 --
-------------------------------------------------------------------------------

-- 1. Sa se afiseze pentru fiecare centru de adoptie id-ul, numele, cate animale sterilizate de sex masculin sunt si cate animale vaccinate de sex feminin sunt. Pentru centrele de adoptie unde nu sunt identificate asemenea animale, se va afisa 0.
SELECT CENTRU.ID_CENTRU, CENTRU.NUME, CASE WHEN UPPER(A.SEX) = 'M' THEN (
    SELECT COUNT(STERILIZAT)
    FROM ANIMAL
    WHERE UPPER(STERILIZAT) = 'Y'
) WHEN UPPER(A.SEX) = 'F' THEN (
    SELECT COUNT(VACCINAT)
    FROM ANIMAL
    WHERE UPPER(VACCINAT) = 'Y'
) END AS "NUMAR ANIMALE"
FROM CENTRU_ADOPTIE CENTRU
JOIN ANIMAL A ON A.ID_CENTRU = CENTRU.ID_CENTRU;

-- 2. Sa se afiseze top N centre de adoptie ca numar de animale adoptate din rasa caine, unde N reprezinta numarul de clienti de maxim 23 de ani.
SELECT C1.NUME
FROM (
    SELECT C2.*
    FROM CENTRU_ADOPTIE C2
    JOIN ANIMAL A2 ON A2.ID_CENTRU = C2.ID_CENTRU 
    JOIN RASA R2 ON R2.ID_RASA = A2.ID_RASA
    WHERE UPPER(R2.NUME_SPECIE) = 'CAINE'
) C1 WHERE ROWNUM <= (
    SELECT COUNT(CLIENT.ID_CLIENT)
    FROM CLIENT_CENTRU CLIENT
    WHERE (SYSDATE - CLIENT.DATA_NASTERII) / 365 <= 23
);

-- 3. Sa se afiseze pentru fiecare centru de adoptie care are minim 3 contracte incheiate in 2024, id-ul, numele centrului si numarul de specii de animmale pe care le are.
SELECT C.ID_CENTRU AS "ID CENTRU", C.NUME "NUME CENTRU", COUNT(DISTINCT R.NUME_SPECIE) AS "NUMARUL DE SPECII DE ANIMALE"
FROM CENTRU_ADOPTIE C
JOIN ANIMAL A ON A.ID_CENTRU = C.ID_CENTRU
JOIN RASA R ON R.ID_RASA = A.ID_RASA
JOIN CONTRACT_CENTRU CC ON CC.ID_ANIMAL = A.ID_ANIMAL
WHERE TO_CHAR(CC.DATA_SEMNARII, 'YYYY') = '2024'
GROUP BY C.ID_CENTRU, C.NUME;
