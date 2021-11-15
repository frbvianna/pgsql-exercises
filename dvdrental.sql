---- STATEMENT FUNDAMENTALS ----
-- CHALLENGE 1 --
-- How many payment transactions were greater than $5.00?

select count(*) from public.payment where amount > 5.00;

-- How many actors have a first name that starts with the letter P?

select count(*) from public.actor where first_name like 'P%';

-- How many unique districts are our customers from?

select distinct district from public.address order by district asc;

-- How many films have a rating of R and a replacement cost
-- between $5 and $15?

select count(*) from public.film
where rating = 'R' 
and replacement_cost between 5.00 and 15.00;

-- How many films have the word Truman somewhere in the title?

select count(distinct title) from public.film
where title like '%Truman%';

-- AGGREGATION FUNCTIONS --

select min(replacement_cost) from film;
select max(replacement_cost) from film;
select round(avg(replacement_cost), 2) from film;
select sum(replacement_cost) from film;

-- STATEMENT GROUP BY --
-- CHALLENGE -- 

-- Count number of payments each staff handled

select staff_id, count(*) from public.payment 
group by staff_id 
order by count(*);

-- Average replacement cost per MPAA rating

select rating, round(avg(replacement_cost), 2) from public.film
group by rating
order by round(avg(replacement_cost), 2);

-- Customer IDs of the top 5 customers by total spend

select customer_id, sum(amount) from public.payment
group by customer_id
order by sum(amount) desc
limit 5;

-- HAVING --
-- CHALLENGE --

-- Customer IDs that have had 40 or more transaction payments

select customer_id, count(customer_id) 
from public.payment
group by customer_id
having count(customer_id) >= 40;

-- Customer IDs of customers who have spent more than $100
-- with staff_id member 2

select staff_id, customer_id, sum(amount) 
from public.payment
where staff_id = 2
group by staff_id, customer_id
having sum(amount) > 100;

-- ASSESSMENT TEST --
-- 1.
select customer_id, sum(amount) 
from public.payment
where staff_id = 2
group by customer_id
having sum(amount) > 110;

-- 2.
select count(*) 
from public.film
where title like 'J%';

-- 3.
select first_name, last_name 
from public.customer
where first_name like 'E%'
and address_id < 500
order by customer_id desc
limit 1;


---- JOINS ----

-- Aliases
-- Aliases get assigned last
select amount as rental_price
from public.payment;
select sum(amount) as net_revenue
from public.payment;
select count(*) as num_transactions
from public.payment;
select customer_id, sum(amount) as total_spent
from public.payment
group by customer_id
having sum(amount) > 100; -- cannot use total_spent

-- Inner Joins
-- Set of mutual records in tables
select payment_id, payment.customer_id, first_name
from public.payment
inner join public.customer -- could be just join
on payment.customer_id = customer.customer_id;

-- Full Outer Joins
-- Everything from both tables (can then filter to exclusives)
select * 
from public.customer
full outer join public.payment
on customer.customer_id = payment.customer_id
where customer.customer_id is null
or payment.payment_id is null;

-- Left Outer Joins
-- Exclusive to left table or everything from both
select film.film_id, title, inventory_id
from public.film
left outer join inventory 
on inventory.film_id = film.film_id
where inventory.film_id is null;

-- Right Outer Joins
-- Exclusive to right table or everything from both
select film.film_id, title, inventory_id
from public.film
right outer join inventory 
on inventory.film_id = film.film_id
where film.film_id is null;

-- Unions
-- Stacks the tables

-- JOIN CHALLENGES --
-- 1.
select first_name, last_name, email
from public.customer
inner join public.address
on customer.address_id = address.address_id
where address.district = 'California';

-- 2.
select title
from public.film
inner join public.film_actor
on film.film_id = film_actor.film_id
inner join public.actor
on film_actor.actor_id = actor.actor_id
where first_name = 'Nick' and last_name = 'Wahlberg'
order by title asc;


---- ADVANCED SQL COMMANDS ----

show all; 
select now(); 
select current_date;

-- TIMESTAMPS AND EXTRACT -- CHALLENGE
-- During which months did payments occur?
select distinct to_char(payment_date, 'Month')
from public.payment;

select count(*)
from public.payment
where extract(dow from payment_date) = 1;

-- MATHEMATICAL FUNCTIONS
select round(rental_rate/replacement_cost, 2)*100 as percent_cost
from public.film;

-- STRING FUNCTIONS
select length(first_name)
from public.customer;

select upper(first_name) || ' ' || upper(last_name) 
as full_name
from public.customer;

select lower(left(first_name, 1)) || lower(last_name) || '@gmail.com'
as generated_email
from public.customer;

-- SUBQUERY
select title, rental_rate
from public.film
where rental_rate > (select avg(rental_rate) from public.film);

select film_id, title
from public.film
where film_id in
(select inventory.film_id
 from public.rental
 inner join public.inventory 
 on inventory.inventory_id = rental.inventory_id
 where return_date between '2005-05-29' and '2005-05-30')
order by film_id;

select first_name, last_name
from public.customer as c
where exists
(select * from public.payment as p
 where p.customer_id = c.customer_id
 and amount > 11)
order by first_name;
-- same as
select first_name, last_name
from public.customer as c
inner join public.payment as p
on p.customer_id = c.customer_id
where amount > 11
order by first_name;

-- SELF-JOINS 
select (p1.amount-p2.amount) 
from public.payment as p1
inner join public.payment as p2
on p1.payment_id = p2.payment_id



