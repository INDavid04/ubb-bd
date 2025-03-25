--1--
select first_name || concat(' ',last_name) || ' castiga ' || salary || ' lunar dar doreste ' || salary * 3 as "Salariu ideal" from employees; 

--2--
select
    initcap(first_name),
    upper(first_name), 
    length(first_name)
from employees
where first_name like 'J_A'or first_name like 'M_A'
order by length(first_name) desc;

--5--
select
    first_name,
    hire_date,
    sysdate - hire_date
from employees
where mod(round(sysdate - hire_date), 7) = 0;
