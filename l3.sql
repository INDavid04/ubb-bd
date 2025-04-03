-- 1. Să se listeze job-urile angajaților care lucrează în departamentul 30.
SELECT
    J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J ON(E.JOB_ID = J.JOB_ID)
JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

-- 2. Să se afişeze numele salariatului şi numele departamentului pentru toţi salariaţii care au litera A inclusă în nume.
SELECT
    E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON(E.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHERE UPPER(E.FIRST_NAME) LIKE '%A%';

-- 3. Să se afişezenumele, job-ul, codul şi numele departamentului pentru toţi angajaţii care lucrează în Oxford.

-- 4. Sa se determine codurile angajatilor si numele job-urilor al caror salariu este mai mare decat 3000 sau este egal cu media dintre salariul minim si salariul maxim aferente job-ului respectiv.

-- 5. Sa se afișeze codul departamentului, numele departamentului, numele și job-ul tuturor angajaților din departamentele al căror nume conţine şirul ‘ti’. Rezultatul se va ordona alfabetic după numele departamentului, şi în cadrul acestuia, după numele angajaţilor.

-- 6. Să se afişeze codulangajatului şi numele acestuia, împreună cu numele şi codul şefului său direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.

-- 7. Să se afişeze numele şi data angajării pentru salariaţii care au fost angajaţi după Gates.

-- 8. Sa se afișeze codul şi numele angajaţilor care lucrează în același departament cu cel puţin un alt angajat al cărui nume conţine litera “t”. Se vor afişa, de asemenea, codul şi numele departamentului respectiv. Rezultatul va fi ordonat alfabetic după nume.

-- 9. Sa se afișeze numele, salariul, titlul job-ului, oraşul şi ţara în care lucrează angajatii condusi direct de King.