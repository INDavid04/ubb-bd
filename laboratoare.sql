-----------------------
-- Laborator 1 Intro --
-----------------------

SELECT * FROM EMPLOYEES;

-- 3. Sa se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS, JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observand tipurile de date ale coloanelor. Obs: Se va utiliza comanda DESC[RIBE] nume_tabel. 
DESCRIBE EMPLOYEES;
DESCRIBE DEPARTMENTS;
DESCRIBE JOBS;
DESCRIBE JOB_HISTORY;
DESCRIBE LOCATIONS;
DESCRIBE COUNTRIES;
DESCRIBE REGIONS;
DESC REGIONS; -- ECHIVALENT CU `DESCRIBE REGIONS;`

-- 4. Sa se listeze continutul tabelelor din schema considerata, afisand valorile tuturor campurilor. Obs: SELECT * FROM nume_tabel; 
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;
SELECT * FROM JOB_HISTORY;
SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;
SELECT * FROM REGIONS;

-- 5. Să se afişeze codul angajatului, numele, codul job-ului, data angajarii pentru fiecare angajat
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES;

-- 6. Să se listeze, cu şi fără duplicate, codurile job-urilor din tabelul EMPLOYEES
-- CU DUPLICATE
SELECT JOB_ID
FROM EMPLOYEES;
-- FARA DUPLICATE (distinct = unique; se recomanda distinct)
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;
SELECT UNIQUE JOB_ID
FROM EMPLOYEES;

-- 7. Să se afişeze numele concatenat cu job_id-ul, separate prin virgula si spatiu, si etichetati coloana “Angajat si titlu”. Obs: Operatorul de concatenare este ”||”. Şirurile de caractere se specifică între apostrofuri (NU ghilimele, caz în care ar fi interpretate ca alias-uri).
SELECT FIRST_NAME || ', ' || JOB_ID AS "ANGAJAT SI TITLU"
FROM EMPLOYEES;

-- 8. Sa se listeze numele si salariul angajaţilor care câştigă mai mult de 2850 $. 
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 2850;

-- 9. Să se creeze o cerere pentru a afişa numele angajatului şi numărul departamentului pentru angajatul nr. 104. 
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 104;

-- 10. Să se afişeze numele şi salariul pentru toţi angajaţii al căror salariu nu se află în domeniul 1500-2850$. Obs: Pentru testarea apartenenţei la un domeniu de valori se poate utiliza operatorul [NOT] BETWEEN valoare1 AND valoare2. 
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 1500 AND 2850;

-- 11. Să se afişeze numele, job-ul şi data la care au început lucrul salariaţii angajaţi între 20 Februarie 1987 şi 1 Mai 1989. Rezultatul va fi ordonat crescător după data de început. 
SELECT FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '20-FEB-2007' AND '01-MAY-2019'
ORDER BY HIRE_DATE;

-- 12. Să se afişeze numele salariaţilor şi codul departamentelor pentru toti angajaţii din departamentele 10 şi 30 în ordine alfabetică a numelor. Obs: Apartenenţa la o mulţime finită de valori se poate testa prin intermediul operatorului IN, urmat de lista valorilor între paranteze şi separate prin virgule: expresie IN (valoare_1, valoare_2, …, valoare_n) 
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 30)
ORDER BY FIRST_NAME, LAST_NAME;

-- 13. Să se listeze numele şi salariile angajatilor care câştigă mai mult de 1500 $ şi lucrează în departamentul 10 sau 30. Se vor eticheta coloanele drept Angajat si Salariu lunar. 
SELECT FIRST_NAME || ' ' || LAST_NAME AS "ANGAJAT", SALARY AS "SALARIU LUNAR"
FROM EMPLOYEES
WHERE SALARY >= 1500 AND DEPARTMENT_ID IN (10, 30);

-- 14. Care este data curentă? Afişaţi diferite formate ale acesteia. Obs: Functia care returnează data curentă este SYSDATE. Pentru completarea sintaxei obligatorii a comenzii SELECT, se utilizează tabelul DUAL: Datele calendaristice pot fi formatate cu ajutorul funcţiei TO_CHAR(data, format).
SELECT TO_CHAR(SYSDATE, 'D') AS "NUAMRUL ZILEI DIN SAPTAMANA";
SELECT TO_CHAR(SYSDATE, 'DD') AS "NUMARUL ZILEI DIN LUNA";
SELECT TO_CHAR(SYSDATE, 'DDD') AS "NUMARUL ZILEI DIN AN";
SELECT TO_CHAR(SYSDATE, 'DY') AS "NUMELE ZILEI DIN SAPTAMANA SCRIS CU TREI LITERE";
SELECT TO_CHAR(SYSDATE, 'DAY') AS "NUMELE ZILEI DIN SAPTAMANA SCRIS INTEGRAL";
SELECT TO_CHAR(SYSDATE, 'MM') AS "NUMARUL LUNII DIN AN";
SELECT TO_CHAR(SYSDATE, 'MON') AS "PRESCURTAREA LUNII DIN AN";
SELECT TO_CHAR(SYSDATE, 'MONTH') AS "NUMELE LUNII DIN AN";
SELECT TO_CHAR(SYSDATE, 'Y') AS "ULTIMA CIFRA DIN AN";
SELECT TO_CHAR(SYSDATE, 'YY') AS "ULTIMELE DOUA CIFRE DIN AN";
SELECT TO_CHAR(SYSDATE, 'YYY') AS "ULTIMELE TREI CIFRE DIN AN";
SELECT TO_CHAR(SYSDATE, 'YYYY') AS "ULTIMELE PATRU CIFRE DIN AN";
SELECT TO_CHAR(SYSDATE, 'YEAR') AS "ANUL SCRIS IN LITERE";
SELECT TO_CHAR(SYSDATE, 'HH12') AS "ORA DIN ZI IN FORMATUL 0-12";
SELECT TO_CHAR(SYSDATE, 'HH24') AS "ORA DIN ZI IN FORMATUL 0-24";
SELECT TO_CHAR(SYSDATE, 'MI') AS "MINUTELE DIN ORA";
SELECT TO_CHAR(SYSDATE, 'SS') AS "SECUNDELE DIN MINUT";
SELECT TO_CHAR(SYSDATE, 'SSSSS') AS "SECUNDELE TRECUTE DE LA MIEZUL NOPTII";
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') AS "DATA CURENTA";
SELECT TO_CHAR(SYSDATE, 'DD MON, YYYY, HH24:MI:SS') AS "DATA CURENTA";

-- 15. Sa se afiseze numele şi data angajării pentru fiecare salariat care a fost angajat in 1987. Se cer 2 soluţii: una în care se lucrează cu formatul implicit al datei şi alta prin care se formatează data. 
-- CU FORMATAREA DATEI
SELECT FIRST_NAME, LAST_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD, MI:SS') AS "DATA"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2017';
-- CU FORMATUL IMPLICIT AL DATEI NUSH :)

-- 16. Să se afişeze numele şi job-ul pentru toţi angajaţii care nu au manager. 
SELECT FIRST_NAME, LAST_NAME, JOB_ID 
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

-- 17. Sa se afiseze numele, salariul si comisionul pentru toti salariatii care castiga comisioane. Sa se sorteze datele in ordine descrescatoare a salariilor si comisioanelor. Eliminaţi clauza WHERE din cererea anterioară. Unde sunt plasate valorile NULL în ordinea descrescătoare?
-- SALARIATII CARE CASTIGA COMISIOANE 
SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT
FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY, COMMISSION_PCT DESC;
-- SALARIATII CARE NU TREBUIE NEAPARAT SA CASTIGE COMISIOANE 
SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT
FROM EMPLOYEES 
ORDER BY SALARY, COMMISSION_PCT DESC;+

-- 18. Să se listeze numele tuturor angajatilor care au a treia literă din nume ‘A’. 
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) LIKE '__A%';
        
-- 19. Să se listeze numele tuturor angajatilor care au 2 litere ‘L’ in nume şi lucrează în departamentul 50 sau managerul lor este 102. 
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) LIKE '%L%L%' AND (DEPARTMENT_ID = 50 OR MANAGER_ID = 102);

-- 20. Să se afiseze numele, job-ul si salariul pentru toti salariatii al caror job conţine şirul “CLERK” sau “REP” și salariul nu este egal cu 1000, 2000 sau 3000. 
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE (UPPER(JOB_ID) LIKE '%CLERK%' OR UPPER(JOB_ID) LIKE '%REP%') AND (SALARY NOT IN (1000, 2000, 3000));

-------------------------
-- Laborator 2 Functii --
-------------------------

-- 1. Scrieţi o cerere care are următorul rezultat pentru fiecare angajat: <prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaţi atât funcţia CONCAT cât şi operatorul “||”.
-- FOLOSIND CONCAT
SELECT CONCAT(FIRST_NAME, CONCAT(' CASTIGA ', CONCAT(SALARY, CONCAT(' LUNAR DAR DORESTE ', SALARY * 3)))) AS "SALARIU IDEAL"
FROM EMPLOYEES;
-- FOLOSIND ||
SELECT FIRST_NAME || ' CASTIGA ' || SALARY || ' LUNAR DAR DORESTE ' || SALARY * 3 AS "SALARIU IDEAL"
FROM EMPLOYEES;

-- 2. Scrieţi o cerere prin care să se afişeze prenumele salariatului cu prima litera majusculă şi toate celelalte litere minuscule, numele acestuia cu majuscule şi lungimea numelui, pentru angajaţii al căror nume începe cu J sau M sau care au a treia literă din nume A. Rezultatul va fi ordonat descrescător după lungimea numelui. Se vor eticheta coloanele corespunzător. Se cer 2 soluţii (cu operatorul LIKE şi funcţia SUBSTR).
-- CU OPERATORUL LIKE
SELECT INITCAP(FIRST_NAME) AS "PRENUME", UPPER(LAST_NAME) AS "NUME", LENGTH(LAST_NAME) AS "LUNGIMEA NUMELUI"
FROM EMPLOYEES
WHERE UPPER(LAST_NAME) LIKE 'J%' OR UPPER(LAST_NAME) LIKE 'M%' OR UPPER(LAST_NAME) LIKE '__A%'
ORDER BY LENGTH(LAST_NAME) DESC;
-- CU FUNCTIA SUBSTR
SELECT INITCAP(FIRST_NAME) AS "PRENUME", UPPER(LAST_NAME) AS "NUME", LENGTH(LAST_NAME) AS "LUNGIMEA NUMELUI"
FROM EMPLOYEES
WHERE SUBSTR(UPPER(LAST_NAME), 1, 1) IN ('J', 'M') OR SUBSTR(UPPER(LAST_NAME), 3, 1) = 'A'
ORDER BY LENGTH(LAST_NAME) DESC;

-- 3. Să se afişeze pentru angajaţii cu prenumele „Steven”, codul, numele şi codul departamentului în care lucrează. Căutarea trebuie să nu fie case-sensitive, iar eventualele blank-uri care preced sau urmează numelui trebuie ignorate.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE UPPER(TRIM(FIRST_NAME)) LIKE 'STEVEN'; -- TRIM-UL IGNORA SPATIILE ('  STEVEN    ' => 'STEVEN') 

-- 4. Să se afişeze pentru toţi angajaţii al căror nume se termină cu litera 'e', codul, numele, lungimea numelui şi poziţia din nume în care apare prima data litera 'a'. Utilizaţi alias-uri corespunzătoare pentru coloane.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, LENGTH(LAST_NAME) AS "LUNGIMEA NUMELUI", INSTR(UPPER(LAST_NAME), 'A') AS "POZITIA DIN NUME IN CARE APARE PRIMA DATA LITERA A"
FROM EMPLOYEES
WHERE SUBSTR(UPPER(LAST_NAME), -1, 1) = 'E';

-- 5. Să se afişeze detalii despre salariaţii care au lucrat un număr întreg de săptămâni până la data curentă. Este necesară rotunjirea diferentei celor două date calendaristice?
SELECT FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE, UPPER(TO_CHAR(HIRE_DATE, 'DY')) AS "ZIUA DIN SAPTAMANA DIN CARE S-A ANGAJAT"
FROM EMPLOYEES
WHERE UPPER(TO_CHAR(HIRE_DATE, 'DY')) = UPPER(TO_CHAR(SYSDATE, 'DY'));

-- 6. Să se afişeze codul salariatului, numele, salariul, salariul mărit cu 15%, exprimat cu două zecimale şi numărul de sute al salariului nou rotunjit la 2 zecimale. Etichetaţi ultimele două coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare salariaţii al căror salariu nu este divizibil cu 1000.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, TO_CHAR(SALARY + SALARY * 15 / 100, '9999999.99') AS "SALARIU NOU", TO_CHAR(((SALARY + SALARY * 15 / 100) / 100), '9999999') AS "NUMAR SUTE"
FROM EMPLOYEES
WHERE MOD(SALARY, 1000) != 0; -- `!=` OR `<>`

-- 7. Să se listeze numele, salariul şi o coloana care sa reprezinte nivelul venitului (pentru fiecare 1000 sa fie folosit cate un simbol $). Ex: 6750 -> ‘$$$$$$’
SELECT FIRST_NAME, LAST_NAME, SALARY, LPAD('$', TRUNC(SALARY/1000), '$') AS "NIVELUL VENITUTLUI"
FROM EMPLOYEES; -- TRUNC(4.5) = 4 AND ROUND(4.5) = 5

-- 8. Să se afişeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.
SELECT TO_CHAR(SYSDATE + 30, 'MON-DD-YYYY, HH24:SS ') AS "DATA DE PESTE 30 ZILE"
FROM DUAL;

-- 9. Să se afişeze numărul de zile rămase până la sfârşitul anului.
SELECT 365 - TO_CHAR(SYSDATE, 'DDD') AS "NUMARUL DE ZILE PANA LA SFARSITUL ANULUI"
FROM DUAL;

-- 10. (a) Să se afişeze data de peste 12 ore. (b) Să se afişeze data de peste 5 minute
SELECT TO_CHAR(SYSDATE + 0.5, 'YYYYY-MM-DD, HH24:MM:SS') AS "DATA DE PESTE 12 ORE";
FROM DUAL;
SELECT TO_CHAR(SYSDATE + (5*((1/24)/60)), 'YYYY-MM-DD, HH24:MM:SS') AS "DATA DE PESTE 5 MINUTE"; -- 1/24 = O ORA SI 1/24/60 = 1 MINUT

-- 11. Să se afişeze numele şi prenumele angajatului (într-o singură coloană), data angajării şi data negocierii salariului, care este prima zi de Luni după 6 luni de serviciu. Etichetaţi această coloană “Negociere”.
SELECT LAST_NAME || ' ' || FIRST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6), 'MONDAY') AS "DATA NEGOCIERII SALARIULUI"
FROM EMPLOYEES;

-- 12. Pentru fiecare angajat să se afişeze numele şi numărul de luni de la data angajării. Etichetaţi coloana “Luni lucrate”. Să se ordoneze rezultatul după numărul de luni lucrate. Se va rotunji numărul de luni la cel mai apropiat număr întreg.
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, ROUND((ROUND(SYSDATE - HIRE_DATE)) / 30) AS "LUNI LUCRATE"
FROM EMPLOYEES
ORDER BY "LUNI LUCRATE";

-- 13. Să se afişeze numele, data angajării şi ziua săptămânii în care a început lucrul fiecare salariat. Etichetaţi coloana “Zi”. Ordonaţi rezultatul după ziua săptămânii, începând cu Luni. 
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'DAY') AS "ZI"
FROM EMPLOYEES
ORDER BY "ZI";

-- 14. Sa se afiseze numele şi data angajării pentru fiecare salariat care a fost angajat in 1987. Se cer 2 soluţii: una în care se lucrează cu formatul implicit al datei şi alta prin care se formatează data. Obs: Elementele (câmpuri ale valorilor de tip datetime) care pot fi utilizate în cadrul acestei funcției EXTRACT sunt: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND.
-- CU FORMATAREA DATEI
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE UPPER(TO_CHAR(HIRE_DATE, 'YYYY')) = '2017';
-- CU FORMATUL IMPLICIT AL DATEI
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2017;

-- 15. Să se afişeze numele angajaţilor şi comisionul. Dacă un angajat nu câştigă comision, să se scrie “Fara comision”. Etichetaţi coloana “Comision”.
-- CU NVL
SELECT FIRST_NAME, LAST_NAME, NVL(TO_CHAR(COMMISSION_PCT, '0.999'), 'FARA COMISION') AS "COMISION"
FROM EMPLOYEES;
-- CU CASE
SELECT FIRST_NAME, LAST_NAME, CASE WHEN COMMISSION_PCT IS NOT NULL THEN TO_CHAR(COMMISSION_PCT, '0.999') ELSE 'FARA COMISION' END AS "COMISION"
FROM EMPLOYEES;

-- 16. Să se listeze numele, salariul şi comisionul tuturor angajaţilor al căror venit lunar (salariu + valoare comision) depăşeşte 10000.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE CASE WHEN COMMISSION_PCT IS NOT NULL THEN SALARY + COMMISSION_PCT * SALARY > 10000 ELSE SALARY > 10000 END;

-- 17. Să se afişeze numele, codul job-ului, salariul şi o coloană care să arate salariul după mărire. Se presupune că pentru IT_PROG are loc o mărire de 20%, pentru SA_REP creşterea este de 25%, iar pentru SA_MAN are loc o mărire de 35%. Pentru ceilalti angajati nu se acorda marire.
-- CU CASE
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY, CASE WHEN UPPER(JOB_ID) = 'IT_PROG' THEN SALARY + SALARY * 20 / 100 WHEN UPPER(JOB_ID) = 'SA_REP' THEN SALARY + SALARY * 25 / 100 WHEN UPPER(JOB_ID) = 'SA_MAN' THEN SALARY + SALARY * 35 / 100 ELSE SALARY + 0 END AS "SALARIU DUPA MARIRE"
FROM EMPLOYEES;
-- CU DECODE
SELECT FIRST_NAME, JOB_ID, DECODE(UPPER(JOB_ID), 'IT_PROG', SALARY * 1.2, 'SA_REP', SALARY * 1.25, 'SA_MAN', SALARY * 1.35, SALARY) "SALARIU NEGOCIAT"
FROM EMPLOYEES;

----------------------
-- Laborator 3 Join --
----------------------

-- 1. Să se listeze job-urile angajaților care lucrează în departamentul 30.
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE E.DEPARTMENT_ID = 30;

-- 2. Să se afişeze numele salariatului şi numele departamentului pentru toţi salariaţii care au litera A inclusă în nume.
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(FIRST_NAME) LIKE '%A%' OR UPPER(LAST_NAME) LIKE '%A';

-- 3. Să se afişeze numele, job-ul, codul şi numele departamentului pentru toţi angajaţii care lucrează în Oxford.
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E
JOIN JOBS J ON J.JOB_ID = E.JOB_ID
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L ON L.LOCATION_ID = D.LOCATION_ID
WHERE UPPER(L.CITY) = 'OXFORD';

-- 4. Sa se determine codurile angajatilor si numele job-urilor al caror salariu este mai mare decat 3000 sau este egal cu media dintre salariul minim si salariul maxim aferente job-ului respectiv.
SELECT E.EMPLOYEE_ID, J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J ON J.JOB_ID = E.JOB_ID
WHERE E.SALARY > 3000 OR E.SALARY = (J.MIN_SALARY + J.MAX_SALARY) / 2;

-- 5. Sa se afișeze codul departamentului, numele departamentului, numele și job-ul tuturor angajaților din departamentele al căror nume conţine şirul ‘ti’. Rezultatul se va ordona alfabetic după numele departamentului, şi în cadrul acestuia, după numele angajaţilor.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME, E.JOB_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%TI%'
ORDER BY D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME;

-- 6. Să se afişeze codul angajatului şi numele acestuia, împreună cu numele şi codul şefului său direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.
SELECT E1.EMPLOYEE_ID AS "ID ANGAJAT", E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", E2.EMPLOYEE_ID "ID MANAGER", E2.FIRST_NAME || ' ' || E2.LAST_NAME AS "NUME MANAGER"
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

-- 7. Să se afişeze numele şi data angajării pentru salariaţii care au fost angajaţi după Gates.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.HIRE_DATE, E2.HIRE_DATE
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.HIRE_DATE > E2.HIRE_DATE AND UPPER(E2.LAST_NAME) = 'GATES';

-- 8. Sa se afișeze codul şi numele angajaţilor care lucrează în același departament cu cel puţin un alt angajat al cărui nume conţine litera “t”. Se vor afişa, de asemenea, codul şi numele departamentului respectiv. Rezultatul va fi ordonat alfabetic după nume.
SELECT DISTINCT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E 
JOIN EMPLOYEES E2 ON E.DEPARTMENT_ID = E2.DEPARTMENT_ID AND UPPER(E2.LAST_NAME) LIKE '%T%' AND E.EMPLOYEE_ID != E2.EMPLOYEE_ID
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.LAST_NAME;

-- 9. Sa se afișeze numele, salariul, titlul job-ului, oraşul şi ţara în care lucrează angajatii condusi direct de King.
SELECT E1.EMPLOYEE_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E1
JOIN JOBS J ON J.JOB_ID = E1.JOB_ID
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E1.DEPARTMENT_ID
JOIN LOCATIONS L ON L.LOCATION_ID = D.LOCATION_ID
JOIN COUNTRIES C ON C.COUNTRY_ID = L.COUNTRY_ID
JOIN EMPLOYEES E2 ON E1.EMPLOYEE_ID = E2.MANAGER_ID AND UPPER(E2.LAST_NAME) = 'KING';

-- 1. Se cer codurile departamentelor al căror nume conţine şirul “re” sau în care lucrează angajaţi având codul job-ului “SA_REP”.
SELECT D.DEPARTMENT_ID
FROM DEPARTMENTS D
WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%RE%'
UNION
SELECT E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE UPPER(E.JOB_ID) = 'SA_REP';

-- 2. Sa se obtina codurile departamentelor in care nu lucreaza nimeni (nu este introdus nici un salariat in tabelul employees). Se cer două soluţii. Este corecta urmatoarea varianta? De ce ? `SELECT department_id FROM departments WHERE department_id NOT IN (SELECT department_id FROM employees);` 
SELECT D.DEPARTMENT_ID
FROM DEPARTMENTS D
WHERE D.MANAGER_ID IS NULL;
        
---------------------------
-- Laborator 4 Subcereri --
---------------------------

-- 1. Folosind subcereri, scrieţi o cerere pentru a afişa numele şi salariul pentru toţi colegii (din acelaşi departament) lui Gates. Se va exclude Gates
SELECT E1.FIRST_NAME, E1.SALARY
FROM EMPLOYEES E1
WHERE E1.DEPARTMENT_ID = (
    SELECT E2.DEPARTMENT_ID
    FROM EMPLOYEES E2
    WHERE UPPER(E2.FIRST_NAME) = 'GATES' OR UPPER(E2.LAST_NAME) = 'GATES' AND E2.EMPLOYEE_ID != E1.EMPLOYEE_ID
);

-- 2. Afișați pentru fiecare angajat codul, numele, salariul, precum și numele șefului direct.
SELECT E1.EMPLOYEE_ID, E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", E1.SALARY, (
    SELECT E2.FIRST_NAME || ' ' || E2.LAST_NAME
    FROM EMPLOYEES E2
    WHERE E2.EMPLOYEE_ID = E1.MANAGER_ID
) AS "NUME SEF DIRECT"
FROM EMPLOYEES E1;

-- 3. Scrieți o cerere pentru a afișa angajații care castiga mai mult decat oricare funcționar (job-ul conţine şirul “CLERK”). Sortati rezultatele după salariu, in ordine descrescatoare (se vor exclude pe ei înșiși).
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", E1.SALARY
FROM EMPLOYEES E1
WHERE E1.SALARY >= ALL (
    SELECT E2.SALARY
    FROM EMPLOYEES E2
    WHERE UPPER(E2.JOB_ID) LIKE '%CLERK%' AND E2.EMPLOYEE_ID != E1.EMPLOYEE_ID
)
ORDER BY E1.SALARY DESC;

-- 4. Scrieţi o cerere pentru a afişa numele, numele departamentului şi salariul angajaţilor care nu câştigă comision, dar al căror şef direct câştigă comision.
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", D.DEPARTMENT_NAME AS "NUME DEPARTAMENT", E1.SALARY AS "SALARIU ANGAJAT"
FROM EMPLOYEES E1
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E1.EMPLOYEE_ID
WHERE E1.COMMISSION_PCT IS NULL AND (
    SELECT E2.COMMISSION_PCT
    FROM EMPLOYEES E2
    WHERE E2.EMPLOYEE_ID = E1.MANAGER_ID
) IS NOT NULL;

-- 5. Pentru fiecare departament, să se obțina numele salariatului avand cea mai mare vechime din departament. Să se ordoneze rezultatul după numele departamentului.
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", D.DEPARTMENT_NAME AS "DEPARTAMENT ANGAJAT"
FROM EMPLOYEES E1
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E1.DEPARTMENT_ID
WHERE SYSDATE - E1.HIRE_DATE >= ALL (
    SELECT SYSDATE - E2.HIRE_DATE
    FROM EMPLOYEES E2
    WHERE E1.DEPARTMENT_ID = E2.DEPARTMENT_ID AND E1.EMPLOYEE_ID != E2.EMPLOYEE_ID
)
ORDER BY D.DEPARTMENT_NAME;

-- 6. Scrieți o cerere pentru a afişa numele, codul departamentului și salariul angajatilor al căror număr de departament și salariu coincid cu numărul departamentului și salariul unui angajat care castiga comision (se vor exclude pe ei înșiși).
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", E1.DEPARTMENT_ID, E1.SALARY
FROM EMPLOYEES E1
WHERE E1.DEPARTMENT_ID IN (
    SELECT E2.DEPARTMENT_ID
    FROM EMPLOYEES E2
    WHERE E2.COMMISSION_PCT IS NOT NULL AND E2.EMPLOYEE_ID != E1.EMPLOYEE_ID
) AND E1.SALARY IN (
    SELECT E2.SALARY
    FROM EMPLOYEES E2
    WHERE E2.COMMISSION_PCT IS NOT NULL AND E2.EMPLOYEE_ID != E1.EMPLOYEE_ID
); -- SE PUTEA COMPACTA: `WHERE (E1.DEPARTMENT_ID, E1.SALARY) IN (SELECT E2.DEPARTMENT_ID, E2.SALARY FROM EMPLOYEES E2 WHERE E2.COMMISSION_PCT IS NOT NULL AND E2.EMPLOYEE_ID != E1.EMPLOYEE_ID)

-- 7. Folosind subcereri, să se afişeze numele, salariul și numele colegului de departament cu cel mai mare salariu, al angajaţilor conduşi direct de preşedintele companiei (acesta este considerat angajatul care nu are manager).
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME ANGAJAT", E1.SALARY AS "SALARIU", (
    SELECT E2.FIRST_NAME || ' ' || E2.LAST_NAME
    FROM EMPLOYEES E2
    WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID AND E2.SALARY > ALL (
        SELECT E3.SALARY
        FROM EMPLOYEES E3
        WHERE E3.DEPARTMENT_ID = E2.DEPARTMENT_ID AND E3.EMPLOYEE_ID != E2.EMPLOYEE_ID
    )
) AS "NUME COLEG"
FROM EMPLOYEES E1
WHERE E1.MANAGER_ID = (
    SELECT E2.EMPLOYEE_ID
    FROM EMPLOYEES E2
    WHERE E2.MANAGER_ID IS NULL
);

-- ROWNUM SE FOLOSESTE IN GENERAL PENTRU A AFISA TOP N PE BAZA UNEI SORTARI, MOTIV PENTRU CARE TREBUIE SA AVEM GRIJA CA MAI INTAI SE REALIZEAZA SORTAREA DATELOR SI APOI FILTRAREA PRIMELOR N

SELECT
    EMPLOYEE_ID, SALARY, ROWNUM
FROM EMPLOYEES
WHERE ROWNUM <= 5
ORDER BY SALARY DESC; --IN ACEST CAZ, MAI INTAI SE FACE FILTRAREA DATELOR SI APOI DATELE FILTRATE SUNT SORTATE

SELECT
    EMPLOYEE_ID, SALARY, ROWNUM
FROM (SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES ORDER BY SALARY DESC)
WHERE ROWNUM <= 5; --IN ACEST CAZ, MAI INTAI SE FACE SORTAREA DATELOR SI APOI FILTRAREA

-- 8. Sa se obtina numele primilor 7 angajați avand salariul maxim. Rezultatul se va afişa în ordine crescătoare a salariilor.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "NUME", E.SALARY AS "SALARIU", ROWNUM
FROM (
    SELECT *
    FROM EMPLOYEES
    ORDER BY SALARY DESC
) E
WHERE ROWNUM <= 7;

-- 9. Sa se obtina numele angajatilor care castiga unul dintre cele mai mari 7 salarii. Rezultatul se va afişa în ordine crescătoare a salariilor.
SELECT E1.FIRST_NAME || ' ' || E1.LAST_NAME AS "NUME", E1.SALARY "SALARIU"
FROM EMPLOYEES E1
WHERE E1.SALARY IN (
    SELECT E2.SALARY
    FROM (
        SELECT DISTINCT SALARY
        FROM EMPLOYEES
        ORDER BY SALARY DESC
    ) E2
    WHERE ROWNUM <= 7
)
ORDER BY E1.SALARY;

-- 10. Afișați informații despre angajații care castiga cel de-al 7-lea salariu.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (
    SELECT T.SALARY
    FROM (
        SELECT DISTINCT SALARY
        FROM EMPLOYEES
        ORDER BY SALARY ASC
    ) T
    WHERE ROWNUM <= 7
    MINUS
    SELECT T.SALARY
    FROM (
        SELECT DISTINCT SALARY
        FROM EMPLOYEES
        ORDER BY SALARY ASC
    ) T
    WHERE ROWNUM <= 6
);

--------------------------
-- Laborator 5 Group By --
--------------------------

-- 1. Să se determine numărul de angajaţi care sunt şefi.
SELECT COUNT(T.MANAGER_ID)
FROM (
    SELECT DISTINCT E.MANAGER_ID
    FROM EMPLOYEES E
) T;

-- 2. Să se afişeze codul şi numele angajaţilor care câștigă mai mult decât salariul mediu din firmă.
SELECT E.EMPLOYEE_ID AS "COD", E.FIRST_NAME || ' ' || E.LAST_NAME AS "NUME"
FROM EMPLOYEES E
WHERE E.SALARY > (SELECT AVG(E2.SALARY) FROM EMPLOYEES E2);

-- 3. Pentru fiecare şef, să se afişeze codul său şi salariul celui mai prost plătit subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De asemenea, se vor exclude grupurile în care salariul minim este mai mic de 4000$. Sortaţi rezultatul în ordine descrescătoare a salariilor.
SELECT E.MANAGER_ID AS "COD SEF", MIN(E.SALARY) "SALARIU SUBORDONAT"
FROM EMPLOYEES E
WHERE MANAGER_ID IS NOT NULL
GROUP BY E.MANAGER_ID, E.SALARY
HAVING MIN(E.SALARY) > 4000
ORDER BY E.SALARY DESC;

-- 4. Să se afişeze maximul salariilor medii pe departamente. Obs: Într-o imbricare de funcţii agregat, criteriul de grupare specificat în clauza GROUP BY se referă doar la funcţia agregat cea mai interioară. Astfel, într-o clauză SELECT în care există funcţii agregat imbricate nu mai pot apărea alte expresii.
SELECT MAX(T."MEDIE SALARII")
FROM (
    SELECT ROUND(AVG(SALARY)) AS "MEDIE SALARII"
    FROM EMPLOYEES E
    GROUP BY E.DEPARTMENT_ID
) T;

-- 5. Scrieți o cerere pentru a afișa, pentru departamentele avand codul > 80, salariul total pentru fiecare job din cadrul departamentului. Se vor afișa numele departamentului, jobul și suma salariilor. Se vor eticheta coloanele corespunzător.
SELECT D.DEPARTMENT_NAME AS "NUME DEPARTAMENT", J.JOB_TITLE AS "NUME SERVICIU", SUM(E.SALARY)"SUMA SALARIILOR"
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN JOBS J ON J.JOB_ID = E.JOB_ID
WHERE E.DEPARTMENT_ID > 80
GROUP BY D.DEPARTMENT_NAME, J.JOB_TITLE;

-- 6. Să se calculeze comisionul mediu din firmă, luând în considerare toate liniile din tabel.
SELECT AVG(NVL(COMMISSION_PCT, 0)) FROM EMPLOYEES;

-- 7. Sa se afiseze codul, numele departamentului și numărul de angajați care lucrează în acel departament, pentru departamentele în care lucrează mai puțin de 4 angajați
SELECT D.DEPARTMENT_ID AS "COD DEPARTAMENT", D.DEPARTMENT_NAME AS "NUME DEPARTAMENT", COUNT(E.EMPLOYEE_ID) AS "NUMAR ANGAJATI"
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
HAVING COUNT(E.EMPLOYEE_ID) < 4;

-- 8. Să se obțină codul, titlul şi salariul mediu al job-ului pentru care salariul mediu este minim.
SELECT J.JOB_ID AS "COD", J.JOB_TITLE AS "TITLU", AVG(E.SALARY) AS "SALARIU MEDIU"
FROM EMPLOYEES E
JOIN JOBS J ON J.JOB_ID = E.JOB_ID
GROUP BY J.JOB_ID, J.JOB_TITLE
HAVING AVG(E.SALARY) = (SELECT MIN(AVG(E.SALARY)) FROM EMPLOYEES E GROUP BY E.JOB_ID);

-- 9. Să se afişeze numele departamentului și cel mai mic salariu din departamentul avand cel mai mare salariu mediu.
SELECT D.DEPARTMENT_NAME, MIN(E.SALARY)
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING AVG(E.SALARY) = (
    SELECT MAX(AVG(E.SALARY))
    FROM EMPLOYEES E
    GROUP BY DEPARTMENT_ID
);

-- 10. Să se afișeze codul, numele departamentului, numărul de angajați și salariul mediu din departamentul respectiv, împreună cu numele, salariul și jobul angajaților din acel departament. Se vor afişa şi departamentele fără angajați.
SELECT D.DEPARTMENT_ID AS "COD DEPARTAMENT", D.DEPARTMENT_NAME "NUME DEPARTAMENT", COUNT(E.EMPLOYEE_ID) "NUMAR ANGAJATI", AVG(E.SALARY) "SALARIU MEDIU DIN DEPARTAMENT", E.FIRST_NAME || ' ' || E.LAST_NAME AS "NUME ANGAJAT", E.SALARY AS "SALARIU", J.JOB_TITLE AS "SERVICIU"
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN JOBS J ON J.JOB_ID = E.JOB_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME, E.SALARY, J.JOB_TITLE;

-----------------------------
-- Laborator 8 Exists --
-----------------------------

-- Exercitii: 1. Sa se obtina numele salariatilor care lucreaza intr-un departament in care exista cel putin un angajat cu salariul egal cu salariul maxim din departamentul 30
WITH "TABEL TEMPORAR" AS (
    SELECT MAX(SALARY) AS "MAXIM"
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 30
)
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES E1
WHERE EXISTS (
    SELECT *
    FROM EMPLOYEES E2
    WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID AND E2.SALARY = (SELECT "MAXIM" FROM "TABEL TEMPORAR")
);
