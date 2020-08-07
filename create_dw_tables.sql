-- create database CarSalesDWTeamE;
-- drop database CarSalesDWTeamE;

use CarSalesDWTeamE;

create table Customers (
    customerNumber integer primary key,
    customerName varchar(50),
    contactLastName varchar(50),
    contactFirstName varchar(50),
    phone varchar(50),
    addressLine1 varchar(50),
    addressLine2 varchar(50),
    city varchar(50),
    "state" varchar(50),
    postalCode varchar(15),
    country varchar(50),
    creditLimit float
)

create table Offices (
    officeCode varchar(10) primary key,
    city varchar(50),
    phone varchar(50),
    addressLine1 varchar(50),
    addressLine2 varchar(50),
    "state" varchar(50),
    country varchar(50),
    postalCode varchar(15),
    territory varchar(10)
)

create table Employees (
    employeeNumber integer primary key,
    lastName varchar(50),
    firstName varchar(50),
    extension varchar(10),
    email varchar(100),
    officeCode varchar(10) references Offices(officeCode),
    reportsTo integer references Employees(employeeNumber),
    jobTitle varchar(50)
)


create table Payments (
    customerNumber integer REFERENCES Customers(customerNumber),
    checkNumber varchar(50) primary key,
    paymentDate DATETIME,
    amount float
)

create table Products (
    productCode varchar(15) primary key,
    productName varchar(70),
    productLine varchar(50),
    productScale varchar(10),
    productVendor varchar(50),
    productDescription text,
    quantityInStock integer,
    buyPrice float,
    MSRP float,
    productLineDescription text,
    productLineHtmlDescription text,
    "image" varbinary(max)
)

create table Orders (
    orderNumber integer primary key,
    orderDate datetime,
    requiredDate datetime,
    shippedDate datetime,
    status varchar(15),
    comments text,
)

CREATE TABLE TimeDim
	(	[TimeKey] INT primary key, 
		[Date] DATETIME,
		[FullDateUK] CHAR(10), -- Date in dd-MM-yyyy format
		[FullDateUSA] CHAR(10),-- Date in MM-dd-yyyy format
		[DayOfMonth] VARCHAR(2), -- Field will hold day number of Month
		[DaySuffix] VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc
		[DayName] VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		[DayOfWeekUSA] CHAR(1),-- First Day Sunday=1 and Saturday=7
		[DayOfWeekUK] CHAR(1),-- First Day Monday=1 and Sunday=7
		[DayOfYear] VARCHAR(3),
		[WeekOfMonth] VARCHAR(1),-- Week Number of Month 
		[WeekOfQuarter] VARCHAR(2), --Week Number of the Quarter
		[WeekOfYear] VARCHAR(2),--Week Number of the Year
		[Month] VARCHAR(2), --Number of the Month 1 to 12
		[MonthName] VARCHAR(9),--January, February etc
		[MonthOfQuarter] VARCHAR(2),-- Month Number belongs to Quarter
		[Quarter] CHAR(1),
		[QuarterName] VARCHAR(9),--First,Second..
		[Year] CHAR(4),-- Year value of Date stored in Row
		[YearName] CHAR(7), --CY 2012,CY 2013
		[MonthYear] CHAR(10), --Jan-2013,Feb-2013
		[MMYYYY] CHAR(6),
		[FirstDayOfMonth] DATE,
		[LastDayOfMonth] DATE,
		[FirstDayOfQuarter] DATE,
		[LastDayOfQuarter] DATE,
		[FirstDayOfYear] DATE,
		[LastDayOfYear] DATE,
		[IsHolidayUSA] BIT,-- Flag 1=National Holiday, 0-No National Holiday
		[IsWeekday] BIT,-- 0=Week End ,1=Week Day
		[HolidayUSA] VARCHAR(50),--Name of Holiday in US
		[IsHolidayUK] BIT Null,
		[HolidayUK] VARCHAR(50) Null --Name of Holiday in UK
);

create table OrderDetailFacts (
    orderNumber integer references Orders(orderNumber),
    productCode varchar(15) references Products(productCode),
    customerNumber integer references Customers(customerNumber),
    employeeNumber integer references Employees(employeeNumber),
    timeKey integer references TimeDim(timeKey),
    quantityOrdered integer,
    priceEach float,
    primary key (orderNumber, productCode, customerNumber, employeeNumber, timeKey)
)