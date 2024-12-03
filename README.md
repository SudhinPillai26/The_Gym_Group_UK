# The Gym Group UK SQL Project

![The Gym Group](https://www.hassra.org.uk/images/pictures/products/the-gym-group-tile-(1200x630-ffffff).png?v=ae337b18) 

Welcome to my SQL project, where I analyze real-time gym data from **The Gym Group UK**! This project uses a dataset of **10,000 visit records** to explore and analyze gym membership and visit data, answering key business questions that can help a fitness center understand its customer base better and optimize its services.

## Table of Contents
- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Database Schema](#database-schema)
- [Business Problems](#business-problems)
- [SQL Queries & Analysis](#sql-queries--analysis)
- [Getting Started](#getting-started)
- [Questions & Feedback](#questions--feedback)
- [Contact Me](#contact-me)

---

## Introduction

This project aims to demonstrate essential SQL skills by analyzing a dataset from The Gym Group UK Gym. Using SQL, I explored membership details, member demographics, and visit patterns to derive actionable insights. This project showcases fundamental SQL techniques, including creating tables, writing queries, and analyzing data.

## Project Structure

1. **SQL Scripts**: Code to create the database schema and queries for analysis.
2. **Dataset**: Real-time data on gym visits, membership, and member demographics.
3. **Analysis**: SQL queries solving practical business problems, each one crafted to address specific questions.

---

## Database Schema

Here’s an overview of the database structure:

### 1. **Members Table**
- **member_id**: Unique identifier for each member
- **name**: Name of the member

### 2. **Memberships Table**
- **member_id**: Unique identifier linked to the `members` table
- **age**: Age of the member
- **gender**: Gender of the member ('M' or 'F')
- **membership_type**: Type of membership (e.g., Monthly, Quarterly)
- **join_date**: Date when the member joined
- **status**: Membership status (e.g., Active, Cancelled)

### 3. **Visits Table**
- **visit_id**: Unique identifier for each visit
- **member_id**: Linked to the `members` table
- **visit_date**: Date of the visit
- **check_in_time**: Check-in time of the visit
- **check_out_time**: Check-out time of the visit

## Business Problems

The following queries were created to solve specific business questions. Each query is designed to provide insights based on gym membership and visit data.

1. Retrieve the **name** and **membership_type** of female members.
```sql

select 
	members.name,
	memberships.gender,
	memberships.membership_type

From members
Inner Join memberships
ON members.member_id = memberships.member_id
Where memberships.gender = 'F';

```
3. Find members who have a **Monthly membership** and joined after **2023-11-01**.
```sql

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

```
4. List the **name** and **status** of active members over **25**.
```sql

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

```
5. Get details of **visits** on a specific date (**2024-01-01**).
```sql

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

```
6. List members with a **Quarterly membership** aged between **20 and 30**.
```sql

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

```
6. Count total visits made by each member.
```sql

select 
	members.name,
	members.member_id,
	count(visits.visit_id) as total_visits
from visits
inner join members
on members.member_id = visits.member_id
Group by 2
Order by 3 Desc;

```
7. Count members by membership type (e.g., Monthly, Weekly, Quarterly).
```sql

select 
	membership_type,
	count(*) as total_members_enrolled
from memberships
Group By 1;

```
9. Calculate the average age of members, grouped by membership type.
```sql

select
	membership_type,
	avg(age) as average_members_age
	
from memberships
Group by 1;

```
10. Total visits for each visit date.
```sql

select 
	visit_date,
	count(*) as total_visits
from visits
Group by visit_date
Order by 1;

```
12. Count members by status (e.g., Active or Cancelled).
```sql

select  
	status,
	count(*) as count_of_members
from memberships
Where status is not null
Group by 1;

```
11. Top 3 members with the highest visits.
```sql

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

```
12. Active Monthly members grouped by membership type, sorted by recent join dates.
```sql

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

```
14. Members with more than 2 visits, sorted by total visits, displaying the top 5.
```sql

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

```
15. Members who joined in 2023, grouped by membership type (where each group has >1 member).
```sql

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

```

16. Average age of active members, grouped by membership type, limited to the top 3 results.
```sql
select 
	membership_type,
	avg(age) as average_age
from memberships
Where status = 'Active'
Group by 1
Order by 2 Asc;

```
---

## SQL Queries & Analysis

The `analysis.sql` file contains all SQL queries developed for this project. Each query corresponds to a business problem and demonstrates skills in SQL syntax, data filtering, aggregation, grouping, and ordering.

## Getting Started

### Prerequisites
- PostgreSQL (or any SQL-compatible database)
- Basic understanding of SQL

### Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/fitpro-gym-sql-project.git
   ```
2. **Set Up the Database**:
   - Run the `TheGymGroup_Schemas.sql` script to set up tables and insert sample data.

3. **Run Queries**:
   - Execute each query in `analysis.sql` to explore and analyze the data.

---

## Questions & Feedback

If you have any questions or feedback, feel free to create an issue or reach out!

---

## Contact Me
  
📧 **[Email](mailto:sudhinpillai1998@gmail.com)**  
📞 **Phone**: +44 7909308158  
