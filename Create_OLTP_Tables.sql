-- create database CarSalesTeamE;
use CarSalesTeamE;

create table Offices (
    officeCode varchar(10)primary key,
    city varchar(50),
    phone varchar(50),
    addressLine1 varchar(50),
    addressLine2 varchar(50),
    state varchar(50),
    country varchar(50),
    postalCode varchar(15),
    territory varchar(10),
)

create table Employees (
    employeeNumber integer primary key,
    lastName varchar(50),
    firstName varchar(50),
    extension varchar(10),
    email varchar(100),
    officeCode varchar(10) references Offices(officeCode),
    reportsTo integer references Employees(employeeNumber),
    jobTitle varchar(50),
)

create table Customers (
    customerNumber integer primary key,
    customerName varchar(50),
    contactLastName varchar(50),
    contactFirstName varchar(50),
    phone varchar(50),
    addressLine1 varchar(50),
    addressLine2 varchar(50),
    city varchar(50),
    state varchar(50),
    postalCode varchar(15),
    country varchar(50),
    salesRepEmployeeNumber integer references Employees(employeeNumber),
    creditLimit float,
)

create table Payments (
    customerNumber integer REFERENCES Customers(customerNumber),
    checkNumber varchar(50) primary key,
    paymentDate DATETIME,
    amount float
)

create table Orders (
    orderNumber integer primary key,
    orderDate datetime,
    requiredDate datetime,
    shippedDate datetime,
    "status" varchar(15),
    comments text,
    customerNumber integer REFERENCES Customers(customerNumber),
)

create table ProductLines (
    productLine varchar(50) primary key,
    textDescription text,
    htmlDescription text,
    image varbinary(max)
)

create table Products (
    productCode varchar(15) primary key,
    productName varchar(70),
    productLine varchar(50) references ProductLines(productLine),
    productScale varchar(10),
    productVendor varchar(50),
    productDescription text,
    quantityInStock integer,
    buyPrice float,
    MSRP float
)

create table OrderDetails (
    orderNumber integer references Orders(orderNumber),
    productCode varchar(15) references Products(productCode),
    quantityOrdered integer,
    priceEach float,
    orderLineNumber smallint,
    primary key (orderNumber, productCode)
)

alter table Products
add CONSTRAINT FK_Products_ProductLine foreign key (productLine)
references ProductLines (productLine) 
on delete CASCADE
on update CASCADE;