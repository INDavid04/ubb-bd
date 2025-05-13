--------------
-- La clasa --
--------------

--        100
--      /     \
--     101     102
--    /   \    /
--  102   103 105
--  /
-- 200
-- De mentionat ca putem face parcurgerea de sus in jos sau de jos in sus

-- Exemplu in care face afisare de jos in sus
select employee_id, manager_id
from employees
start with employee_id = 101
connect by employee_id = prior manager_id;
-- employee_id e cheia parinte, deci daca pun prior langa cheia parinte am afisare de sus in jos

select employee_id, manager_id, level
from employees
start with employee_id = 101
connect by prior manager_id = employee_id;

-- Exemplu: 1.a)
select employee_id, manager_id, level
from EMPLOYEES
where level > 1
start with upper(last_name) = 'DE HANN'
connect by manager_id = prior employee_id;
-- folosim connect by pentru a stabili legatura

-- Exemplu: 1.b)
select employee_id, manager_id, level
from EMPLOYEES
where level > 2
start with upper(last_name) = 'DE HANN'
connect by manager_id = prior employee_id;

-- Exemplu: 2
-- Pentru fiecare anagajat afisam cate o ierarhie
select employee_id, manager_id, level
from EMPLOYEES
connect by prior manager_id = employee_id;

-- Exemplu: 3 (Cerinta: Pentru fiecare angajat sa se determine numarul de subalterni (nu doar cei directi))
select e.employee_id,
    (
        select count(*)
        from employees e1
        where level > 1
        start with e1.employee_id = e.employee_id
        connect by prior e1.employee_id = e1.manager_id
    ) as "NUMAR SUBALTERNI"
from employees;

-----------------
-- Clauza WITH --
-----------------
-- Sintaxa
with tabel_temp as (
    select employee_id, salary*12
    from EMPLOYEES
    where department_id = 30
), tabel_temp_2 as (
    select *
    from tabel_temp
)
select *
from tabel_temp, tabel_temp2;

-- Sintaxa
with tabel_temp as (
    select employee_id, salary*12
    from EMPLOYEES
    where department_id = 30
), tabel_temp_2 as (
    select *
    from tabel_temp
)
select tabel_temp.sal
from tabel_temp, tabel_temp2;
-- WITH e mai eficient din punt de vedere al timpului de utilizare fata de EXIST

-- Exist se screi in felul urmator si returneaza true sau false
select *
from employees
where exists (
    select *
    -- ....
);

-- Exercitii: 1. Sa se obtina numele salariatilor care lucreaza intr-un departament in care exista cel putin un angajat cu salariul egal cu salariul maxim din departamentul 30

-- La casa:
WITH TABEL_TEMP AS (
    SELECT MAX(SALARY) MAXIM
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 30
)
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES E
WHERE EXISTS(
    SELECT *
    FROM EMPLOYEES E1
    WHERE E1.DEPARTMENT_ID = E.DEPARTMENT_ID AND E1.SALARY = (SELECT MAXIM FROM TABEL_TEMP)
);

-- Exerccitiul 2: Utilizand clauza WITH sa se scrie o cerere care afiseaza numele departamentelor si valoarea totala a salariatilor din cadrul acestora. Se vor considera departamentel a caror baloare totala a salariilor este mai mare decat media balorilor totale ale salariilor pe departamente
WITH TABEL_SUME_DEP AS (
    SELECT D.DEPARTMENT_NAME, SUM(E.SALARY) SUM_SAL
    FROM EMPLOYEES_E
    JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME
)
SELECT *
FROM TABEL_SUME_DEP
WHERE SUM_SAL > (
    SELECT AVG(SUM_SAL)
);

-- Exercitii:
-- 1.a) Sa se afiseaze codul, numele, data angajarii, salariul si managerul pentru ierarhia arborescenta de sub De Hann
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, SALARY, MANAGER_ID
FROM EMPLOYEES
START WITH UPPER(LAST_NAME) = 'DE HANN'
CONNECT BY EMPLOYEE_ID = MANAGER_ID;

-- GROUPING SETS acopera cele mai multe cazuri
SELECT DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEES
GROUP BY GROUPING SETS (
    (DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE), SUM(SALARY))
);
-- Cand avem neclaritati putem folosi grouping care ne spune daca respectiva coloana a fost folosita sau nu (1 folosita; 0 nu a fost folosita)

-- NICE: check the followin statements
    -- Regula la ROLLUP e ca elimina cate o colona
    -- Iar la CUBE, face grupare pe orice multime se poate forma cu regula CUBE

---------------
-- Exercitii --
---------------

-- 1. Să se obțină numele salariaților care lucrează într-un departament în care există cel puțin un angajat cu salariul egal cu salariul maxim din departamentul 30.
SELECT *
FROM EMPLOYEES E3
WHERE E3.DEPARTMENT_ID IN (
    SELECT
        DISTINCT E2.DEPARTMENT_ID
    FROM EMPLOYEES E2
    WHERE E2.SALARY = (
        SELECT
            MAX(E.SALARY)
        FROM EMPLOYEES E
        WHERE E.DEPARTMENT_ID = 30
        )
    );

SELECT *
FROM EMPLOYEES E
WHERE EXISTS(
        SELECT *
        FROM EMPLOYEES E2
        WHERE E2.SALARY = (
            SELECT
                MAX(E4.SALARY)
            FROM EMPLOYEES E4
            WHERE E4.DEPARTMENT_ID = 30) AND
              E2.DEPARTMENT_ID = E.DEPARTMENT_ID
          );

-- 2. Utilizând clauza WITH, să se scrie o cerere care afişează numele departamentelor şi valoarea totală a salariilor din cadrul acestora. Se vor considera departamentele a căror valoare totală a salariilor este mai mare decât media valorilor totale ale salariilor pe departamente.
WITH TABLE_SECUND AS (
    SELECT D.DEPARTMENT_NAME, SUM(E.SALARY) "SUMA TOTALA"
    FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME
)
SELECT *
FROM TABLE_SECUND T
WHERE T."SUMA TOTALA" > (
        SELECT AVG(T2."SUMA TOTALA")
        FROM TABLE_SECUND T2
    );

-------------------------
-- SUBCERERI IERARHICE --
-------------------------

--     100
--101       102
--103     104 105

--START WITH EMPLOYEE_ID = 100 -> 100LVL1, 101LVL2
--START WITH EMPLOYEE_ID = 101 -> 101LVL1, 103LVL2

-- 1. a) Să se afișeze codul, numele, data angajării, salariul şi managerul pentru: ierarhia arborescenta de sub De Haan;
SELECT
    E.EMPLOYEE_ID, E.MANAGER_ID, LEVEL
FROM EMPLOYEES E
WHERE LEVEL > 1
START WITH E.LAST_NAME = 'De Haan'
CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID;

-- 1. b) Să se afișeze codul, numele, data angajării, salariul şi managerul pentru: subalternii directi ai lui De Haan;
SELECT
    E.EMPLOYEE_ID, E.MANAGER_ID, LEVEL
FROM EMPLOYEES E
WHERE LEVEL = 2
START WITH E.LAST_NAME = 'De Haan'
CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID;

-- 1. c) Să se afișeze codul, numele, data angajării, salariul şi managerul pentru: subalternii care sunt cu 2 niveluri sub De Haan.
SELECT
    E.EMPLOYEE_ID, E.MANAGER_ID, LEVEL
FROM EMPLOYEES E
WHERE LEVEL = 3
START WITH E.LAST_NAME = 'De Haan'
CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID;

-- 2. Pentru fiecare linie din tabelul EMPLOYEES se va afișa o structura arborescentă în care va apărea angajatul, managerul său, managerul managerului etc. Coloanele afişate vor fi: codul angajatului, codul managerului, nivelul în ierarhie (LEVEL) și numele angajatului.
SELECT
    E.EMPLOYEE_ID, E.MANAGER_ID, LEVEL
FROM EMPLOYEES E
CONNECT BY PRIOR E.MANAGER_ID = E.EMPLOYEE_ID;

-- 3. Pentru fiecare angajat să se determine numărul de subalterni (nu doar cei direcți).
SELECT
    E2.EMPLOYEE_ID, (
        SELECT
            COUNT(*) - 1
        FROM EMPLOYEES E
        START WITH E.EMPLOYEE_ID = E2.EMPLOYEE_ID
        CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
    )
FROM EMPLOYEES E2;

--GROUP BY ROLLUP(x, y, z) -> x,y,z / x,y / x / total
--GROUP BY ROLLUP(x, y) -> x,y / x / total
--GROUP BY CUBE(x, y, z) -> x,y,z / x,y / x,z / x / y,z / y / z / total
--GROUP BY CUBE(x, y) -> x,y / y,x / x / y / total

-------------------
-- Grouping sets --
-------------------

-- 1. (a) Să se afişeze numele departamentelor, titlurile job-urilor şi valoarea medie a salariilor, pentru: - fiecare departament şi, în cadrul său pentru fiecare job; - fiecare departament (indiferent de job); - întreg tabelul. (b) Analog cu (a), afişând şi o coloană care arată intervenţia coloanelor department_name, job_title, în obţinerea rezultatului.
SELECT
    D.DEPARTMENT_NAME, J.JOB_TITLE, AVG(E.SALARY),
    GROUPING(D.DEPARTMENT_NAME), GROUPING(J.JOB_TITLE)
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY ROLLUP(D.DEPARTMENT_NAME, J.JOB_TITLE);

-- 2. (a) Să se afişeze numele departamentelor, titlurile job-urilor şi valoarea medie a salariilor, pentru: fiecare departament şi, în cadrul său pentru fiecare job; fiecare departament (indiferent de job); fiecare job (indiferent de departament); întreg tabelul. (b) Cum intervin coloanele în obţinerea rezultatului? Să se afişeze ’Dep’, dacă departamentul a intervenit în agregare, ‘Job’, dacă job-ul a intervenit în agregare, ’DepJob’ dacă ambele au intervenit și ’Niciuna’ daca nicio coloană nu a intervenit.
SELECT
    D.DEPARTMENT_NAME, J.JOB_TITLE, AVG(E.SALARY),
    CASE
        WHEN GROUPING(D.DEPARTMENT_NAME) = 1 AND GROUPING(J.JOB_TITLE) = 1 THEN 'NICIUNA'
        WHEN GROUPING(D.DEPARTMENT_NAME) = 1 AND GROUPING(J.JOB_TITLE) = 0 THEN 'JOB'
        WHEN GROUPING(D.DEPARTMENT_NAME) = 0 AND GROUPING(J.JOB_TITLE) = 1 THEN 'DEP'
        WHEN GROUPING(D.DEPARTMENT_NAME) = 0 AND GROUPING(J.JOB_TITLE) = 0 THEN 'DEPJOB'
    END
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY CUBE(D.DEPARTMENT_NAME, J.JOB_TITLE);

-- 3. Să se afişeze numele departamentelor, numele job-urilor, codurile managerilor, maximul şi suma salariilor pentru: fiecare departament şi, în cadrul său, fiecare job; fiecare job şi, în cadrul său, pentru fiecare manager;întreg tabelul.
SELECT
    D.DEPARTMENT_NAME, J.JOB_TITLE, D.MANAGER_ID,
    MAX(E.SALARY), SUM(E.SALARY)
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY GROUPING SETS((D.DEPARTMENT_NAME, J.JOB_TITLE), (J.JOB_TITLE, D.MANAGER_ID), ());
