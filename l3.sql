--OPERATIE DE JOIN FOLOSIND CLAUZA WHERE
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--OPERATIE DE JOIN FOLOSIND CLAUZA JOIN CU ON
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--OPERATIE DE JOIN FOLOSIND CLAUZA JOIN CU USING
SELECT
    EMPLOYEE_ID, DEPARTMENT_NAME
FROM EMPLOYEES
JOIN DEPARTMENTS USING (DEPARTMENT_ID);

--CELE 2 COMENZI DE MAI SUS SUNT ECHIVALENTE
--IN CAZUL IN CARE UTILIZATI "JOIN ON", TREBUIE ATRIBUITE OBLIGATORIU ALIAS-URI TABELELOR UTILIZATE
--IN CAZUL IN CARE UTILIZATI "USING", NU TREBUIE ATRIBUITE ALIAS-URI TABELELOR UTILIZATE, IAR COLOANA
                                        -- PE CARE SE FACE JOIN TREBUIE SA AIBE ACEEASI DENUMIRE IN AMBELE TABELE
--EXEMPLU NONEQUIJOIN
SELECT
    E.EMPLOYEE_ID, E2.EMPLOYEE_ID
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.HIRE_DATE > E2.HIRE_DATE;

--IN ACEST EXEMPLU SE PREIAU IN PLUS SI INREGISTRARILE DIN TABELUL EMPLOYEES CARE NU RESPECTA CONDITIA DE JOIN
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--IN ACEST EXEMPLU SE PREIAU IN PLUS SI INREGISTRARILE DIN TABELUL DEPARTMENTS CARE NU RESPECTA CONDITIA DE JOIN
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--IN ACEST EXEMPLU SE PREIAU IN PLUS SI INREGISTRARILE DIN AMBELE TABELE CARE NU RESPECTA CONDITIA DE JOIN
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--CELE 2 COMENZI DE MAI JOS SUNT ECHIVALENTE
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT
    E.EMPLOYEE_ID, D.DEPARTMENT_NAME
FROM DEPARTMENTS D
RIGHT JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--NATURAL JOIN -> SE FACE JOIN PE TOATE COLOANELE CU ACEEASI DENUMIRE DIN CELE 2 TABELE
SELECT *
FROM EMPLOYEES
NATURAL JOIN DEPARTMENTS;

--1
SELECT
    E.EMPLOYEE_ID, J.JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE E.DEPARTMENT_ID = 30;

--2
SELECT
    E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(E.FIRST_NAME) LIKE '%A%';

--3
SELECT
    E.EMPLOYEE_ID, E.JOB_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE UPPER(L.CITY) = 'OXFORD';

--4
SELECT
    E.EMPLOYEE_ID, J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE SALARY > 3000 OR E.SALARY = (J.MAX_SALARY + J.MIN_SALARY)/2;

--5
SELECT
    D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.JOB_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D on E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%TI%'
ORDER BY D.DEPARTMENT_NAME, E.FIRST_NAME;

--6
--EXEMPLU SELF JOIN
SELECT
    E.EMPLOYEE_ID "ID ANGAJAT", E.FIRST_NAME "ANGAJAT",
       E2.EMPLOYEE_ID "ID MANAGER", E2.FIRST_NAME "MANAGER"
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID;

--7
SELECT
    E.EMPLOYEE_ID, E.HIRE_DATE, E2.HIRE_DATE
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON
    UPPER(E2.LAST_NAME) = 'GATES' AND E.HIRE_DATE > E2.HIRE_DATE;

--8
SELECT
    DISTINCT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON
    E.DEPARTMENT_ID = E2.DEPARTMENT_ID AND
    UPPER(E2.FIRST_NAME) LIKE '%T%' AND
    E.EMPLOYEE_ID <> E2.EMPLOYEE_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.FIRST_NAME;

--9
SELECT
    E.EMPLOYEE_ID, E.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID
JOIN JOBS J on E.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE UPPER(E2.LAST_NAME) = 'KING';

--OPERATORI PE MULTIMI
    --REGULI DE RESPECTAT CAND SE UTILIZEAZA OPERATORI PE MULTIMI
        --1: IN CELE 2 CERERI, IN CLAUZA SELECT TREBUIE SA FIE ACELASI NUMAR DE CAMPURI
        --2: CAMPURILE DIN CLAUZA SELECT TREBUIE SA CORESPUNDA CA SI TIP DE DATE

 --1
SELECT
    D.DEPARTMENT_ID AS DEP
FROM DEPARTMENTS D
WHERE UPPER(d.DEPARTMENT_NAME) LIKE '%RE%'
UNION
SELECT
    E.DEPARTMENT_ID AS DEP
FROM EMPLOYEES E
WHERE UPPER(E.JOB_ID) = 'SA_REP';

--2
SELECT
    DEPARTMENT_ID
FROM DEPARTMENTS
MINUS
SELECT
    DEPARTMENT_ID
FROM EMPLOYEES;

SELECT
    D.DEPARTMENT_ID
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL;

SELECT D.DEPARTMENT_ID
FROM DEPARTMENTS D
WHERE D.DEPARTMENT_ID NOT IN
      (SELECT E. DEPARTMENT_ID
        FROM EMPLOYEES E
        WHERE E.DEPARTMENT_ID IS NOT NULL);

-- -- 1. Să se listeze job-urile angajaților care lucrează în departamentul 30.
-- SELECT
--     J.JOB_TITLE
-- FROM EMPLOYEES E
-- JOIN JOBS J ON(E.JOB_ID = J.JOB_ID)
-- JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

-- -- 2. Să se afişeze numele salariatului şi numele departamentului pentru toţi salariaţii care au litera A inclusă în nume.
-- SELECT
--     E.FIRST_NAME, D.DEPARTMENT_NAME
-- FROM EMPLOYEES E
-- JOIN DEPARTMENTS D ON(E.DEPARTMENT_ID = D.DEPARTMENT_ID)
-- WHERE UPPER(E.FIRST_NAME) LIKE '%A%';

-- -- 3. Să se afişezenumele, job-ul, codul şi numele departamentului pentru toţi angajaţii care lucrează în Oxford.

-- -- 4. Sa se determine codurile angajatilor si numele job-urilor al caror salariu este mai mare decat 3000 sau este egal cu media dintre salariul minim si salariul maxim aferente job-ului respectiv.

-- -- 5. Sa se afișeze codul departamentului, numele departamentului, numele și job-ul tuturor angajaților din departamentele al căror nume conţine şirul ‘ti’. Rezultatul se va ordona alfabetic după numele departamentului, şi în cadrul acestuia, după numele angajaţilor.

-- -- 6. Să se afişeze codulangajatului şi numele acestuia, împreună cu numele şi codul şefului său direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.

-- -- 7. Să se afişeze numele şi data angajării pentru salariaţii care au fost angajaţi după Gates.

-- -- 8. Sa se afișeze codul şi numele angajaţilor care lucrează în același departament cu cel puţin un alt angajat al cărui nume conţine litera “t”. Se vor afişa, de asemenea, codul şi numele departamentului respectiv. Rezultatul va fi ordonat alfabetic după nume.
-- SELECT DISTINCT *
-- FROM EMPLOYEES;
-- -- DISTINCT PENTRU A FI FARA DUPLICATE

-- -- 9. Sa se afișeze numele, salariul, titlul job-ului, oraşul şi ţara în care lucrează angajatii condusi direct de King.
-- SELECT 
--     E.FIRST_NAME
-- FROM EMPLOYEES E
-- JOIN EMPLOYEES B ON (E.EMPLOYEE_ID = B.E.EMPLOYEE_ID);

-- -- Operatori pe multimi
-- -- La union se face un fel de reuniune a multimilor

-- -- 1. Se cer codurile departamentelor al căror nume conţine şirul “re” sau în care lucrează angajaţi având codul job-ului “SA_REP”.
-- SELECT D.DEPARTMENT_ID
-- FROM DEPARTMENTS D
-- WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%RE%';
-- -- NOTA: Asta l-am facut initial cu OR insa trebe cu UNION ca la catedra

-- -- 2. Sa se obtina codurile departamentelor in care nu lucreaza nimeni (nu este introdus nici un salariat in tabelul employees). Se cer două soluţii.
-- SELECT department_id
-- FROM departments
-- WHERE department_id NOT IN (SELECT department_id
-- FROM employees);
-- -- ? Este corecta aceasta varianta? De ce ?
