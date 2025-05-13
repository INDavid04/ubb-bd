--------------
-- La clasa --
--------------

--EXEMPLU FUNCTIE SINGLE-ROW
SELECT
    LENGTH(FIRST_NAME)
FROM EMPLOYEES;

--EXEMPLU FUNCTIE MULTIPLE-ROW
SELECT MAX(SALARY)
FROM EMPLOYEES;

-- DIFERENTA VARCHAR2 - CHAR
    -- CHAR -> stocare siruri de lungime fixa (daca lungimea sirului este mai mica decat lungimea fixata la declarare se vor adauga caractere blank)
    -- VARCHAR -> stocare siruri de lungime variabila

    -- coloana TEST VARCHAR2(10)
    --  'asd' (input) -> 'asd' (cum este salvat in baza de date) - lungime 3
    -- coloana TEST2 CHAR(10)
    --  'asd' (input) -> 'asd       ' (cum este salvat in baza de date; cu 7 blank-uri) - lungime 10

--EXEMPLU CONVERSIE IMPLICITA SIR DE CARACTERE -> NUMBER
SELECT
    '-1' + 2
FROM DUAL;

--EXEMPLU CONVERSIE IMPLICITA SIR DE CARACTERE -> DATE
--FORMATUL SIRULUI DE CARACTERE TREBUIE SA RESPECTE FORMATUL VARIABILEI DE SERVER NLS_DATE_FORMAT
SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN
    '20-02-1990' AND '20-03-2000'; --DA EROARE DEOARECE NLS_DATE_FORMAT = 'DD-MON-RR'

SELECT VALUE
FROM V$NLS_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT'; --QUERY PRIN INTERMEDIUL CARUIA SE POATE VIZUALIZA FORMATUL DATELOR CALENDARISTICE

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY'; --QUERY PRIN INTERMEDIUL CARUIA SE POATE SCHIMBA DOAR LA NIVEL DE SESIUNE FORMATUL

--EXEMPLU CONVERSIE IMPLICITA NUMBER -> SIR DE CARACTERE
SELECT
    2 || 'ASD'
FROM DUAL;

--EXEMPLU CONVERSIE IMPLICITA NUMBER -> SIR DE CARACTERE
SELECT
    SYSDATE || 'ASD'
FROM DUAL;

--------FUNCTII DE CONVERSIE
--EXEMPLU CONVERSIE EXPLICITA DATE -> SIR DE CARACTERE, FOLOSIND FUNCTIA TO_CHAR
--FUNCTIA VA RETURNA SIRUL CONFORM FORMATULUI DESCRIS DIN AL DOILEA PARAMETRU
SELECT
    TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS')
FROM DUAL;

SELECT
    TO_CHAR(SYSDATE, 'DD.MONTH-YYYY HH:MI')
FROM DUAL;

SELECT
    TO_CHAR(SYSDATE) --DEFAULT SE VA CONVERTI FOLOSIND FORMATUL DESCRIS DE VARIABILA DE SISTEM NLS_DATE_FORMAT
FROM DUAL;

--EXEMPLU CONVERSIE EXPLICITA NUMBER -> SIR DE CARACTERE, FOLOSIND FUNCTIA TO_CHAR
SELECT
    TO_CHAR(7) || 'ASD'
FROM DUAL;

SELECT
    TO_CHAR(7.500)
FROM DUAL;

SELECT
    TO_CHAR(7.500, '9.999') --FOLOSIND TO_CHAR PUTEM IMPUNE AFISAREA SUB ANUMITE FORMATE A VALORILOR DE TIP NUMBER
FROM DUAL;

--EXEMPLU CONVERSIE EXPLICITA SIR DE CARACTERE -> NUMBER, FOLOSIND FUNCTIA TO_NUMBER
SELECT
    TO_NUMBER('+123.234', 'S999D999') --ATAT PENTRU PARTEA INTREAGA, CAT SI PENTRU PARTEA ZECIMALA, NUMARUL DE CIFRE DIN SIR TREBUIE SA ACOPERE NUMARUL DE CIFRE DIN FORMAT
FROM DUAL;

SELECT
    TO_NUMBER('+123.234', 'S999D9') --EROARE DEOARECE PARTEA ZECIMALA DIN FORMAT PERMITE DOAR 1 CIFRA, IAR SIRUL PE CARE VREM SA IL CONVERTIM ARE 3 CIFRE PE PARTEA ZECIMALA
FROM DUAL;

SELECT
    TO_NUMBER('123,123.234', '999G999D999')
FROM DUAL;

SELECT
    TO_NUMBER('123,123.234', '999,999.999')
FROM DUAL;

SELECT
    TO_NUMBER('123,123.234', '999G999.999') --IN FORMAT NU PUTEM COMBINA "," CU "D" SI "G" CU "." (TREBUIE SA APARA FIE DOAR "." SI ",", FIE DOAR "G" SI "D")
FROM DUAL;

--------FUNCTII PE SIRURI DE CARACTERE
SELECT
    LENGTH('') --'' ESTE ECHIVALENT CU NULL, NU CU SIRUL CU 0 CARACTERE SI DEOARECE IN ACEST CAZ LENGTH PRIMESTE PE NULL CA SI PARAMETRU, ATUNCI SI REZULTATUL ESTE NULL
FROM DUAL;

--INDEXAREA SIRURILOR DE CARACTERE SE FACE DE LA 1, NU DE LA 0
SELECT
    SUBSTR('Informatica', 5, 2) --SUBSIRUL INCEPAND CU INDEXUL 5 SI SE IAU DOAR PRIMELE 2 CARCATERE
FROM DUAL;

SELECT
    SUBSTR('Informatica', 5) --SUBSIRUL INCEPAND CU INDEXUL 5
FROM DUAL;

SELECT
    SUBSTR('Informatica', -5) --ULTIMELE 5 CARACTERE
FROM DUAL;

SELECT
    SUBSTR('Informatica', -5, 3) --PRIMELE 3 DIN ULTIMELE 5 CARACTERE
FROM DUAL;

SELECT
    LTRIM('QQWQER', 'Q')
FROM DUAL;

SELECT
    LTRIM('    R    QQWQER') --DACA NU SE PRECIZEAZA AL DOILEA PARAMETRU, BY DEFAULT SE STERG BLANK-URILE
FROM DUAL;

SELECT
    TRIM(BOTH 'Q' FROM 'QQWQERQ')
FROM DUAL;

SELECT
    TRIM('QQWQER')
FROM DUAL;

SELECT
    LPAD('QQQ', 6, 'AS')
FROM DUAL;

SELECT
    INSTR('ASDQWQWERT', 'QW', 4, 2)
FROM DUAL;

SELECT
    INSTR('ASDQWQWERT', 'QW', 4, 3) --DACA NU ESTE GASIT UN INDEX CORESPUNZATOR, REZULTATUL FUNCTIEI VA FI 0, NU NULL
FROM DUAL;

SELECT
    REPLACE('QWQ12QW', 'QW', 'AB')
FROM DUAL;

SELECT
    REPLACE('QWQ12QW', 'QW') --NEFIIND PRECIZAT AL TREILEA PARAM, BY DEFAULT SE VA STERGE SUBSIRUL "QW"
FROM DUAL;

SELECT
    TRANSLATE('QWQ12QW', 'QW', 'AB') --SPRE DEOSEBIRE DE REPLACE, TRANSLATE IA CARACTER CU CARACTER SI FACE SCHIMBAREA
FROM DUAL;

SELECT
    TRANSLATE('QWQ12QW', 'QW', 'A') --NEFIIND PRECIZAT UN AL DOILEA CARACTER IN AL TREILEA PARAMETRU, BY DEFAULT SE VA STERGE CARACTERUL "W"
FROM DUAL;

--------FUNCTII ARITMETICE
SELECT
    LEAST(1,2,3)
FROM DUAL;

SELECT
    MOD(7,3)
FROM DUAL;

SELECT
    ROUND(123.65123412, 4)
FROM DUAL;

SELECT
    TRUNC(123.65123412, 4)
FROM DUAL;

SELECT
    ROUND(123.65123412) -- ECHIVALENT CU ROUND(123.65123412, 0)
FROM DUAL;

SELECT
    TRUNC(123.65123412) -- ECHIVALENT CU ROUND(123.65123412, 0)
FROM DUAL;

SELECT
    ROUND(123.65123412, -1)
FROM DUAL;

SELECT
    TRUNC(123.65123412, -1)
FROM DUAL;

--------FUNCTII PE DATE CALENDARISTICE
SELECT
    ROUND(SYSDATE, 'MI') -- YYYY / MM / DD / HH / MI
FROM DUAL;

SELECT
    TRUNC(SYSDATE, 'DD') -- YYYY / MM / DD / HH / MI
FROM DUAL;

SELECT
    SYSDATE - 1 --LA O VARIABILA DE TIP DATE SE POT ADUNA/SCADEA ZILE (DACA VREM SA FACEM OPERATII CU ORE, MINUTE, SECUNDE, TREBUIE SA FACEM CONVERSIA CORESPUNZATOARE LA ZILE)
FROM DUAL;

SELECT
    SYSDATE - 0.5 --IN ACEST EXEMPLU SCADEM 12 ORE
FROM DUAL;

SELECT
    SYSDATE - (SYSDATE - 1) --SE POT SCADEA 2 DATE CALENDARISTICE, CAZ IN CARE REZULTA NUMARUL DE ZILE DINTRE ELE
FROM DUAL;
--REZULTATUL ESTE O VALOARE REALA, DEOARECE SE IAU IN CALCUL SI ORELE, MINUTELE SI SECUNDELE
--DACA PRIMA DATA E MAI MICA DECAT A DOUA, REZULTATUL ESTE UNUL NEGATIV

--------FUNCTII DIVERSE
SELECT
    NVL('A', 1) --NU DA EROARE DEOARECE VALOAREA NUMERICA 1 POATE FI CONVERTITA IMPLICIT LA TIPUL DE DATE SIR DE CARACTERE
FROM DUAL;

SELECT
    NVL(1, 'A') --DA EROARE DEOARECE SIRUL DE CARACTERE 'A' NU POATE FI CONVERTITI IMPLICIT LA UN TIP DE DATE NUMERIC
FROM DUAL;

SELECT
    NVL(1, '2') --NU DA EROARE DEOARECE SIRUL DE CARACTERE '2' POATE FI CONVERTITI IMPLICIT LA UN TIP DE DATE NUMERIC
FROM DUAL;

SELECT
    CASE
        WHEN 1=1 THEN 1
        WHEN 1=1 THEN 2
    END CASE
FROM DUAL; --DACA MAI MULTE CONDITII DIN WHEN SUNT ADEVARATE, ATUNCI SE VA AFISA REZULTATUL PRIMEIA

--IN CAZUL DECODE SI CASE, TIPUL DE DATE AL VARIABILELOR CARE SE AFISEAZA TREBUIE SA FIE ACELASI
SELECT
    CASE
        WHEN 1=1 THEN 1
        WHEN 1=1 THEN 'A'
    END CASE
FROM DUAL; --DA EROARE DEOARECE SIRUL DE CARACTERE 'A' NU POATE FI CONVERTITI IMPLICIT LA UN TIP DE DATE NUMERIC

--ATAT LA DECODE, CAT SI LA CASE, DACA NICIUNA DINTRE CONDITII NU ESTE ADEVARATA SI NICI NU ESTE DEFINITA O VALOARE PENTRU ELSE, ATUNCI REZULTATUL VA FI NULL
SELECT
    CASE
        WHEN 1=2 THEN 1
        WHEN 1=3 THEN 2
    END CASE
FROM DUAL;

SELECT DECODE(1, 2, 1, 3, 1)
FROM DUAL;

-----------------------------------------------
-- Exercitii: Functii pe siruri de caractere --
-----------------------------------------------

-- 1. Scrieţi o cerere care are următorul rezultat pentru fiecare angajat: <prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaţi atât funcţia CONCAT cât şi operatorul “||”.
--<NUME ANGAJAT> CASTIGA <SALARIU>
SELECT
    CONCAT(FIRST_NAME, CONCAT(' CASTIGA ', SALARY))
FROM EMPLOYEES;

SELECT
    FIRST_NAME || ' CASTIGA ' || SALARY
FROM EMPLOYEES;

-- 2. Scrieţi o cerere prin care să se afişeze prenumele salariatului cu prima litera majusculă şi toate celelalte litere minuscule, numele acestuia cu majuscule şi lungimea numelui, pentru angajaţii al căror nume începe cu J sau M sau care au a treia literă din nume A. Rezultatul va fi ordonat descrescător după lungimea numelui. Se vor eticheta coloanele corespunzător. Se cer 2 soluţii (cu operatorul LIKE şi funcţia SUBSTR).
SELECT
    INITCAP(FIRST_NAME),
    UPPER(LAST_NAME),
    LENGTH(LAST_NAME) LG
FROM EMPLOYEES
WHERE
    UPPER(LAST_NAME) LIKE 'J%' OR
    UPPER(LAST_NAME) LIKE 'M%' OR
    UPPER(LAST_NAME) LIKE '__A%'
ORDER BY LG DESC;

SELECT
    INITCAP(FIRST_NAME),
    UPPER(LAST_NAME),
    LENGTH(LAST_NAME) LG
FROM EMPLOYEES
WHERE
    SUBSTR(UPPER(LAST_NAME), 1, 1) IN ('J', 'M')
    OR SUBSTR(UPPER(LAST_NAME), 3, 1) = 'A'
ORDER BY LG DESC;

-- 3. Să se afişeze pentru angajaţii cu prenumele „Steven”, codul, numele şi codul departamentului în care lucrează. Căutarea trebuie să nu fie case-sensitive, iar eventualele blank-uri care preced sau urmează numelui trebuie ignorate.
----LAST_NAME = '   STEvEn   '
SELECT
    EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE UPPER(TRIM(FIRST_NAME)) = 'STEVEN';

-- 4. Să se afişeze pentru toţi angajaţii al căror nume se termină cu litera 'e', codul, numele, lungimea numelui şi poziţia din nume în care apare prima data litera 'a'. Utilizaţi alias-uri corespunzătoare pentru coloane.
SELECT
    EMPLOYEE_ID, FIRST_NAME,
    LENGTH(FIRST_NAME),
    INSTR(UPPER(FIRST_NAME), 'A')
FROM EMPLOYEES
WHERE SUBSTR(UPPER(FIRST_NAME), -1) = 'E';

-----------------------------------
-- Exercitii: Functii aritmetice --
-----------------------------------

-- 5. Să se afişeze detalii despre salariaţii care au lucrat un număr întreg de săptămâni până la data curentă. Este necesară rotunjirea diferentei celor două date calendaristice?
SELECT
    *
FROM EMPLOYEES
WHERE MOD(TRUNC(SYSDATE - HIRE_DATE), 7) = 0;

SELECT
    *
FROM EMPLOYEES
WHERE MOD(TRUNC(SYSDATE) - TRUNC(HIRE_DATE), 7) = 0;

SELECT
    *
FROM EMPLOYEES
WHERE TO_CHAR(SYSDATE, 'D') = TO_CHAR(HIRE_DATE, 'D');

-- 6. Să se afişeze codul salariatului, numele, salariul, salariul mărit cu 15%, exprimat cu două zecimale şi numărul de sute al salariului nou rotunjit la 2 zecimale. Etichetaţi ultimele două coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare salariaţii al căror salariu nu este divizibil cu 1000.
SELECT
    EMPLOYEE_ID, FIRST_NAME, SALARY,
    TO_CHAR(SALARY + SALARY * 15/100,'999999.99') "SALARIU NOU",
    ROUND(SALARY + SALARY * 15/100, 2) "NUMAR SUTE"
FROM EMPLOYEES
WHERE MOD(SALARY, 1000) <> 0;

-- 7. Să se listeze numele, salariul şi o coloana care sa reprezinte nivelul venitului (pentru fiecare 1000 sa fie folosit cate un simbol $). Ex: 6750 -> ‘$$$$$$’
SELECT EMPLOYEE_ID, SALARY,
       TRIM(LPAD(' ', TRUNC(SALARY/1000) + 1,'$'))
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, SALARY,
       LPAD('$', TRUNC(SALARY/1000),'$')
FROM EMPLOYEES;

-----------------------------------------------------------
-- Exercitii: Functii si operatii cu date calendaristice --
-----------------------------------------------------------

-- 8. Să se afişeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.
SELECT
    TO_CHAR(SYSDATE + 30, 'DD-MON-YYYY HH24:MI:SS')
FROM DUAL;

-- 9. Să se afişeze numărul de zile rămase până la sfârşitul anului.
SELECT
    SYSDATE - TO_DATE('01-01-' || TO_CHAR(SYSDATE, 'YYYY'),'DD-MM-YYYY')
FROM DUAL;

-- 10. (a) Să se afişeze data de peste 12 ore. (b) Să se afişeze data de peste 5 minute
SELECT
    SYSDATE + 1/2
FROM DUAL;

SELECT
    SYSDATE + 5/24/60
FROM DUAL;

SELECT
    SYSDATE + INTERVAL '5' MINUTE
FROM DUAL;

-- 11. Să se afişeze numele şi prenumele angajatului (într-o singură coloană), data angajării şi data negocierii salariului, care este prima zi de Luni după 6 luni de serviciu. Etichetaţi această coloană “Negociere”.
SELECT
    FIRST_NAME || ' ' || LAST_NAME,
    HIRE_DATE,
    NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6), 'MONDAY') "NEGOCIERE"
FROM EMPLOYEES;

-- 12. Pentru fiecare angajat să se afişeze numele şi numărul de luni de la data angajării. Etichetaţi coloana “Luni lucrate”. Să se ordoneze rezultatul după numărul de luni lucrate. Se va rotunji numărul de luni la cel mai apropiat număr întreg.
SELECT
    FIRST_NAME,
    MONTHS_BETWEEN(SYSDATE, HIRE_DATE) AS "NUMAR LUNI"
FROM EMPLOYEES
ORDER BY "NUMAR LUNI"; --ALISU-UL POATE FI FOLOSIT PENTRU A ACCESA VALOAREA DE PE COLOANA RESPECTIVA DOAR IN CLAUZA "ORDER BY"

-- 13. Să se afişeze numele, data angajării şi ziua săptămânii în care a început lucrul fiecare salariat. Etichetaţi coloana “Zi”. Ordonaţi rezultatul după ziua săptămânii, începând cu Luni. 
SELECT
    FIRST_NAME, HIRE_DATE,
    TO_CHAR(HIRE_DATE, 'DAY') AS ZI
FROM EMPLOYEES
ORDER BY TO_CHAR(HIRE_DATE, 'D');

-- 14. Sa se afiseze numele şi data angajării pentru fiecare salariat care a fost angajat in 1987. Se cer 2 soluţii: una în care se lucrează cu formatul implicit al datei şi alta prin care se formatează data. Obs: Elementele (câmpuri ale valorilor de tip datetime) care pot fi utilizate în cadrul acestei funcției EXTRACT sunt: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND.
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EXTRACT(YEAR FROM HIRE_DATE) = 1987;

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 1987;

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE) LIKE '%1987%'; --NU AFISEAZA NIMIC DEOARECE CONVERSIA DE FACE IMPLICIT FOLOSIND FORMATUL VARIABILEI DE SERVER 'NLS_DATE_FORMAT', CARE ESTE SUB FORMA 'DD-MON-RR'

-- VARIANTA CORECTA
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%87%';

--------------------------------
-- Exercitii: Functii diverse --
--------------------------------

-- 15. Să se afişeze numele angajaţilor şi comisionul. Dacă un angajat nu câştigă comision, să se scrie “Fara comision”. Etichetaţi coloana “Comision”.
SELECT
    LAST_NAME, COMMISSION_PCT,
    NVL(TO_CHAR(COMMISSION_PCT, '0.999'), 'FARA COMISION')
FROM EMPLOYEES;

SELECT
    LAST_NAME, COMMISSION_PCT,
    CASE
        WHEN COMMISSION_PCT IS NOT NULL THEN TO_CHAR(COMMISSION_PCT, '0.999')
        ELSE 'FARA COMISION'
    END
FROM EMPLOYEES;

-- 16. Să se listeze numele, salariul şi comisionul tuturor angajaţilor al căror venit lunar (salariu + valoare comision) depăşeşte 10000.
SELECT
    FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE SALARY + NVL(COMMISSION_PCT,0) * SALARY > 10000;

SELECT
    FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE SALARY + COMMISSION_PCT * SALARY > 10000 OR SALARY > 10000;

-- 17. Să se afişeze numele, codul job-ului, salariul şi o coloană care să arate salariul după mărire. Se presupune că pentru IT_PROG are loc o mărire de 20%, pentru SA_REP creşterea este de 25%, iar pentru SA_MAN are loc o mărire de 35%. Pentru ceilalti angajati nu se acorda marire.
SELECT
    FIRST_NAME,
    JOB_ID,
    DECODE(UPPER(JOB_ID),'IT_PROG', SALARY * 1.2, 'SA_REP', SALARY * 1.25, 'SA_MAN', SALARY * 1.35, SALARY) "SALARIU NEGOCIAT"
FROM EMPLOYEES;

SELECT
    FIRST_NAME,
    JOB_ID,
    CASE
        WHEN UPPER(JOB_ID) = 'IT_PROG' THEN SALARY * 1.2
        WHEN UPPER(JOB_ID) = 'SA_REP' THEN SALARY * 1.25
        WHEN UPPER(JOB_ID) = 'SA_MAN' THEN SALARY * 1.35
    ELSE SALARY
    END "SALARIU NEGOCIAT"
FROM EMPLOYEES;
