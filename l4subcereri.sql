--------------
-- La clasa --
--------------

--EXEMPLU SUBCERERE NESINCRONIZATA
SELECT *
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID IN (
        SELECT D.DEPARTMENT_ID
        FROM DEPARTMENTS D
        WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%A%'
    );

--EXEMPLU SUBCERERE SINCRONIZATA
SELECT
    E.EMPLOYEE_ID,
    (
        SELECT D.DEPARTMENT_NAME
        FROM DEPARTMENTS D
        WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
    )
FROM EMPLOYEES E;

----------------------------------------------------
--EXEMPLU SUBCERERE IN CLAUZA WHERE
SELECT *
FROM EMPLOYEES E
WHERE E.SALARY > ANY (
        SELECT E2.SALARY
        FROM EMPLOYEES E2
        WHERE E2.DEPARTMENT_ID = 20
    );

--EXEMPLU SUBCERERE IN CLAUZA SELECT (POATE RETURNA O SINGURA INREGISTRARE SI O SINGURA COLOANA)
SELECT
    E.EMPLOYEE_ID,
    (
        SELECT D.DEPARTMENT_NAME
        FROM DEPARTMENTS D
        WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
    )
FROM EMPLOYEES E;

--EXEMPLU SUBCERERE IN CLAUZA FROM
--REGULI:
--  -ATRIBUIRE DE ALIAS SUBCERERII
--  -ATRIBUIRE DE ALIAS COLOANELOR DETERMINATE PRIN OPERATII, FUNCTII SAU ALTE SUBCERERI
SELECT T.EMPLOYEE_ID, T.SALARIU
FROM (
        SELECT E.EMPLOYEE_ID, E.SALARY*12 SALARIU
        FROM EMPLOYEES E
        WHERE E.DEPARTMENT_ID = 20
    ) T;

--ANY
-- 3 > ANY (4, 2, 5) -> TRUE
-- 3 > ANY (4, 5, 5) -> FALSE

--ALL
-- 3 > ALL (4, 2, 5) -> FALSE
-- 3 > ALL (1, 2, 0) -> TRUE

---------------
-- Exercitii --
---------------

-- 1. Folosind subcereri, scrieţi o cerere pentru a afişa numele şi salariul pentru toţi colegii (din acelaşi departament) lui Gates. Se va exclude Gates
SELECT
    E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = (
        SELECT
            E2.DEPARTMENT_ID
        FROM EMPLOYEES E2
        WHERE UPPER(E2.FIRST_NAME) = 'GATES' OR UPPER(E2.LAST_NAME) = 'GATES' AND E2.EMPLOYEE_ID <> E.EMPLOYEE_ID
    );

-- 2. Afișați pentru fiecare angajat codul, numele, salariul, precum și numele șefului direct.
SELECT
    E.EMPLOYEE_ID, E.FIRST_NAME,
       (
           SELECT
                E2.FIRST_NAME
           FROM EMPLOYEES E2
           WHERE E2.EMPLOYEE_ID = E.MANAGER_ID
       )
FROM EMPLOYEES E;

-- 3. Scrieți o cerere pentru a afișa angajații care castiga mai mult decat oricare funcționar (job-ul conţine şirul “CLERK”). Sortati rezultatele după salariu, in ordine descrescatoare (se vor exclude pe ei înșiși).
SELECT
    E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE E.SALARY >= ALL (
        SELECT
            E2.SALARY
        FROM EMPLOYEES E2
        WHERE UPPER(E2.JOB_ID) LIKE '%CLERK%' AND E2.EMPLOYEE_ID <> E.EMPLOYEE_ID
    );

-- 4. Scrieţi o cerere pentru a afişa numele, numele departamentului şi salariul angajaţilor care nu câştigă comision, dar al căror şef direct câştigă comision.
SELECT E.EMPLOYEE_ID
FROM EMPLOYEES E
WHERE E.COMMISSION_PCT IS NULL AND (
        SELECT
            E2.COMMISSION_PCT
        FROM EMPLOYEES E2
        WHERE E2.EMPLOYEE_ID = E.MANAGER_ID
    ) IS NOT NULL;

-- 5. Pentru fiecare departament, să se obțina numele salariatului avand cea mai mare vechime din departament. Să se ordoneze rezultatul după numele departamentului.
SELECT
    E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE SYSDATE - E.HIRE_DATE >= ALL(
        SELECT
            SYSDATE - E2.HIRE_DATE
        FROM EMPLOYEES E2
        WHERE E.DEPARTMENT_ID = E2.DEPARTMENT_ID
    )
ORDER BY D.DEPARTMENT_NAME;

-- 6. Scrieți o cerere pentru a afişa numele, codul departamentului și salariul angajatilor al căror număr de departament și salariu coincid cu numărul departamentului și salariul unui angajat care castiga comision (se vor exclude pe ei înșiși).
SELECT
    E.FIRST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (
        SELECT
            E2.DEPARTMENT_ID, E2.SALARY
        FROM EMPLOYEES E2
        WHERE E2.COMMISSION_PCT IS NOT NULL AND
                E.EMPLOYEE_ID <> E2.EMPLOYEE_ID
    );

-- 7. Folosind subcereri, să se afişeze numele, salariul și numele colegului de departament cu cel mai mare salariu, al angajaţilor conduşi direct de preşedintele companiei (acesta este considerat angajatul care nu are manager).
SELECT
    E.FIRST_NAME, E.SALARY,
       (
           SELECT
                E3.FIRST_NAME
           FROM EMPLOYEES E3
           WHERE E3.DEPARTMENT_ID = E.DEPARTMENT_ID AND
                 E3.SALARY >ALL (
                        SELECT E4.SALARY
                        FROM EMPLOYEES E4
                        WHERE E4.DEPARTMENT_ID = E3.DEPARTMENT_ID
                            AND E4.EMPLOYEE_ID <> E3.EMPLOYEE_ID
                   )
           )
FROM EMPLOYEES E
WHERE E.MANAGER_ID = (
        SELECT
            E2.EMPLOYEE_ID
        FROM EMPLOYEES E2
        WHERE E2.MANAGER_ID IS NULL
    );

--------------------------------------
--ROWNUM
--ROWNUM SE FOLOSESTE IN GENERAL PENTRU A AFISA TOP N PE BAZA UNEI SORTARI, MOTIV PENTRU CARE TREBUIE SA AVEM GRIJA CA
    --MAI INTAI SE REALIZEAZA SORTAREA DATELOR SI APOI FILTRAREA PRIMELOR N

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
SELECT
    T.FIRST_NAME, T.SALARY
FROM (
        SELECT *
        FROM EMPLOYEES
        ORDER BY SALARY DESC
    ) T
WHERE ROWNUM <= 7;

-- 9. Sa se obtina numele angajatilor care castiga unul dintre cele mai mari 7 salarii. Rezultatul se va afişa în ordine crescătoare a salariilor.
SELECT *
FROM EMPLOYEES E
WHERE E.SALARY IN (
    SELECT
        T.SALARY
    FROM (
            SELECT DISTINCT SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC
        ) T
    WHERE ROWNUM <= 7
    );

-- 10. Afișați informații despre angajații care castiga cel de-al 7-lea salariu.
--METODA 1
SELECT *
FROM EMPLOYEES
WHERE SALARY = (
    SELECT
        T.SALARY
    FROM (
            SELECT DISTINCT SALARY
            FROM EMPLOYEES
            ORDER BY SALARY ASC
        ) T
    WHERE ROWNUM <= 7
    MINUS
    SELECT
        T.SALARY
    FROM (
            SELECT DISTINCT SALARY
            FROM EMPLOYEES
            ORDER BY SALARY ASC
        ) T
    WHERE ROWNUM <= 6
);

--METODA 2
SELECT *
FROM (
    SELECT *
    FROM EMPLOYEES E
    WHERE E.SALARY IN (
        SELECT
            T.SALARY
        FROM (
                SELECT DISTINCT SALARY
                FROM EMPLOYEES
                ORDER BY SALARY ASC
            ) T
        WHERE ROWNUM <= 7
        )
    ORDER BY E.SALARY DESC
     )
WHERE ROWNUM = 1;
