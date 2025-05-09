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

-- NICW: check the followin statements
    -- Regula la ROLLUP e ca elimina cate o colona
    -- Iar la CUBE, face grupare pe orice multime se poate forma cu regula CUBE
