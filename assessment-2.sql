-- ASSESSMENT TEST 2 --

-- 1. Retrieve all information from cd.facilities
select * 
from cd.facilities;

-- 2. Retrieve list of facilities and member costs
select name, membercost 
from cd.facilities;

-- 3. Produce a list of facilities that charge a fee to members
select * 
from cd.facilities
where membercost > 0;

-- 4. Produce a list of facilities that charge a fee to members,
--    the fee is less than 1/50th of the monthly maintenance cost
--    Return facid, facility name, member cost and monthly maint.
select facid, name, membercost, monthlymaintenance 
from cd.facilities
where membercost != 0
and membercost < (monthlymaintenance/50);

-- 5. Produce list of all facilities with the word 'Tennis' in name
select * 
from cd.facilities
where name like '%Tennis%';

-- 6. Retrieve the details of facilities with ID 1 and 5
select * 
from cd.facilities
where facid in (1, 5);

-- 7. Produce a list of members who joined after the start of Sep.
--    2012. Return memid, surname, firstname and joindate
select memid, surname, firstname, joindate
from cd.members
where joindate >= '2012-09-01';

-- 8. Produce an ordered list of first 10 member surnames
--    Must not contain duplicates
select distinct surname
from cd.members
order by surname
limit 10;

-- 9. Retrieve the signup date from last member
select joindate 
from cd.members
order by joindate desc
limit 1;
-- or
select max(joindate) 
from cd.members;

-- 10. Produce count of num. of facilities with cost to guests
--     10 or more.
select count(*) 
from cd.facilities
where guestcost >= 10;

-- 11. Produce a list of the total number of slots booked per
--     facility in the month of Sep. 2012.
--     Produce an output table consisting of facility id and slots
--     sorted by the number of slots.
select facid, sum(slots) as total_slots
from cd.bookings
where starttime >= '2012-09-01'
and starttime <= '2012-10-01'
group by facid
order by total_slots;

-- 12. Produce a list of facilities with more than 1000 slots 
--     booked.
--     Produce an output table consisting of facility id and
--     total slots, sorted by facility id.
select facid, sum(slots) as total_slots
from cd.bookings
group by facid
having sum(slots) > 1000 
order by facid;

-- 13. Produce a list of the start times for bookings for tennis 
--     courts, for the date '2012-09-21'.
--     Return a list of start time and facility name pairings
--     ordered by the time.
select starttime, fcts.name  
from cd.bookings as bks
inner join cd.facilities as fcts
on bks.facid = fcts.facid
where to_char(starttime, 'YYYY-MM-DD') = '2012-09-21'
and fcts.name like 'Tennis Court _'
order by starttime;

-- 14. Produce a list of start times for bookings by members
--     named 'David Farrell'
select starttime
from cd.bookings as bks
inner join cd.members as mbs
on bks.memid = mbs.memid
where firstname = 'David'
and surname = 'Farrell';

