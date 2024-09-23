--creating database 
create database courier

--using that database
use courier

--user table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20)
);

--courier table
CREATE TABLE Courier1 (
    CourierID INT PRIMARY KEY,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50) check (Status IN ('pending', 'delivered','shifting','processing')),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE
);

--courier service table
CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);

--employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);


--location table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);

--payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier1(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
-------------------------------------------
-------------------------------------------
--------ADDING VALUES TO THE TABLE---------
-------------------------------------------
------------------------------------------- 




INSERT INTO Users  
VALUES
    (1, 'Alice Johnson', 'alice@example.com', 'password123', '1234567890'),
    (2, 'Bob Smith', 'bob@example.com', 'password456', '0987654321'),
    (3, 'Charlie Brown', 'charlie@example.com', 'password789', '1112223333'),
    (4, 'Diana Ross', 'diana@example.com', 'password321', '4445556666'),
    (5, 'Eva Green', 'eva@example.com', 'password654', '7778889999')

INSERT INTO Courier1
VALUES
    (1, 'Alice Johnson', '123 Main St', 'Bob Smith', '456 Oak St', 5.25, 'Delivered', 'TRK12345', '2024-09-10'),
    (2, 'Charlie Brown', '789 Pine St', 'Diana Ross', '987 Cedar St', 2.50, 'Shifting', 'TRK67890', '2024-09-11'),
    (3, 'Eva Green', '654 Maple St', 'Alice Johnson', '321 Birch St', 3.75, 'Processing', 'TRK54321', '2024-09-12'),
    (4, 'Bob Smith', '159 Elm St', 'Charlie Brown', '951 Willow St', 1.20, 'Pending', 'TRK09876', '2024-09-13'),
    (5, 'Diana Ross', '357 Spruce St', 'Eva Green', '753 Ash St', 4.60, 'Delivered', 'TRK11223', '2024-09-14')


INSERT INTO CourierServices  
VALUES
    (1, 'Standard Delivery', 10.50),
    (2, 'Express Delivery', 25.00),
    (3, 'Same Day Delivery', 50.75),
    (4, 'Next Day Delivery', 30.25),
    (5, 'International Delivery', 100.00),
	(6, 'Weekend Delivery', 45.00),
    (7, 'Holiday Delivery', 60.00) 

INSERT INTO Employee 
VALUES
    (1, 'John Doe', 'john@example.com', '1234567890', 'Manager', 60000.00),
    (2, 'Sarah Connor', 'sarah@example.com', '0987654321', 'Courier', 35000.00),
    (3, 'Mark Twain', 'mark@example.com', '1112223333', 'Dispatcher', 40000.00),
    (4, 'Emily Bronte', 'emily@example.com', '4445556666', 'Courier', 33000.00),
    (5, 'James Bond', 'james@example.com', '7778889999', 'Security', 45000.00),
	(6, 'Lisa Kudrow', 'lisa@example.com', '6665554444', 'Courier', 35000.00),
    (7, 'Tom Cruise', 'tom@example.com', '3334445555', 'Dispatcher', 50000.00)

INSERT INTO Location  
VALUES
    (1, 'New York Hub', '100 Main St, New York, NY'),
    (2, 'Los Angeles Hub', '200 Oak St, Los Angeles, CA'),
    (3, 'Chicago Hub', '300 Pine St, Chicago, IL'),
    (4, 'Houston Hub', '400 Cedar St, Houston, TX'),
    (5, 'Miami Hub', '500 Birch St, Miami, FL'),
	(6, 'San Francisco Hub', '600 Redwood St, San Francisco, CA'),
    (7, 'Seattle Hub', '700 Evergreen St, Seattle, WA');


INSERT INTO Payment  
VALUES
    (1, 1, 1, 10.50, '2024-09-15'),
    (2, 2, 2, 25.00, '2024-09-16'),
    (3, 3, 3, 50.75, '2024-09-17'),
    (4, 4, 4, 30.25, '2024-09-18'),
    (5, 5, 5, 100.00, '2024-09-19');


---------------------------------------------------------------------------
---------------------------------------------------------------------------
--1. List all customers: 
select * from Users

--2. List all orders for a specific customer: 
select * from Courier1 where SenderName = 'Alice Johnson'

--3. List all couriers: 
select * from Courier1

--4. List all packages for a specific order: 
select* from Courier1 where CourierID = 2

--5. List all deliveries for a specific courier:
select * from CourierServices where ServiceID = 1;

--6. List all undelivered packages: 
select * from Courier1 where Status <>'delivered'

--7. List all packages that are scheduled for delivery today: 
insert into Courier1 values(6, 'Puru', 'Totthanam ', 'Liverpool', '178 Coonoor', 3.99, 'pending', 'TRC11200', '2024-09-25')

select * from Courier1  where DeliveryDate = Cast(getDate() as date)
--drop table if exists Courier



 --8 List all packages with a specific status: 
select * from Courier1 where Status in ('delivered','pending')

 --9. Calculate the total number of packages for each courier. 
select SenderName,count(SenderName) as total 
from Courier1 group by (SenderName) 	
 
select * from Courier1
insert into Courier1 values(7, 'Puru', 'Real madrid ', 'Milan', '128 Kotagiri', 7.99, 'pending', 'TRC19890', '2024-09-13')
--10. Find the average delivery time for each courier
--Alter table Courier1 add startDate date
update Courier1 set startDate = '2024-09-09' where CourierID = 1
update Courier1 set startDate = '2024-09-09' where CourierID = 2
update Courier1 set startDate = '2024-09-09' where CourierID = 3
update Courier1 set startDate = '2024-09-09' where CourierID = 4
update Courier1 set startDate = '2024-09-09' where CourierID = 5
update Courier1 set startDate = '2024-09-09' where CourierID = 6
update Courier1 set startDate = '2024-09-09' where CourierID = 7

--10. Find the average delivery time for each courier
select SenderName ,avg(datediff(day,startDate,DeliveryDate)) 
as average from Courier1 group By SenderName having 
avg(datediff(day,startDate,DeliveryDate))  is not null


--11. List all packages with a specific weight range: 
select * from Courier1 where Weight between 2 and 5


--12.Retrieve employees whose names contain 'John' 
select * from Employee where Name like '%John%'


--13. Retrieve all courier records with payments greater than $50
select Courier1.* from Courier1 
inner join Payment on Courier1.CourierID = Payment.CourierID 
where Payment.Amount>50
 

-----------------------------------------------------------------------
-----------------------------------------------------------------------
--Task 3: GroupBy, Aggregate Functions, Having, Order By, where
-----------------------------------------------------------------------
-----------------------------------------------------------------------

--14. Find the total number of couriers handled by each employee. 
select distinct EmployeeID, count(EmployeeID) as TotalCourier
from Employee group by EmployeeID order by  EmployeeID


--15.Calculate the total revenue generated by each location 
--select * from payment
 select distinct LocationID,sum(Amount) as TotalRevenue
 from Payment group by  LocationID
  


--16.Find the total number of couriers delivered to each location
 --select * from Payment
 select distinct LocationID, Count(CourierID) as IndividualCount
 from Payment group by LocationID



--17. Find the courier with the highest average delivery time:
select * from Courier1
--select CourierID, max(avg(datediff(day,startDate,DeliveryDate))) as maxTime from Courier1 group by CourierID
 select top 1 sendername, avg(datediff(day, startDate, DeliveryDate)) as avgdeliverytime
	from courier1 
	group by sendername
	order by avgdeliverytime desc
 



--18. Find Locations with Total Payments Less Than a Certain Amount
--select * from Payment
 select  LocationID , Amount
 from Payment where Amount<50


--19. Calculate Total Payments per Location 
SELECT LocationID, SUM(Amount) AS TotalPayments
FROM Payment
GROUP BY LocationID


--20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X): 
insert into Payment values(8, 1, 5, 1001.50, '2024-09-19')
select * from Payment
select * from Payment where Amount > 1000  and LocationID =5


--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'): 
select * from Payment where Amount > 1000    and (PaymentDate > '2024-09-17' )


--22. Retrieve locations where the total amount received is more than $5000 before a certain date(PaymentDate > 'YYYY-MM-DD') 
insert into Payment values(9, 2, 3, 5001.50, '2024-09-03')

select LocationID,(sum(Amount)) as total from Payment 
where (PaymentDate < '2024-09-18' )
group by LocationID 
having (sum(amount) >5000)



--Task 4: Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join 


--23. Retrieve Payments with Courier Information 
select * from Payment join Courier1
on Payment.CourierID = Courier1.CourierID


--24. Retrieve Payments with Location Information
select * from Payment join Location
on Payment.LocationID = Location.LocationID 


--25. Retrieve Payments with Courier and Location Information 
select * from Payment join Location
on Payment.LocationID = Location.LocationID 
join Courier1 
on Payment.CourierID = Courier1.CourierID


--26. List all payments with courier details 
select * from Payment join Courier1
on Payment.CourierID = Courier1.CourierID


--27. Total payments received for each courier 
select c.CourierID, sum(p.Amount) as Total from Courier1 c
inner join Payment p on
p.CourierID = c.CourierID group by (c.CourierID) order by c.CourierID



--28. List payments made on a specific date 
select * from  Payment p where PaymentDate  
in(select PaymentDate from Payment where PaymentDate='2024-09-17')



--29. Get Courier Information for Each Payment
select c.*, p.Amount from Courier1 c
join Payment p on c.CourierID= p.CourierID



--30. Get Payment Details with Location 
select p.*, l.Address from Payment p
join Location l on l.LocationID = p.LocationID



--31. Calculating Total Payments for Each Courier 
select c.CourierID , sum(p.Amount) as TotalPayment from
Courier1 c join Payment p
on c.CourierID = p.CourierID 
group by (c.courierID) 
order by CourierID


--32. List Payments Within a Date Range 
select c.CourierID, p.Amount, c.DeliveryDate from
Courier1 c join Payment p
on c.CourierID = p.CourierID where 
c.DeliveryDate between '2024-09-12' and '2024-09-18'



--33. Retrieve a list of all users and their corresponding courier records, 
--including cases where there are no matches on either side 
select u.UserID , u.Name, c.CourierID, c.SenderName, c.ReceiverName
from Users u
full outer join Courier1 c 
on u.UserID = c.UserID where u.UserID is not null;




-------------------------------------EXTRA DATAS FOR RELEVANT INFORMATION----------------------------
-- sample data for Users
INSERT INTO Users  
VALUES
    (8, 'George Martin', 'george@example.com', 'password987', '9998887777','342 Argentina'),
    (9, 'Hannah Lee', 'hannah@example.com', 'password555', '8887776666','999 Inter milan')

	
select * from Courier1
-- sample data for Courier1
INSERT INTO Courier1  
VALUES
    (16, 'George Martin', '123 Magnolia St', 'Alice Johnson', '456 Willow St', 6.00, 'Pending', 'TRK2222', '2024-09-20','2024-09-04',2),
    (17, 'Eva Green', '159 Oak St', 'George Martin', '951 Maple St', 2.25, 'Processing', 'TRK1111', '2024-09-21','2024-09-10',3),
    (18, 'Bob Smith', '654 Ash St', 'Hannah Lee', '753 Pine St', 4.75, 'Shifting', 'TRK55433', '2024-09-22','2024-09-09',5)
    

--____________________________________________________________________________________________________________________________________

--34. Retrieve a list of all couriers and their corresponding services,including cases where there are no matches on either side  
select c.CourierID, cs.* 
from CourierServices cs
full outer join Courier1 c ON cs.ServiceID = c.CourierID
WHERE cs.ServiceID is not null;



--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side
select e.* , p.* from  Employee e full 
outer join Payment p on e.EmployeeID = p.CourierID
where PaymentID is not null



 
--36.List all users and all courier services, showing all possible combinations. 
select u.*, c.* from users u cross join courier c ;



--37.List all employees and all locations, showing all possible combinations:
select employee.name as employeename, location.locationname as locationname
from employee cross join location;


--38. Retrieve a list of couriers and their corresponding sender information (if available) 
select c.*, u.Name as SenderName, u.Email as SenderEmail
from Courier1 c
 inner join users u on c.SenderName = u.Name  ;



--39. Retrieve a list of couriers and their corresponding receiver information (if available): 
select c.CourierID, u.Name as ReceiverName, u.Email as ReceiverEmail
from Courier1 c
left join users u on c.ReceiverName = u.Name;


--40. Retrieve a list of couriers along with the courier service details (if available): 
select c.*, cs.*
from Courier1 c
inner join CourierServices cs ON c.CourierID = cs.ServiceID;



--41. Retrieve a list of employees and the number of couriers assigned to each employee:
select * from Employee
select e.EmployeeID, e.name as Name, count(c.courierid) as assignedcouriers
from employee e
left join Courier1 c on e.EmployeeID = c.CourierID
group by e.EmployeeID, e.Name;



--42. Retrieve a list of locations and the total payment amount received at each location
select l.locationName, sum(p.Amount) as PaymentReceived
from Location l join  Payment p
on l.LocationID = p.LocationID  group by l.LocationName


--43. Retrieve all couriers sent by the same sender (based on SenderName).
select c.CourierID , c.SenderName , c.SenderAddress from Courier1 c 
where c.SenderName ='Eva Green'


--44. List all employees who share the same role.
select e1.name,e1.Role,e1.EmployeeID
from Employee e1
join Employee e2 on e1.EmployeeId <> e2.EmployeeId 
and e1.Role = e2.Role
order by e2.role,e1.EmployeeID
 


--45. Retrieve all payments made for couriers sent from the same location.
select   l.LocationName  ,sum( p.Amount) as Amount from Courier1 c 
join Payment p on p.CourierID = c.CourierID join Location l  on
p.locationID = l.LocationID  group by l.LocationName  order by l.LocationName



--46. Retrieve all couriers sent from the same location (based on SenderAddress).
select c.* from Courier1 c 
join Payment p on c.CourierID = p.CourierID 
join Location l on l.LocationID = p.LocationID
where cast(c.SenderAddress as varchar (50)) = '789 Pine St'--converting text to varchar  


--47. List employees and the number of couriers they have delivered:
select e.EmployeeID, e.Name AS EmployeeName, COUNT(c.CourierID) AS DeliveredCouriers
from Employee e
left join Courier1 c ON e.EmployeeID = c.CourierID
WHERE c.Status = 'Delivered'
GROUP BY e.EmployeeID, e.Name;


--48. Find couriers that were paid an amount greater than the cost of their respective courier services 
select c.*, cs.*
from Courier1 c
join CourierServices cs on c.CourierID = cs.ServiceID
join Payment p on c.CourierID = p.CourierID
where p.Amount > cs.Cost;


-----------------------------------------------------------------------
-----------------------------------------------------------------------
--Scope: Inner Queries, Non Equi Joins, Equi joins,Exist,Any,All
-----------------------------------------------------------------------
-----------------------------------------------------------------------


--49. Find couriers that have a weight greater than the average weight of all couriers
	select * from Courier1 where weight >(select avg(weight) from Courier1)


--50. Find the names of all employees who have a salary greater than the average salary:
	select * from Employee where Salary >(select avg(Salary) from Employee)


--51. Find the total cost of all courier services where the cost is less than the maximum cost
	 select sum(Amount) as TotalCost from Payment where Amount <(select max(Amount) as total from Payment)
	 


--52. Find all couriers that have been paid for
	select c.* from Courier1 c where CourierID in (
		select p.CourierID 
		from Payment p )


--53. Find the locations where the maximum payment amount was made
	select l.LocationName,p.Amount from Location l join Payment p on 
	l.LocationID = p.LocationID where p.amount=
	(select max(Amount) from Payment)


--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender (e.g., 'SenderName'):
select * from Courier1 where weight>(
	select sum(weight) from Courier1 where SenderName='eva green')