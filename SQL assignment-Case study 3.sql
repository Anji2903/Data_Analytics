-----------------------------------------------SQL Assignment- Case Study 3----------------------------------------
---Q1. Display the count of customers in each region who have done the transaction in the year 2020?
select CT.region_name,count(distinct C.customer_id) as [Transact year 2020]
from Customers as C
join Continent as CT on C.region_id=CT.region_id
join[dbo].[Transaction] as T on T.customer_id=C.customer_id
where YEAR(T.Txn_date)=2020
group by CT.region_name
order by CT.region_name

---Q2. Display the maximum and minimum transaction amount of each transaction type?
select T.txn_type,min(T.txn_amount) as [Min trans],Max(T.txn_amount) as [Max trans]
from Customers as C
join [dbo].[Transaction] as T on C.customer_id=T.customer_id
group by T.txn_type
order by T.txn_type

---Q3. Display the customer id, region name and transaction amount transaction type is deposit and transaction amount > 2000?
select C.customer_id,Ct.region_name,T.txn_amount
from Customers as C
join Continent as CT on C.region_id=CT.region_id
join [dbo].[Transaction] as T on T.customer_id=C.customer_id
where T.txn_type='deposit' and T.txn_amount>2000

---Q4. Display Duplicate records on Customers Table?
select customer_id,Count(*) as [Dup_Records]
from Customers
group by customer_id
having Count(*)>1

---Q5.Display the customer id, region name, transaction type and amount for the minimum transaction amount in deposit?
select C.customer_id,Ct.region_id,CT.region_name,T.txn_type,T.txn_amount
from Customers as C
join Continent as Ct on C.region_id=Ct.region_id
join [dbo].[Transaction] as T on C.customer_id=T.customer_id
where T.txn_type='deposit'
and
T.txn_amount=(select min(txn_amount) from [dbo].[Transaction] where txn_type='deposit')

---Q6. Create a stored procedure to display details of customers in Transaction table where the transaction date is greater than Jun 2020?
create procedure [Get Trans value > 2000]
as
begin
select C.customer_id,CT.region_id,CT.region_name,T.txn_type,T.txn_amount
from Customers as C 
join Continent as CT on C.region_id=CT.region_id
join [dbo].[Transaction] as T on T.customer_id=C.customer_id
where T.txn_date>'2020-06-30'
end

exec [Get Trans value > 2000]

---Q7. Create a stored procedure to insert a record in the Continent table?
create procedure [Insert data]
(
@region_id int,
@region_name varchar(50)
)
as
begin
insert into Continent(region_id,region_name)
values(@region_id,@region_name)
end

exec [Insert data]6,'Russia'

select * from Continent

---Q8. Create a stored procedure to display the details of transactions happened on a specific day?
create procedure [Tran on specific date]
(
@specific_date date
)
as
begin
select C.customer_id,CT.region_id,CT.region_name,T.txn_type,T.txn_amount
from Customers as C 
join Continent as CT on C.region_id=CT.region_id
join [dbo].[Transaction] as T on T.customer_id=C.customer_id
where T.txn_date=@specific_date
end

exec [Tran on specific date]'2020-01-10'

---Q9. Create a user defined function to add 10% of the transaction amount in table?
create function [add 10% to Amt]
(
@amount int
)
returns int
as
begin
declare @newamount int
set @newamount=@amount+(@amount*0.10)
Return @newamount
end

update [dbo].[Transaction] set txn_amount=dbo.[add 10% to Amt](txn_amount)

---Q10. Create a user defined function to find the total transaction amount for given transaction type?
CREATE FUNCTION CalculateTotalAmountByType (@txnType VARCHAR(50))
RETURNS int
AS
BEGIN
    DECLARE @totalAmount int

    SELECT @totalAmount = SUM(txn_amount)
    FROM [dbo].[Transaction]
    WHERE txn_type = @txnType
    RETURN ISNULL(@totalAmount, 0)
END;

DECLARE @transactionType VARCHAR(50)= 'purchase'
DECLARE @totalAmount int

SET @totalAmount = dbo.CalculateTotalAmountByType(@transactionType)

SELECT @totalAmount AS TotalAmount

---Q11. Create a table value function which comprises the columns customer_id region_id ,txn_date , txn_type , txn_amount which will retrieve data the above table?
create function Get_Details()
returns table 
as return
select C.customer_id,C.region_id,T.txn_date,T.txn_amount
from Customers as C
join [dbo].[Transaction] as T on C.customer_id=T.customer_id

select * from Get_Details()

---Q12. Create a TRY...CATCH block to print a region id and region name in single column?
BEGIN TRY
    SELECT CONCAT(region_id, ' - ', region_name) AS RegionIdAndName
    FROM Continent;
END TRY
BEGIN CATCH
    SELECT 'An error occurred: ' + ERROR_MESSAGE() AS RegionIdAndName;
END CATCH;

---Q13. Create a TRY...CATCH block to insert a value in the Continent table?
begin try
insert into Continent(region_id,region_name)
values (8,'New Zealand')
end try
begin catch
select ERROR_MESSAGE() as ErrorMessage
end catch

--14 Create a trigger to prevent deleting of a table in a database
CREATE TRIGGER tr_prevent_table_drop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    RAISERROR ('Table drop is not allowed.', 16, 1)
    ROLLBACK;
END;

drop table Customers

--15 Create a trigger for auditing of data in a table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'customer_audit')
BEGIN
    CREATE TABLE customer_audit
    (
        id INT IDENTITY(1, 1),
        AuditData VARCHAR(50)
    )
END

CREATE TRIGGER trg_audit 
ON customers
AFTER INSERT
AS
BEGIN
    DECLARE @id INT
    SELECT @id = customer_id FROM inserted
    INSERT INTO customer_audit (AuditData)
    VALUES ('New customer with ID = ' + CAST(@id AS VARCHAR(5)) + ' is added at ' + CONVERT(VARCHAR(20), GETDATE(), 120))
END

insert into Customers values(2003,2,'2001-11-14','2001-11-14')

drop trigger trg_audit 

select * from customer_audit
select * from Customers


---16 Create a trigger to prevent login of same user id in multiple page? 

select * from sys.dm_exec_sessions order by is_user_process desc
select is_user_process, original_login_name from sys.dm_exec_sessions
order by is_user_process desc

create trigger trg_logon
on all server
for logon
as begin
declare @LoginName varchar(50)
set @LoginName = ORIGINAL_LOGIN()
if(select count(*) from sys.dm_exec_sessions where
   is_user_process = 1 and original_login_name = @LoginName) > 3
   begin
   print 'Fourth connection attempt by ' +@loginName + 'Blocked'
   rollback;
   end
end

drop trigger trg_logon on all server

---17 Display top n customer on the basis of transaction type
SELECT * FROM (
SELECT *,
DENSE_RANK () OVER ( 
PARTITION BY txn_type
ORDER BY txn_amount DESC
) amount_rank 
FROM
[dbo].[Transaction]
) t
WHERE amount_rank < 5;

---Q18. Create a pivot table to display the total purchase, withdrawal deposit for all the customers?
SELECT *
FROM (
    SELECT c.customer_id, c.region_id, c.start_date, c.end_date, t.txn_type, t.txn_amount
    FROM Customers c
    JOIN [dbo].[Transaction] t ON c.customer_id = t.customer_id
) AS SourceTable
PIVOT (
    SUM(txn_amount)
    FOR txn_type IN ([Purchase], [Withdrawal], [Deposit])
) AS PivotTable;
