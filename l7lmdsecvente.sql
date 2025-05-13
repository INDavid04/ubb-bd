--------------
-- La clasa --
--------------

--COMANDA INSERT
CREATE TABLE JUCATORI_LAB_NOU (
    ID_JUCATOR NUMBER(10),
    NUME VARCHAR2(10),
    SALARIU NUMBER(10) DEFAULT 500
);

INSERT INTO JUCATORI_LAB_NOU (ID_JUCATOR, NUME, SALARIU)
VALUES (1, 'A', 1000); -- SE VA INSERA JUCATORUL (1, A, 1000)

INSERT INTO JUCATORI_LAB_NOU (ID_JUCATOR, NUME)
VALUES (2, 'B'); -- SE VA INSERA JUCATORUL (2, B, 500)

INSERT INTO JUCATORI_LAB_NOU (ID_JUCATOR, NUME, SALARIU)
VALUES (3, 'C', NULL); -- SE VA INSERA JUCATORUL (3, C, NULL)

INSERT INTO JUCATORI_LAB_NOU
VALUES (4, 'D', NULL); -- SE VA INSERA JUCATORUL (4, D, NULL)

---------------
-- Exercitii --
---------------

-- 1. Să se insereze departamentul 300, cu numele Programare în DEPT_pnu (copie a tabelului Departments). Analizaţi cazurile, precizând care este soluţia corectă şi explicând erorile celorlalte variante. Pentru a anula efectul instrucţiunii(ilor) corecte, utilizaţi comanda ROLLBACK. (a) INSERT INTO DEPT_pnu VALUES (300, ‘Programare’); (b) INSERT INTO DEPT_pnu (department_id, department_name) VALUES (300, ‘Programare’); (c) INSERT INTO DEPT_pnu (department_name, department_id) VALUES (300, ‘Programare’); (d) INSERT INTO DEPT_pnu (department_id, department_name,  location_id) VALUES (300, ‘Programare’, null); (e) INSERT INTO DEPT_pnu (department_name, location_id) VALUES (‘Programare’, null);
CREATE TABLE D_pnu AS SELECT * FROM DEPARTMENTS;
-- CAND CREAM UN TABEL CU ACEASTA METODA SE COPIAZA STRUCTURA DEFINITA DE CAMPURILE DIN CLAUZA SELECT SI NUMAI CONSTRANGERILE DE TIP NOT NULL AFERENTE ACESTOR CAMPURI IN TABELUL/TABELELE DIN CLAUZA FROM

INSERT INTO D_pnu
VALUES (300, 'Programare', null, null); --EROARE: NOT ENOUGH VALUES;
--NU ESTE SPECIFICATA LISTA DE COLOANE, DECI BY DEFAULT SUNT LUATE IN CONSIDERARE TOATE COLOANELE
--SOLUTIE:
--  SE DAU VALORI PENTRU TOATE CELE 4 COLOANE
--  SE DAU VALORI DOAR PENTRU CELE 2 COLOANE MENTIONATE, RESPECTANDU-SE TOATE CONSTRANGERILE TABELULUI

INSERT INTO D_pnu (department_id, department_name)
VALUES (300, 'Programare'); --OK; COLOANELE CARE NU AU FOST PRECIZATE VOR PRIMI NULL (ATENTIE LA CONSTRANGERI)

INSERT INTO D_pnu (department_name, department_id)
VALUES ('Programare', 300);
--  OK; SE POATE MODIFICA ORDINEA COLOANELOR; IMPORTANT ESTE SA COINCIDA CA TIP DE DATE (SAU SA SE POATA FACE CONVERSIE IMPLICITA A TIPULUI DE DATE)
--      DE ASEMENEA, DEOARECE NU A FOST DEFINITA CHEIE PRIMARA, SE POATE INTRODUCE UN NOU DEPARTAMENT CU ID-UL 300

INSERT INTO D_pnu (department_id, department_name, location_id)
VALUES (300, 'Programare', null); --OK;

INSERT INTO D_pnu (department_name, location_id)
VALUES ('Programare', null); --OK; COLOANELE CARE NU AU FOST PRECIZATE VOR PRIMI NULL (ATENTIE LA CONSTRANGERI)
-- ATENTIE LA URMATORUL ASPECT! DACA PE COLOANA DEPARTMENT_ID S-AR FI DEFINIT CONSTRANGERE DE CHEIE PRIMARA ATUNCI AR FI FOST EROARE
        --COLOANA DEPARTMENT_ID NU A FOST PRECIZATA, DECI BY DEFAULT PRIMESTE NULL
        --DAR ACEASTA ESTE CHEIA PRIMARA A TABELULUI, IAR CHEIA PRIMARA NU POATE FI NULL

-- 2.  Încercaţi dacă este posibilă introducerea unui angajat, precizând pentru valoarea employee_id o subcerere care returnează (codul maxim +1).
CREATE TABLE E_PNU AS SELECT * FROM EMPLOYEES;

INSERT INTO E_PNU (employee_id, last_name, email, hire_date, job_id, salary, commission_pct) -- S-AU SPECIFICAT COLOANELE CARE AU CONSTRANGERE DE TIP NOT NULL
VALUES (    (
                SELECT MAX(EMPLOYEE_ID) + 1
                FROM EMPLOYEES
            ),
        'NUME', 'nume@emp.com',SYSDATE, 'SA_REP', 5000, NULL);

-- 3. Creaţi un nou tabel, numit EMP1_PNU, care va avea aceeaşi structură ca şi EMPLOYEES, dar nicio înregistrare. Copiaţi în tabelul EMP1_PNU salariaţii (din tabelul EMPLOYEES) al căror salariu este cel puțin 10000.
CREATE TABLE EMP_COPY AS
    SELECT *
    FROM EMPLOYEES
    WHERE 1 = 0;

INSERT INTO EMP_COPY
    SELECT *
    FROM EMPLOYEES
    WHERE SALARY >= 10000;

-- 4. Să se creeze tabelele necesare cu aceeaşi structură ca a tabelului EMPLOYEES (fără constrângeri şi fără înregistrări). Copiaţi din tabelul EMPLOYEES:
-- în tabelul EMP0_PNU salariaţii care lucrează în departamentul 80;
-- în tabelul EMP1_PNU salariaţii care au salariul mai mic decât 5000;
-- în tabelul EMP2_PNU salariaţii care au salariul cuprins între 5000 şi 10000;
-- în tabelul EMP3_PNU salariaţii care au salariul mai mare decât 10000. Dacă un salariat se încadrează în tabelul emp0_pnu atunci acesta nu va mai fi inserat şi în alt tabel (tabelul corespunzător salariului său).
CREATE TABLE EMP0_COPY AS
    SELECT *
    FROM EMPLOYEES
    WHERE 1 = 0;

CREATE TABLE EMP1_COPY AS
    SELECT *
    FROM EMPLOYEES
    WHERE 1 = 0;

CREATE TABLE EMP2_COPY AS
    SELECT *
    FROM EMPLOYEES
    WHERE 1 = 0;

CREATE TABLE EMP3_COPY AS
    SELECT *
    FROM EMPLOYEES
    WHERE 1 = 0;

INSERT FIRST
    WHEN DEPARTMENT_ID = 80 THEN INTO EMP0_COPY
    WHEN SALARY < 5000 THEN INTO EMP1_COPY
    WHEN SALARY >= 5000 AND SALARY <= 10000 THEN INTO EMP2_COPY
    WHEN SALARY > 10000 THEN INTO EMP3_COPY
SELECT * FROM EMPLOYEES;

INSERT ALL
    WHEN DEPARTMENT_ID = 80 THEN INTO EMP0_COPY
    WHEN SALARY < 5000 AND DEPARTMENT_ID <> 80 THEN INTO EMP1_COPY
    WHEN SALARY > 5000 AND SALARY < 10000 AND DEPARTMENT_ID <> 80 THEN INTO EMP2_COPY
    WHEN SALARY > 10000 AND DEPARTMENT_ID <> 80 THEN INTO EMP3_COPY
SELECT *
FROM EMPLOYEES;

--------------------
-- COMANDA UPDATE --
--------------------

UPDATE E_pnu
SET (SALARY, COMMISSION_PCT) = (
    SELECT
        1000, NULL
    FROM DUAL
)
WHERE EMPLOYEE_ID = 100;

UPDATE E_pnu
SET SALARY = 1000, COMMISSION_PCT = NULL
WHERE EMPLOYEE_ID = 100;

-- 5. Măriţi salariul tuturor angajaţilor din tabelul EMP_PNU cu 5%. Vizualizati, iar apoi anulaţi modificările.
UPDATE E_pnu
SET SALARY = SALARY * 1.05;

-- 6. Să se promoveze Douglas Grant la manager în departamentul 20, având o creştere de salariu cu 1000$. Se poate realiza modificarea prin intermediul unei singure comenzi?
UPDATE E_pnu
SET SALARY = SALARY + 1000
WHERE UPPER(FIRST_NAME) = 'DOUGLAS' AND
      UPPER(LAST_NAME) = 'GRANT';

UPDATE D_pnu
SET MANAGER_ID = (
        SELECT EMPLOYEE_ID
        FROM EMPLOYEES
        WHERE UPPER(FIRST_NAME) = 'DOUGLAS' AND
                UPPER(LAST_NAME) = 'GRANT'
    )
WHERE DEPARTMENT_ID = 20;

-- 7. Să se modifice jobul şi departamentul angajatului având codul 114, astfel încât să fie la fel cu cele ale angajatului având codul 205.
UPDATE E_PNU
SET (JOB_ID, DEPARTMENT_ID) = (
        SELECT JOB_ID, DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 205
    )
WHERE EMPLOYEE_ID = 114;

-------------------
--COMANDA DELETE --
-------------------

DELETE FROM E_pnu
WHERE SALARY < 5000;

DELETE FROM EMPLOYEES;
TRUNCATE TABLE EMPLOYEES;
--CELE 2 COMENZI DE MAI SUS PRODUC ACELASI EFECT (STERGEREA DATELOR DIN TABEL)
--DIFERENTA: DUPA EXECUTAREA LUI TRUNCATE SE INCHEIE O TRANZACTIE SI SE PERMANENTIZEAZA MODIFICARILE (COMMIT IMPLICIT)

-- 8. Ştergeţi toate înregistrările din tabelul DEPT_PNU. Ce înregistrări se pot şterge? Anulaţi modificările.
DELETE FROM DEPARTMENTS; --EROARE: integrity constraint violated - child record found

--DIN CAUZA FOREIGN KEY-ULUI STABILIT INTRE TABELELE DEPARTMENTS SI EMPLOYEES,
--POT FI STERSE DOAR ACELE INREGISTRARI CARE NU APAR IN TABELUL COPIL(EMPLOYEES)

DELETE FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN
      (
        SELECT DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID IS NOT NULL --ACEASTA CONDITIE S-A ADAUGAT DEOARECE EXISTA ANGAJATI FARA DEPARTAMENT,
            -- IAR ATUNCI CAND SE VERIFICA DEP_ID NOT IN (10, 20, NULL, ...) REZULTATUL VA FI UNKNOWN, NU TRUE/FALSE
    );

DELETE FROM DEPARTMENTS D
WHERE (
        SELECT COUNT(*)
        FROM EMPLOYEES E
        WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
          ) = 0;

-- 9. Ştergeţi angajaţii care nu au comision. Anulaţi modificările.
DELETE FROM E_PNU
WHERE COMMISSION_PCT IS NULL;

--------------
-- SECVENTE --
--------------

-- 10. Creaţi o secvenţă pentru generarea codurilor de departamente, SEQ_DEPT_PNU. Secvenţa va începe de la 400, va creşte cu 10 de fiecare dată şi va avea valoarea maximă 10000, nu va cicla şi nu va încărca nici un număr înainte de cerere.
CREATE SEQUENCE SEQ_DEPT
START WITH 400
INCREMENT BY 10
MAXVALUE 10000
NOCACHE NOCYCLE ;

SELECT SEQ_DEPT.currval FROM DUAL;

-- 11. Creaţi o secvenţă pentru generarea codurilor de angajaţi, SEQ_EMP_PNU. Să se modifice toate liniile din EMP_PNU (dacă nu mai există, îl recreeaţi), regenerând codul angajaţilor astfel încât să utilizeze secvenţa SEQ_EMP_PNU şi să avem continuitate în codurile angajaţilor.
CREATE SEQUENCE SEQ_EMP
START WITH 1
MAXVALUE 21
CYCLE ;

UPDATE EMPLOYEES
SET SALARY = SEQ_EMP.nextval;

-- 12. Ștergeți secvența SEQ_DEPT_PNU.
DROP SEQUENCE SEQ_DEPT;

----UTILIZARE SECVENTE PENTRU INSERARE DATE

CREATE TABLE TEST_SECV_INSERT (
    COL1 NUMBER(10) PRIMARY KEY,
    COL2 NUMBER(10)
)

CREATE SEQUENCE SECV_INSERT
START WITH 1
INCREMENT BY 1;

INSERT INTO TEST_SECV_INSERT
VALUES (SECV_INSERT.nextval, 1000);

INSERT INTO TEST_SECV_INSERT
VALUES (SECV_INSERT.nextval, 2000);

INSERT INTO TEST_SECV_INSERT
VALUES (SECV_INSERT.nextval, 3000);

INSERT INTO TEST_SECV_INSERT
VALUES (SECV_INSERT.nextval, 4000);

SELECT * FROM TEST_SECV_INSERT;
-- 1,1000
-- 2,2000
-- 3,3000
-- 4,4000
-- ATENTIE, daca pentru un insert a aparut eroare, valoarea secventei tot va creste
