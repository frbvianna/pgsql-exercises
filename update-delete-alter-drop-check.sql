-- UPDATE TABLES

update public.account
set last_login = current_timestamp;

update public.account
set last_login = current_timestamp
returning email, created_on, last_login;

update public.account_job
set hire_date = created_on
from public.account
where public.account_job.user_id = public.account.user_id
returning hire_date;


-- DELETE ROWS FROM TABLE

insert into public.job (
	job_name
) values (
	'Cowboy'
);
delete from public.job
where job_name = 'Cowboy'
returning job_id, job_name;


-- ALTER TABLE

/*-- Create table and alter its name
create table if not exists public.information (
	info_id serial primary key,
	title varchar(500) not null,
	person varchar(50) unique not null
);
alter table public.information
rename to new_information;
*/--

select * from public.new_information;

/*-- Try to insert but leave null value for constrained column
  -- Alter table removing the null constraint for the column
insert into public.new_information (
	title
) values (
	'some new title'
);
alter table public.new_information
alter column people drop not null;
*/--


-- DROP TABLE
-- Can use 'if exists', 'cascade' etc.

alter table public.new_information
drop column if exists person;


-- CHECK CONSTRAINT

create table if not exists public.employees (
	emp_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birthdate date check(birthdate > '1900-01-01'),
	hire_date date check(hire_date > birthdate),
	salary integer check(salary > 0)
);

insert into public.employees (
	first_name,
	last_name,
	birthdate,
	hire_date,
	salary
) values (
	'Felipe',
	'Vianna',
	'1997-11-03',
	'1998-01-01',
	7000
);