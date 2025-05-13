--------------
-- La clasa --
--------------

SELECT
    E.DEPARTMENT_ID, SUM(SALARY),
        (SELECT 1 FROM DUAL) --SE POT ADAUGA DE ASEMENEA SI SUBCERERI NESINCRONIZATE
FROM EMPLOYEES E
GROUP BY E.DEPARTMENT_ID; --TOATE COLOANELE CARE APAR INDEPENDENT IN CLAUZA SELECT, TREBUIE SA APARA SI IN CLAUZA GROUP BY

SELECT
    SUM(SALARY) --DACA NU SE FOLOSESTE GROUP BY, FUNCTIA SE APLICA PE TOATE INREGISTRARILE DIN TABEL
FROM EMPLOYEES E;

SELECT COUNT(DEPARTMENT_ID)
FROM EMPLOYEES; --RETURNEAZA 106 DEOARECE EXISTA UN ANGAJAT CARE ARE 'NULL' PE COLOANA DEPARTMENT_ID

SELECT COUNT(EMPLOYEE_ID)
FROM EMPLOYEES; --RETURNEAZA 107 DEOARECE TOATE VALORILE DE PE COLOANA EMPLOYEE_ID SUNT NENULE

SELECT COUNT(*)
FROM EMPLOYEES; --RETURNEAZA 107

-- FUNCTIILE AVG, SUM, MIN, MAX, COUNT('O COLOANA') --IGNORA VALORILE DE NULL
-- COUNT(*) NU IGNORA VALORILE DE NULL
-- COUNT(DISTINCT X) -- CALCULEAZA CATE VALORI DISTINCTE PE COLOANA 'X' SUNT

---------------
-- Exercitii --
---------------

-- 1. Să se determine numărul de angajaţi care sunt şefi.
SELECT
    COUNT(T.MANAGER_ID)
FROM (
        SELECT
            DISTINCT E.MANAGER_ID
        FROM EMPLOYEES E
    ) T;

-- 2. Să se afişeze codul şi numele angajaţilor care câștigă mai mult decât salariul mediu din firmă.
SELECT
    E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E
WHERE E.SALARY > (
        SELECT
            AVG(E2.SALARY)
        FROM EMPLOYEES E2
    );

-- 3. Pentru fiecare şef, să se afişeze codul său şi salariul celui mai prost plătit subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De asemenea, se vor exclude grupurile în care salariul minim este mai mic de 4000$. Sortaţi rezultatul în ordine descrescătoare a salariilor.
SELECT
    E.MANAGER_ID, MIN(E.SALARY)
FROM EMPLOYEES E
WHERE E.MANAGER_ID IS NOT NULL
GROUP BY E.MANAGER_ID
HAVING MIN(E.SALARY) > 4000;

-- 4. Să se afişeze maximul salariilor medii pe departamente. Obs: Într-o imbricare de funcţii agregat, criteriul de grupare specificat în clauza GROUP BY se referă doar la funcţia agregat cea mai interioară. Astfel, într-o clauză SELECT în care există funcţii agregat imbricate nu mai pot apărea alte expresii.
SELECT
    MAX(T.MEDIE_SAL)
FROM (
        SELECT AVG(SALARY) MEDIE_SAL
        FROM EMPLOYEES E
        GROUP BY E.DEPARTMENT_ID
) T;

SELECT
    MAX(AVG(E.SALARY))
FROM EMPLOYEES E
GROUP BY E.DEPARTMENT_ID;

-- 5. Scrieți o cerere pentru a afișa, pentru departamentele avand codul > 80, salariul total pentru fiecare job din cadrul departamentului. Se vor afișa numele departamentului, jobul și suma salariilor. Se vor eticheta coloanele corespunzător.
SELECT
    E.DEPARTMENT_ID, E.JOB_ID, SUM(E.SALARY)
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID > 80
GROUP BY E.DEPARTMENT_ID, E.JOB_ID;

-- 6. Să se calculeze comisionul mediu din firmă, luând în considerare toate liniile din tabel.
SELECT AVG(NVL(commission_pct, 0))
FROM employees;

SELECT SUM(commission_pct)/COUNT(*)
FROM employees;

-- 7. Sa se afiseze codul, numele departamentului și numărul de angajați care lucrează în acel departament, pentru departamentele în care lucrează mai puțin de 4 angajați
SELECT
    D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID)
FROM EMPLOYEES E
JOIN DEPARTMENTS D on D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(E.EMPLOYEE_ID) < 4;

-- 8. Să se obțină codul, titlul şi salariul mediu al job-ului pentru care salariul mediu este minim.
SELECT
    E.JOB_ID, AVG(E.SALARY)
FROM EMPLOYEES E
GROUP BY E.JOB_ID
HAVING AVG(E.SALARY) = (
        SELECT
            MIN(AVG(E.SALARY))
        FROM EMPLOYEES E
        GROUP BY E.JOB_ID
    );

-- 9. Să se afişeze numele departamentului și cel mai mic salariu din departamentul avand cel mai mare salariu mediu.
SELECT
    D.DEPARTMENT_NAME, MIN(E.SALARY)
FROM EMPLOYEES E
JOIN DEPARTMENTS D on D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING AVG(E.SALARY) = (
    SELECT
        MAX(AVG(SALARY))
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    );

-- 10. Să se afișeze codul, numele departamentului, numărul de angajați și salariul mediu din departamentul respectiv, împreună cu numele, salariul și jobul angajaților din acel departament. Se vor afişa şi departamentele fără angajați.
SELECT
    T.DEPARTMENT_ID, D.DEPARTMENT_NAME, T.CNT, T.SAL, E.EMPLOYEE_ID, E.SALARY, E.JOB_ID
FROM EMPLOYEES E
JOIN (
        SELECT
            E2.DEPARTMENT_ID, COUNT(*) CNT, AVG(E2.SALARY) SAL
        FROM EMPLOYEES E2
        GROUP BY E2.DEPARTMENT_ID
    )T ON E.DEPARTMENT_ID = T.DEPARTMENT_ID
JOIN DEPARTMENTS D on E.DEPARTMENT_ID = D.DEPARTMENT_ID;
