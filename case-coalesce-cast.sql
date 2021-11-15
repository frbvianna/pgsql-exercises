-- CASE-END STATEMENT

select customer_id,
	case
		when (customer_id <= 100) then 'Premium'
		when (customer_id between 100 and 200) then 'Plus'
		else 'Normal'
	end as customer_class
from public.customer
order by customer_id asc;

select first_name, customer_id,
	case customer_id
		when 2 then 'First place'
		when 5 then 'Second place'
		when 10 then 'Third place'
		else 'Normal'
	end as raffle_results
from public.customer;

select
sum(
	case rental_rate 
		when 0.99 then 1
		else 0
	end
) as bargains,
sum(
	case rental_rate
		when 2.99 then 1
		else 0
	end
) as regular,
sum(
	case rental_rate
		when 4.99 then 1
		else 0
	end
) as premium
from public.film;

select
sum (
	case rating
		when 'R' then 1
		else 0
	end
) as r,
sum (
	case rating
		when 'PG' then 1
		else 0
	end
) as pg,
sum (
	case rating
		when 'PG-13' then 1
		else 0
	end
) as pg13
from public.film;


-- COALESCE FUNCTION
-- Substitutes NULL for something else
-- e.g. mathematical operations


-- CAST FUNCTION
-- Length of digits in an integer
select inventory_id, char_length(cast(inventory_id as varchar)) 
from public.rental;

