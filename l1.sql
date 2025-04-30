-- NICE: TRY 19 AND 20;

-- 3. Să se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS, JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observând tipurile de date ale coloanelor. Obs: Se va utiliza comanda DESC[RIBE] nume_tabel. 
DESC EMPLOYEES; -- COMANDA NU ESTE RECUNOSCUTA IN DATAGRIP, SE POATE TESTA IN ORACLE SQL DEVELOPER INSA

-- 4. Să se listeze conţinutul tabelelor din schema considerată, afişând valorile tuturor câmpurilor. Obs: SELECT * FROM nume_tabel; 
SELECT * FROM EMPLOYEES; -- * AJUTA LA AFISAREA TUTUROR COLOANELOR TABELULUI/TABELELOR DIN CLAUZA FROM

SELECT *, EMPLOYEE_ID FROM EMPLOYEES; -- EROARE: DACA S-A UTILIZAT * IN CLAUZA SELECT, ATUNCI NU SE POT ADAUGA SI ALTE CAMPURI PARTICULARE IN CLAUZA

-- 5. Să se afişeze codul angajatului, numele, codul job-ului, data angajarii pentru fiecare angajat
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    JOB_ID,
    HIRE_DATE
FROM EMPLOYEES;

-- 6. Să se listeze, cu şi fără duplicate, codurile job-urilor din tabelul EMPLOYEES
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

SELECT UNIQUE JOB_ID
FROM EMPLOYEES;

-- 7. Să se afişeze numele concatenat cu job_id-ul, separate prin virgula si spatiu, si etichetati coloana “Angajat si titlu”. Obs: Operatorul de concatenare este ”||”. Şirurile de caractere se specifică între apostrofuri (NU ghilimele, caz în care ar fi interpretate ca alias-uri).
SELECT
    FIRST_NAME || ', ' || JOB_ID --STRING-URILE SE DEFINESC CU APOSTROF, NU CU GHILIMELE
        -- '' -> ECHIVALENT LUI NULL
        --CU GHILIMELE SE DEFINESC DOAR ALIAS-URILE
FROM EMPLOYEES;

-- 8. Sa se listeze numele si salariul angajaţilor care câştigă mai mult de 2850 $. 
SELECT
    FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 2850;

-- 9. Să se creeze o cerere pentru a afişa numele angajatului şi numărul departamentului pentru angajatul nr. 104. 
SELECT
    FIRST_NAME,
    DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 104;

-- 10. Să se afişeze numele şi salariul pentru toţi angajaţii al căror salariu nu se află în domeniul 1500-2850$. Obs: Pentru testarea apartenenţei la un domeniu de valori se poate utiliza operatorul [NOT] BETWEEN valoare1 AND valoare2. 
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 1500 AND 2850;
-- OPERATORUL BETWEEN ESTE FOLOSIT PENTRU VERIFICAREA APARTENENTEI UNEI VALORI LA UN INTERVAL INCHIS

-- 11. Să se afişeze numele, job-ul şi data la care au început lucrul salariaţii angajaţi între 20 Februarie 1987 şi 1 Mai 1989. Rezultatul va fi ordonat crescător după data de început. 
SELECT FIRST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '20-FEB-1987' AND '01-MAY-1989'; -- EXEMPLU DE CONVERSIE IMPLICITA DIN SIR DE CARACTERE IN DATA CALENDARISTICA

-- 12. Să se afişeze numele salariaţilor şi codul departamentelor pentru toti angajaţii din departamentele 10 şi 30 în ordine alfabetică a numelor. Obs: Apartenenţa la o mulţime finită de valori se poate testa prin intermediul operatorului IN, urmat de lista valorilor între paranteze şi separate prin virgule: expresie IN (valoare_1, valoare_2, …, valoare_n) 
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 30)
ORDER BY FIRST_NAME;
-- OPERATORUL IN ESTE FOLOSIT PENTRU VERIFICAREA APARTENENTEI UNEI VALORI LA O MULTIME

-- 13. Să se listeze numele şi salariile angajatilor care câştigă mai mult de 1500 $ şi lucrează în departamentul 10 sau 30. Se vor eticheta coloanele drept Angajat si Salariu lunar. 
SELECT
    FIRST_NAME AS ANGAJAT,
    SALARY * 12 "SALARIU ANUAL"
FROM EMPLOYEES
WHERE (SALARY >= 1500) AND
        (DEPARTMENT_ID IN (10, 30));

-- 14. Care este data curentă? Afişaţi diferite formate ale acesteia. Obs: Functia care returnează data curentă este SYSDATE. Pentru completarea sintaxei obligatorii a comenzii SELECT, se utilizează tabelul DUAL: Datele calendaristice pot fi formatate cu ajutorul funcţiei TO_CHAR(data, format), unde formatul poate fi alcătuit dintr-o combinaţie a următoarelor elemente:
-- Element - Semnificaţie:
    -- D - Numărul zilei din săptămâna (duminica=1; luni=2; …sâmbătă=6)
    -- DD - Numărul zilei din lună.
    -- DDD - Numărul zilei din an.
    -- DY - Numele zilei din săptămână, printr-o abreviere de 3 litere (MON, THU etc.)
    -- DAY - Numele zilei din săptămână, scris în întregime.
    -- MM - Numărul lunii din an.
    -- MON - Numele lunii din an, printr-o abreviere de 3 litere (JAN, FEB etc.)
    -- MONTH - Numele lunii din an, scris în întregime.
    -- Y - Ultima cifră din an
    -- YY, YYY, YYYY - Ultimele 2, 3, respectiv 4 cifre din an.
    -- YEAR - Anul, scris în litere (ex: two thousand four).
    -- HH12, HH24 - Orele din zi, între 0-12, respectiv 0-24.
    -- MI - Minutele din oră.
    -- SS - Secundele din minut.
    -- SSSSS - Secundele trecute de la miezul nopţii. 
SELECT 
    FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;
--PENTRU A VERIFICA DACA O COLOANA ESTE NULL SAU NU, SE VA FOLOSI IS/IS NOT
-- CONDITIILE MANAGER_ID = NULL SI MANAGER_ID != NULL VOR RETURN 'UNKNOWN', NU 'TRUE'/'FALSE'
-- DACA SE VERIFICA 2 CONDITII, DINTRE CARE UNA IMPLICA 'UNKNOWN', VA REZULTA:
    -- FALSE AND UNKNOWN -> FALSE
    -- FALSE OR UNKNOWN -> UNKNOWN
    -- TRUE OR UNKNOWN -> TRUE
    -- TRUE AND UNKNOWN -> UNKNOWN

-- 15. Sa se afiseze numele şi data angajării pentru fiecare salariat care a fost angajat in 1987. Se cer 2 soluţii: una în care se lucrează cu formatul implicit al datei şi alta prin care se formatează data. 
SELECT
    EMPLOYEE_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT
    EMPLOYEE_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
ORDER BY SALARY DESC, COMMISSION_PCT DESC;
--LA SORTARE DESCRESCATOARE, NULL APARE INAINTEA VALORILOR NUMERICE
--LA SORTARE CRESCATOARE, NULL APARE DUPA VALORILE NUMERICE

-- LIKE ESTE FOLOSIT PENTRU A VERIFICA DACA UN STRING RESPECTA UN ANUMIT PATTERN

-- STRING CU 3 CARACTERE, UNDE AL 3-LEA CARACTER ESTE 'B' (__B)
-- STRING CU CEL PUTIN 3 CARACTERE, UNDE AL 2-LEA CARACTER ESTE 'B' (_B_%)

-- 16. Să se afişeze numele şi job-ul pentru toţi angajaţii care nu au manager. 
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) LIKE '__A%';

-- 17. Sa se afiseze numele, salariul si comisionul pentru toti salariatii care castiga comisioane. Sa se sorteze datele in ordine descrescatoare a salariilor si comisioanelor. Eliminaţi clauza WHERE din cererea anterioară. Unde sunt plasate valorile NULL în ordinea descrescătoare?
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) LIKE '%L%L%' AND
        (DEPARTMENT_ID = 50 OR MANAGER_ID = 102);

-- 18. Să se listeze numele tuturor angajatilor care au a treia literă din nume ‘A’. 
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE UPPER(JOB_ID) LIKE '%CLERK%'
        OR UPPER(JOB_ID) LIKE '%REP%' AND
        (SALARY NOT IN (1000, 2000, 3000));
        
-- 19. Să se listeze numele tuturor angajatilor care au 2 litere ‘L’ in nume şi lucrează în departamentul 50 sau managerul lor este 102. 

-- 20. Să se afiseze numele, job-ul si salariul pentru toti salariatii al caror job conţine şirul “CLERK” sau “REP” și salariul nu este egal cu 1000, 2000 sau 3000. 
    
--CLAUZA OBLIGATORIE CAND SE SCRIE COMANDA SELECT
SELECT
    UPPER(FIRST_NAME) AS NUME_MAJ, --UN ALIAS SE POATE ADAUGA CU SAU FARA UTILIZAREA LUI 'AS'
    EMPLOYEE_ID "Id angajat", --DACA ETICHETA CONTINE CARACTERE 'BLANK', ATUNCI ETICHETA SE TRECE INTRE GHILIMELE
    SALARY * 12 "SALARIU ANUAL"
--CAMPURILE DIN CLAUZA SELECT SE SEPARA PRIN VIRGULA SI POT FI
    -- COLOANE ALE TABELULUI/TABELELOR DIN CLAUZA FROM,
    -- OPERATII APLICATE ASUPRA ANUMITOR COLOANE,
    -- FUNCTII APLICATE ASUPRA ANUMITOR COLOANE
    -- SUBCERERI (COMENZI SELECT IN CLAUZELE ALTOR COMENZI)
FROM EMPLOYEES --CLAUZA OBLIGATORIE CAND SE SCRIE COMANDA SELECT
WHERE SALARY != 10000
    --DACA UN QUERY ARE MAI MULTE CONDITII, NU SE SCRIU MAI MULTE CLAUZE WHERE, CI SE SEPARA CONDITIILE FOLOSIND OPERATORII LOGICI 'AND', 'OR', 'NOT'
    --OPERATORI DE COMPARATIE (=, <> sau !=, <, <=, >, >=)
ORDER BY "SALARIU ANUAL" DESC, HIRE_DATE;
    --PENTRU FIECARE CRITERIU DE SORTARE TREBUIE SPECIFICAT TIPUL DE SORTARE (ASC/DESC)
    --DACA NU SE SPECIFICA CRITERIUL DE SORTARE, BY DEFAULT ESTE ASC

-- EXEMPLU IN CARE FOLOSIM SELECT
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;
--SAU
SELECT EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.FIRST_NAME
FROM EMPLOYEES;
--SAU
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E;
--SAU
SELECT "TABEL ANGAJATI".EMPLOYEE_ID, "TABEL ANGAJATI".FIRST_NAME
FROM EMPLOYEES "TABEL ANGAJATI";

--ETICHETAREA TABELELOR ESTE RECOMANDATA ATUNCI CAND CERERILE SUNT MAI COMPLEXE SI, FIE SE LUCREAZA CU MAI MULTE INSTANTE ALE UNUI ACELUIASI TABEL SI TREBUIE DIFERENTIATE COLOANELE UTILIZATE
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES, EMPLOYEES;
--NU SE STIE DACA COLOANELE DIN SELECT TIN DE PRIMA SAU DE A DOUA INSTANTA A LUI EMPLOYEES
--FIE SE LUCREAZA CU TABELE CARE AU COLOANE CU ACEEASI DENUMIRE
SELECT MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES, DEPARTMENTS; --NU SE STIE DACA COLOANELE DIN SELECT TIN DE TABELUL EMPLOYEES SAU DE TABELUL DEPARTMENTS (CELE 2 COLOANE APAR IN AMBELE TABELE)
