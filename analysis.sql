select * from members; 
-- (member_id, name)

select * from memberships;
-- (member_id, age, gender, membership_type, join_date, status)

select * from visits;
-- (visit_id, member_id, visit_date, check_in_time, check_out_time)

-- Business Problems

-- 1. Retrieve the name and membership_type of female members.

select 
	members.name,
	memberships.gender,
	memberships.membership_type

From members
Inner Join memberships
ON members.member_id = memberships.member_id
Where memberships.gender = 'F';

-- 2. Find members who have a Monthly membership and joined after 2023-11-01.

select 
	members.member_id,
	members.name,
	memberships.membership_type,
	memberships.join_date
from members
Inner Join memberships
ON members.member_id = memberships.member_id
Where memberships.membership_type = 'Monthly' and memberships.join_date > '2023-11-01'
Order by 1;

-- 3. List the name and status of active members over 25.

select 
	members.member_id,
	members.name,
	memberships.age,
	memberships.status
from members
Inner Join memberships
On members.member_id = memberships.member_id
Where 
	memberships.status = 'Active' and memberships.age > 25
Order by 1;

-- 4. Get details of visits on a specific date (2024-01-01).

select 
	members.member_id,
	members.name,
	memberships.age,
	memberships.gender,
	memberships.membership_type,
	memberships.status,
	visits.visit_date,
	visits.check_in_time,
	visits.check_out_time
from visits
left join members
on visits.member_id = members.member_id
Inner Join memberships
on memberships.member_id = members.member_id
Where visits.visit_date = '2024-01-01'
Order by 1;

-- 5. List members with a Quarterly membership aged between 20 and 30.
select 
	members.member_id,
	members.name,
	memberships.age,
	memberships.membership_type
from members
Inner join memberships
on members.member_id = memberships.member_id
Where 
	memberships.membership_type = 'Quaterly' and 
	memberships.age Between 20 and 30
Order by 1;

-- 6. Count total visits made by each member.

select 
	members.name,
	members.member_id,
	count(visits.visit_id) as total_visits
from visits
inner join members
on members.member_id = visits.member_id
Group by 2
Order by 3 Desc;

-- 7. Count members by membership type (e.g., Monthly, Weekly, Quarterly).
select 
	membership_type,
	count(*) as total_members_enrolled
from memberships
Group By 1;

-- 9. Calculate the average age of members, grouped by membership type.
select
	membership_type,
	avg(age) as average_members_age
	
from memberships
Group by 1;

-- 10. Total visits for each visit date.

select 
	visit_date,
	count(*) as total_visits
from visits
Group by visit_date
Order by 1;

-- 12. Count members by status (e.g., Active or Cancelled).

select  
	status,
	count(*) as count_of_members
from memberships
Where status is not null
Group by 1;

-- 13. Top 3 members with the highest visits.

select 
	visits.member_id,
	members.name,
	count(*) as total_visits
from visits
Inner Join members
On members.member_id = visits.member_id
Group by 1,2
Order by 3 Desc
Limit 3;

12. Active Monthly members grouped by membership type, sorted by recent join dates.

select 
	members.member_id,
	members.name,
	memberships.membership_type,
	memberships.join_date
from memberships
inner join members
on members.member_id = memberships.member_id
where membership_type = 'Monthly' and status = 'Active'
Group by 1,2,3,4
Order by 4 Desc;

13. Members with more than 2 visits, sorted by total visits, displaying the top 5.

select 
	members.name,
	count(*) as total_visits
from visits
inner join members
on members.member_id = visits.member_id
Group by 1
Having count(*) > 2
Order by 2 Desc
Limit 5;

-- 15. Members who joined in 2023, grouped by membership type (where each group has >1 member).

select 
	memberships.membership_type,
	count(*),
	Extract( Year from memberships.join_date) as joined_date_year
from members
inner join memberships
on members.member_id = memberships.member_id
Where Extract( Year from join_date) = '2023'
Group by 1,3
having count(*) > 1;

-- 16. Average age of active members, grouped by membership type, limited to the top 3 results.
select 
	membership_type,
	avg(age) as average_age
from memberships
Where status = 'Active'
Group by 1
Order by 2 Asc;
