select count(*) from customers;   --392
select max(customer_id) from customers; --392

--creare tabel test, inserare date test
create table customers2 
as 
select customer_id, email_address, full_name
from customers;

BEGIN
    FOR i IN 1..100000 LOOP  
        INSERT INTO CUSTOMERS2(customer_id, email_address, full_name)
        SELECT 392 * i + customer_id, 
               to_char(i + 1) ||  email_address, 
               full_name || ' the ' ||  to_char(i + 1) || 'th'
        FROM customers;

         COMMIT; 
    END LOOP;
END;
/

--teste timp de executie fara index
select count(*) from customers2;
--30s   pentru 39200392

select * 
from customers2 
where customer_id = 10017186;
--27s

select * 
from customers2 
where full_name
= 'Russell Rivera the 25555th';
--30s

--creare tabel test cu index
create table customers2i as select * from customers2;

alter table customers2i 
add primary key (customer_id);

create index 
idx_customers2i_name 
on customers2i(full_name);

--teste timp de executie cu index
select count(*) from customers2i;

select * from customers2i where customer_id = 10017186;
--<1s

select * 
from customers2i 
where full_name 
= 'Russell Rivera the 25555th';
--<1s

drop table customers2;
drop table customers2i;



create table customers_no_index as select * from customers;
create table orders_no_index as select * from orders;
create table shipments_no_index as select * from shipments;
create table order_items_no_index as select * from order_items;
create table inventory_double_index as select * from inventory;



create index inventory_product_store_i ON inventory_double_indexed (product_id, store_id);

/*
CREATE INDEX customers_name_i          ON customers   ( full_name );
CREATE INDEX orders_customer_id_i     
 ON orders      ( customer_id );

CREATE INDEX orders_store_id_i         ON orders      ( store_id );
CREATE INDEX shipments_store_id_i      ON shipments   ( store_id );
CREATE INDEX shipments_customer_id_i   ON shipments   ( customer_id );
CREATE INDEX order_items_shipment_id_i ON order_items ( shipment_id );


CREATE INDEX inventory_product_id_i 
   ON inventory   ( product_id );
*/

SELECT INDEX_NAME, INDEX_TYPE
FROM USER_INDEXES
WHERE TABLE_NAME = 'CUSTOMERS';

--NORMAL INDEX B-TREE

--INDEX UNIQUE_SCAN
select * from customers where customer_id = 19;
select * from customers_no_index where customer_id = 19;

--INDEX RANGE SCAN
select * 
from customers 
where full_name = 'Kristina Nunez';  



--not unique
select * from customers_no_index where full_name = 'Kristina Nunez';

select * from shipments where shipment_id between 1100 and 1200;
select * from shipments_no_index where shipment_id between 1100 and 1200;  

select * from order_items where shipment_id = 1100;  
--not unique


--INDEX FULL SCAN
select * 
from inventory 
order by inventory_id desc; 
select * from inventory_no_index order by inventory_id desc; 



drop table customers_bk;
drop table orders_not_indexed;
drop table shipments_not_indexed;
drop table order_items_not_indexed;
drop table inventory_double_indexed;


