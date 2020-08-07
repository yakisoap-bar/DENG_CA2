-- Customers --
insert into CarSalesDWTeamE..Customers(customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, creditLimit)
select customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, creditLimit
from CarSalesTeamE..Customers;

-- Offices --
insert into CarSalesDWTeamE..Offices(officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
select officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory
from CarSalesTeamE..Offices;

-- Employees --
insert into CarSalesDWTeamE..Employees(employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
select employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle
from CarSalesTeamE..Employees;

-- Orders -- 
insert into CarSalesDWTeamE..Orders(orderNumber, orderDate, requiredDate, shippedDate, status, comments)
select orderNumber, orderDate, requiredDate, shippedDate, status, comments
from CarSalesTeamE..Orders;

-- Payments --
insert into CarSalesDWTeamE..Payments(customerNumber, checkNumber, paymentDate, amount)
select customerNumber, checkNumber, paymentDate, amount 
from CarSalesTeamE..Payments;

-- Products --
insert into CarSalesDWTeamE..Products(productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLineDescription, productLineHtmlDescription, image)
select p.productCode, p.productName, p.productLine, p.productScale, p.productVendor, p.productDescription, p.quantityInStock, p.buyPrice, p.MSRP, pl.textDescription, pl.htmlDescription, pl.image
from CarSalesTeamE..Products p left join CarSalesTeamE..ProductLines pl
on p.ProductLine = pl.ProductLine;

