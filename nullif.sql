-- NULLIF FUNCTION
delete from public.depts
where department = 'B';

-- Returns an error "division by zero": no 'B' dept.
-- Use nullif() to substitute a result for [null]
select
sum (
	case 
		when department = 'A' then 1
		else 0 
	end
)
/ -- divide the two sums (A:B dept. ratio)
nullif(
sum (
	case
		when department = 'B' then 1
		else 0
	end
), 0) as department_ratio
from public.depts;

