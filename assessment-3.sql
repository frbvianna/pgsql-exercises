-- Assessment Test 3

create table if not exists public.students (
	student_id serial primary key,
	first_name varchar(45) not null,
	last_name varchar(45) not null,
	homeroom_number integer,
	phone varchar(20) unique not null,
	email varchar(115) unique,
	grad_year integer
);

create table public.teachers (
	teacher_id serial primary key,
	first_name varchar(45) not null,
	last_name varchar(45) not null,
	homeroom_number integer,
	department varchar(45),
	email varchar(20) unique,
	phone varchar(20) unique
);

insert into public.students (
	first_name,
	last_name,
	homeroom_number,
	phone,
	grad_year
) values (
	'Mark',
	'Watney',
	5,
	'7755551234',
	2035
);

insert into public.teachers (
	first_name,
	last_name,
	homeroom_number,
	department,
	email,
	phone
) values (
	'Jonas',
	'Salk',
	5,
	'Biology',
	'jsalk@school.org',
	'7755554321'
);
