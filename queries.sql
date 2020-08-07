use CarSalesDWTeamE;

-- query 1 - See what the bestselling product of Q4 in 2004 was
select P.productName, count(OT.productCode) 'Sold' from OrderDetailFacts OT
left join TimeDim TD on OT.timeKey = TD.TimeKey
left join Products P on OT.productCode = P.productCode
where TD.Quarter = 4 and TD.Year = 2004
group by P.productName
order by 'Sold' desc;

-- query 2 - See which office performed the best during the december holiday season
select T1.city, T1.country, count(PF.employeeNumber) 'Sales' from PaymentFacts PF
left join TimeDim TD on PF.timeKey = TD.TimeKey
left join (select employeeNumber, lastName, firstName, extension, email, E.officeCode, reportsTo, jobTitle, O.city, O.country from Employees E
left join Offices O on E.officeCode = O.officeCode) T1 on PF.employeeNumber = T1.employeeNumber
where TD.Month = 12
group by T1.city, T1.country
order by Sales desc;

-- query 3 - bestselling products from top performing employee of all time
select T1.firstName, T1.lastName, T1.jobTitle, P.productName, count(P.productCode) 'Sold' from PaymentFacts PF
left join Employees E on PF.employeeNumber = E.employeeNumber
left join OrderDetails OD on PF.orderNumber = OD.orderNumber
left join Products P on OD.productCode = P.productCode
left join (select top(1) E.employeeNumber, E.firstName, E.lastName, E.jobTitle, count(PF.employeeNumber) 'Sales' from PaymentFacts PF
left join Employees E on PF.employeeNumber = E.employeeNumber
group by E.employeeNumber, E.firstName, E.lastName, E.jobTitle
order by Sales desc) T1 on PF.employeeNumber = T1.employeeNumber
where PF.employeeNumber = T1.employeeNumber
group by T1.firstName, T1.lastName, T1.jobTitle, P.productName
order by Sold desc;

-- query 4 - percent of orders coming from different countries
select * from PaymentFacts PF
left join Customers C on PF.customerNumber = C.customerNumber;