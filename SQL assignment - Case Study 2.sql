----------------------------------------------------------------------Assignment Case Studay 2---------------------------------------------

---Simple Queries
---Q1. List all the employee details?
select * from EMPLOYEE

---Q2. List all the department details?
select * from DEPARTMENT

---Q3. List all job details?
Select * from JOB

---Q4.List all the locations?
Select * from LOCATION

---Q5. List out the First Name, Last Name, Salary, Commission for all Employees?
Select FIRST_NAME,LAST_NAME,SALARY,COMM
from
EMPLOYEE

---Q6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"?
select EMPLOYEE_ID as [ID of the Employee],
LAST_NAME as [Name of the Employee],
DEPARTMENT_ID as [Dep_id]
from
EMPLOYEE

---Q7. List out the annual salary of the employees with their names only?
select FIRST_NAME,LAST_NAME,SALARY * 12 as [Annual salary]
from
EMPLOYEE

------WHERE Condition

---Q1. List the details about "Smith"?
select * from EMPLOYEE where LAST_NAME='SMITH'

---Q2. List out the employees who are working in department 20?
select * from EMPLOYEE
where DEPARTMENT_ID=20

---Q3. List out the employees who are earning salaries between 3000 and 4500?
select * from EMPLOYEE
where SALARY between 3000 and 4500

---Q4. List out the employees who are working in department 10 or 20?
select * from EMPLOYEE
where DEPARTMENT_ID in (10,20)

---Q5. Find out the employees who are not working in department 10 or 30?
select * from EMPLOYEE
where DEPARTMENT_ID not in (10,30)

---Q6. List out the employees whose name starts with 'S'?
select * from EMPLOYEE
where FIRST_NAME like 'S%' or LAST_NAME like 'S%'

---Q7. List out the employees whose name starts with 'S' and ends with 'H'?
select * from EMPLOYEE
where FIRST_NAME like 'S%' or LAST_NAME like '%H'

---Q8. List out the employees whose name length is 4 and start with 'S'?
select * from EMPLOYEE
where (Len(FIRST_NAME) =4 or len(LAST_NAME) = 4)
and (FIRST_NAME like 'S%' or LAST_NAME like 'S%')

---Q9. List out employees who are working in department 10 and draw salaries more than 3500?
select * from EMPLOYEE
where DEPARTMENT_ID=10 and SALARY>3500

---Q10. List out the employees who are not receiving commission ?
Select * from EMPLOYEE
where COMM is null

---------ORDER BY Clause---------
---Q1. List out the Employee ID and Last Name in ascending order based on the Employee ID?
select EMPLOYEE_ID,LAST_NAME
from EMPLOYEE
group by EMPLOYEE_ID,LAST_NAME
order by EMPLOYEE_ID

---Q2. List out the Employee ID and Name in descending order based on salary?
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY
from EMPLOYEE
order by SALARY desc

---Q3. List out the employee details according to their Last Name in ascending-order?
select * from EMPLOYEE
order by LAST_NAME

---Q4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order?
select * from EMPLOYEE
order by LAST_NAME asc,DEPARTMENT_ID desc

select * from EMPLOYEE
order by DEPARTMENT_ID desc

----- GROUP BY and HAVING Clause.
---Q1. How many employees are in different departments in the organization?
select DEPARTMENT_ID, count(*) as [Num of Employee]
from EMPLOYEE
group by DEPARTMENT_ID
order by DEPARTMENT_ID

---Q2. List out the department wise maximum salary, minimum salary and average salary of the employees?
select DEPARTMENT_ID, MIN(SALARY) as [Min Salary], Max(SALARY) as [Max Salary], AVG(SALARY) as [Avg Salary]
from EMPLOYEE
group by DEPARTMENT_ID
order by DEPARTMENT_ID

---Q3. List out the job wise maximum salary, minimum salary and average salary of the employees?
select JOB_ID, MIN(SALARY) as [Min Salary], Max(SALARY) as [Max Salary], AVG(SALARY) as [Avg Salary]
from EMPLOYEE
group by JOB_ID
order by JOB_ID

---Q4. List out the number of employees who joined each month in ascendingorder?
select
Month(HIRE_DATE) as [Hired_Month],
Count(*) as [Num of Employee]
from
EMPLOYEE
group by Month(HIRE_DATE)
order by Hired_Month asc

---Q5. List out the number of employees for each month and year in ascending order based on the year and month?
select
Year(HIRE_DATE) as [Hired_Year],
Month(HIRE_DATE) as [Hired_Month],
Count(*) as [Num of Employee]
from
EMPLOYEE
group by Year(HIRE_DATE), Month(HIRE_DATE)
order by Hired_Year, Hired_Month asc

---Q6. List out the Department ID having at least four employees?
select DEPARTMENT_ID
from EMPLOYEE
group by DEPARTMENT_ID
having count(*)=4

---Q7. How many employees joined in the month of January?
select
count(*) as [Employee joined on January]
from EMPLOYEE
where MONTH(HIRE_DATE)=1
group by month(HIRE_DATE)

---Q8. How many employees joined in the month of January or September?
select
Month(HIRE_DATE) as [Hired_Month],
count(*) as [Employee joined on Jan and Sep]
from EMPLOYEE
where MONTH(HIRE_DATE) in (1,9)
group by month(HIRE_DATE)


---Q9. How many employees joined in 1985?
select
year(HIRE_DATE) as [Hired_Year],
count(*) as [Employess_joined on 1985]
from EMPLOYEE
where year(HIRE_DATE)=1985
group by year(HIRE_DATE)

---Q10. How many employees joined each month in 1985?
select
year(HIRE_DATE) as [Hired_Year],
month(HIRE_DATE) as [Hired_Month],
count(*) as [Employess_joined on 1985]
from EMPLOYEE
where year(HIRE_DATE)=1985
group by year(HIRE_DATE), month(HIRE_DATE)

---Q11. How many employees joined in March 1985?
select
year(HIRE_DATE) as [Hired_Year],
month(HIRE_DATE) as [Hired_Month],
count(*) as [Employess_joined on 1985]
from EMPLOYEE
where year(HIRE_DATE)=1985 and month(HIRE_DATE)=3
group by year(HIRE_DATE), month(HIRE_DATE)

---Q12.Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select DEPARTMENT_ID
from EMPLOYEE
where Month(HIRE_DATE)=4 and 
Year(HIRE_DATE)=1985
group by DEPARTMENT_ID
having count(*)>=3


---------------------Joins-------------------

---Q1. List out employees with their department names?
select * from EMPLOYEE as ED
join DEPARTMENT as D on ED.DEPARTMENT_ID=D.Department_Id

---Q2.Display employees with their designations?
select * from EMPLOYEE as ED
join JOB as J on ED.JOB_ID=J.JOB_ID

---Q3.Display the employees with their department names and regional groups?
select ED.EMPLOYEE_ID,ED.FIRST_NAME,ED.LAST_NAME,ED.JOB_ID,j.DESIGNATION
from EMPLOYEE as ED
join DEPARTMENT as D on ED.DEPARTMENT_ID=d.Department_Id
join JOB as J on ED.JOB_ID=J.JOB_ID

---Q4.How many employees are working in different departments? Display with department names?
select D.Name, Count(ED.EMPLOYEE_ID) as [No of employees]
from DEPARTMENT as D
join EMPLOYEE as ED on D.Department_Id=ED.DEPARTMENT_ID
group by D.Name
order by D.Name

---Q5. How many employees are working in the sales department?
select D.Name, Count(ED.EMPLOYEE_ID) as [No of employees]
from DEPARTMENT as D
join EMPLOYEE as ED on D.Department_Id=ED.DEPARTMENT_ID
where D.Name='Sales'
group by D.Name
order by D.Name

---Q6. Which is the department having greater than or equal to 5 employees? Display the department names in order?
select D.Name, Count(ED.EMPLOYEE_ID) as [No of employees]
from DEPARTMENT as D
join EMPLOYEE as ED on D.Department_Id=ED.DEPARTMENT_ID
group by D.Name
having count(ED.EMPLOYEE_ID)>=5
order by D.Name

---Q7. How many jobs are there in the organization? Display with designations?
select J.DESIGNATION,Count(ED.EMPLOYEE_ID) as [Job ount]
from JOB as J
join EMPLOYEE as ED on J.JOB_ID=ED.JOB_ID
group by J.DESIGNATION

---Q8. How many employees are working in "New York"?
select L.City,Count(ED.EMPLOYEE_ID) as [No of Emp]
from DEPARTMENT as D
join LOCATION as L on L.Location_ID=D.Location_Id
join EMPLOYEE as ED on ED.DEPARTMENT_ID=D.Department_Id
where L.City='New York'
group by L.City

---Q9. Display the employee details with salary grades. Use conditional statement to create a grade column?
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,
case
when SALARY >=2500 then 'Grade A'
when SALARY between 2000 and 2499 then 'Grade B'
when SALARY between 1500 and 1999 then 'Grade C'
else 'Grade D'
end as Grade
from EMPLOYEE

---Q10. List out the number of employees grade wise. Use conditional statementto create a grade column?
select
case
when SALARY >=2500 then 'Grade A'
when SALARY between 2000 and 2499 then 'Grade B'
when SALARY between 1500 and 1999 then 'Grade C'
else 'Grade D'
end as Grade,
count(*) as [Num of Emp]
from EMPLOYEE
group by
case
when SALARY >=2500 then 'Grade A'
when SALARY between 2000 and 2499 then 'Grade B'
when SALARY between 1500 and 1999 then 'Grade C'
else 'Grade D'
end
order by Grade

---Q11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary?
select
case
when SALARY between 2000 and 5000 then '2000-5000'
else 'Others'
end as Salary_Grade,
count(*) as [Num of Emp]
from EMPLOYEE
where SALARY between 2000 and 5000
group by
case
when SALARY between 2000 and 5000 then '2000-5000'
else 'Others'
end

---Q12. Display all employees in sales or operation departments?
select * from EMPLOYEE as ED
join DEPARTMENT as D on ED.DEPARTMENT_ID=D.Department_Id
where D.Name in ('Sales','Operations')


-------------------------SET Operators:
---Q1. List out the distinct jobs in sales and accounting departments?
select distinct J.DESIGNATION as Distinct_Jobs
from EMPLOYEE as ED
join DEPARTMENT as D on ED.DEPARTMENT_ID=D.Department_Id
join JOB as J on J.JOB_ID=ED.JOB_ID
where D.Name='Sales'
union
SELECT DISTINCT J.Designation AS DISTINCT_JOBS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID=D.Department_Id
JOIN JOB J ON E.JOB_ID=J.JOB_ID
WHERE D.Name='Accounting'

---Q2. List out all the jobs in sales and accounting departments?
SELECT DISTINCT J.Designation AS JOBS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J ON E.JOB_ID = J.JOB_ID
WHERE D.Name = 'Sales'
UNION
SELECT DISTINCT J.Designation AS JOBS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J ON E.JOB_ID = J.JOB_ID
WHERE D.Name = 'Accounting';

---Q3. List out the common jobs in research and accounting departments in ascending order?
SELECT DISTINCT J.Designation AS COMMON_JOBS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J ON E.JOB_ID = J.JOB_ID
WHERE D.Name = 'Research'
INTERSECT
SELECT DISTINCT J.Designation AS COMMON_JOBS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J ON E.JOB_ID = J.JOB_ID
WHERE D.Name = 'Accounting'
ORDER BY COMMON_JOBS ASC;

-----------------------Subqueries:
---Q1. Display the employees list who got the maximum salary?
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY
from EMPLOYEE
where SALARY=(select max(SALARY) from EMPLOYEE)

---Q2. Display the employees who are working in the sales department?
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME
from EMPLOYEE
where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENT where Name='Sales')

---Q3. Display the employees who are working as 'Clerk'?
select *
from EMPLOYEE
where JOB_ID=(select JOB_ID from JOB where DESIGNATION='Clerk')

---Q4. Display the list of employees who are living in "New York"?
select *
from EMPLOYEE
where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENT where Location_Id=(select Location_Id from LOCATION where City='New York'))

---Q5. Find out the number of employees working in the sales department?
SELECT
  (SELECT COUNT(*)
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
   WHERE D.Name = 'Sales') AS NumEmployeesInSales

 ---Q6.Update the salaries of employees who are working as clerks on the basis of 10%?
 UPDATE EMPLOYEE
SET SALARY = SALARY * 1.10
WHERE JOB_ID = (
  SELECT JOB_ID FROM JOB WHERE DESIGNATION = 'CLERK')
  select * from EMPLOYEE

---Q7.Delete the employees who are working in the accounting department?
DELETE FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Accounting')

---Q8. Display the second highest salary drawing employee details?
SELECT *
FROM EMPLOYEE
WHERE SALARY = (
SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE SALARY < (
SELECT MAX(SALARY) FROM EMPLOYEE))

---Q9. Display the nth highest salary drawing employee details?
SELECT *
FROM EMPLOYEE Emp1
WHERE (4 - 1) = (
    SELECT COUNT(DISTINCT Emp2.SALARY)
    FROM EMPLOYEE Emp2
    WHERE Emp2.SALARY > Emp1.SALARY
);

---Q10. List out the employees who earn more than every employee in department 30?
SELECT *
FROM EMPLOYEE
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE DEPARTMENT_ID = 30);


---Q11. List out the employees who earn more than the lowest salary in department.Find out whose department has no employees?
-- List employees earning more than the lowest salary in their department
SELECT E.*
FROM EMPLOYEE E
WHERE SALARY > (
    SELECT MIN(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);

SELECT D.*
FROM DEPARTMENT D
WHERE D.Department_Id NOT IN (
    SELECT DISTINCT DEPARTMENT_ID
    FROM EMPLOYEE);

---Q12. Find out which department has no employees?
SELECT D.*
FROM DEPARTMENT D
WHERE D.Department_Id NOT IN (
    SELECT DISTINCT DEPARTMENT_ID
    FROM EMPLOYEE);

---Q13. Find out the employees who earn greater than the average salary for their department?
SELECT E.*
FROM EMPLOYEE E
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);