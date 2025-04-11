-- 1. Să se determine numărul de angajaţi care sunt şefi.
SELECT
    COUNT(DISTINCT MANAGER_ID)
FROM EMPLOYEES;

-- 2. Să se afişeze codul şi numele angajaţilor care câștigă mai mult decât salariul mediu din firmă.

-- 3. Pentru fiecare şef, să se afişeze codul său şi salariul celui mai prost plătit subordonat. Se vor exclude cei pentru care codul managerului nu este cunoscut. De asemenea, se vor exclude grupurile în care salariul minim este mai mic de 4000$. Sortaţi rezultatul în ordine descrescătoare a salariilor.

-- 4. Să se afişeze maximul salariilor medii pe departamente. Obs: Într-o imbricare de funcţii agregat, criteriul de grupare specificat în clauza GROUP BY se referă doar la funcţia agregat cea mai interioară. Astfel, într-o clauză SELECT în care există funcţii agregat imbricate nu mai pot apărea alte expresii.

-- 5. Scrieți o cerere pentru a afișa, pentru departamentele avand codul > 80, salariul total pentru fiecare job din cadrul departamentului. Se vor afișa numele departamentului, jobul și suma salariilor. Se vor eticheta coloanele corespunzător.

-- 6. Să se calculeze comisionul mediu din firmă, luând în considerare toate liniile din tabel.

-- 7. Sa se afiseze codul, numele departamentului și numărul de angajați care lucrează în acel departament, pentru departamentele în care lucrează mai puțin de 4 angajați
SELECT
    D.DEPARTMENT_ID, D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID)
FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
HAVING COUNT(E.EMPLOYEE_ID) < 4;

-- 8. Să se obțină codul, titlul şi salariul mediu al job-ului pentru care salariul mediu este minim.

-- 9. Să se afişeze numele departamentului și cel mai mic salariu din departamentul avand cel mai mare salariu mediu.

-- 10. Să se afișeze codul, numele departamentului, numărul de angajați și salariul mediu din departamentul respectiv, împreună cu numele, salariul și jobul angajaților din acel departament. Se vor afişa şi departamentele fără angajați.
-- Initial:
    -- SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID), AVG(J.MIN_SALARY, J.MAX_SALARY), E.FIRST_NAME, E.LAST_NAME, E.SALARY, E.JOB_ID
    -- FROM EMPLOYEES E
    -- JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    -- JOIN JOBS J ON (E.JOB_ID = J.JOB_ID);
-- 10. Să se afișeze codul, numele departamentului, numărul de angajați și salariul mediu din departamentul respectiv, împreună cu numele, salariul și jobul angajaților din acel departament. Se vor afişa şi departamentele fără angajați.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID), (J.MIN_SALARY + J.MAX_SALARY) / 2, E.FIRST_NAME, E.LAST_NAME, E.SALARY, E.JOB_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
JOIN JOBS J ON (E.JOB_ID = J.JOB_ID);
-- TODO: vezi pe teams rezolvarea;