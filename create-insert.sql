-- CREATING DATABASES AND TABLES --

create table if not exists public.account (
	user_id serial primary key,
	username varchar(50) unique not null,
	password varchar(50) not null,
	email varchar(250) unique not null,
	created_on timestamp not null,
	last_login timestamp
);

create table if not exists public.job (
	job_id serial primary key,
	job_name varchar(200) unique not null
);

create table if not exists public.account_job (
	user_id integer references public.account(user_id),
	job_id integer references public.job(job_id),
	hire_date timestamp
);


-- INSERTING INTO TABLES --
insert into public.account (
	username, 
	password,
	email,
	created_on
) values (
	'Jose',
	'p4ssw0rd',
	'jose@mail.com',
	current_timestamp
);

insert into public.job (
	job_name
) values (
	'Astronaut'
);

insert into public.job (
	job_name
) values (
	'President'
);

insert into public.account_job (
	user_id,
	job_id,
	hire_date
) values (
	1,
	1,
	current_timestamp
);
