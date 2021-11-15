-- VIEWS

create or replace view customer_info as -- add query
select first_name, last_name, address, district
from public.customer as c
inner join public.address as a
on c.address_id = a.address_id;

select * from public.customer_info;
