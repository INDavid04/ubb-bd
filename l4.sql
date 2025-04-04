-- TODO: add 1-9 requirements

-- 9. Sa se obtina numele angajatilor care castiga unul dintre cele mai mari 7 salarii. Rezultatul se va afişa în ordine crescătoare a salariilor.
-- TODO: solve the error: 
SELECT FIRST_NAME, LASTA_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY IN (
    SELECT SALARY
    FROM EMPLOYEES
    ORDER BY SALARY DESC 
)
ORDER BY SALARY;

SELECT FIRST_NAME, LAST_NAME,  SALARY
FROM EMPLOYEES
WHERE SALARY IN (
    SELECT SALARY
    FROM EEMPLOYEES
    ORDER BY SALARY DESC
)
WHERE ROWNUM <= 7;

-- 10. Afișați informații despre angajații care castiga cel de-al 7-lea salariu.
-- Ca idee, cum facem sa ajungem la a saptelea salariu? Am elimina primele sase. Dar cum? 
