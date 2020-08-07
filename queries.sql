use CarSalesDWTeamE;

-- query 1 - See what the bestselling product of Q4 in 2004 was
select P.productName, count(ODF.productCode) 'Sold' from OrderDetailFacts ODF
left join TimeDim TD on ODF.timeKey = TD.TimeKey
left join Products P on ODF.productCode = P.productCode
where TD.Quarter = 4 and TD.Year = 2004
group by P.productName
order by 'Sold' desc;

-- query 2 - See which office performed the best during the december holiday season(cumulative)
select T1.city, T1.country, count(*) 'Sales' from OrderDetailFacts ODF
left join TimeDim TD on ODF.timeKey = TD.TimeKey
left join (select employeeNumber, lastName, firstName, extension, email, E.officeCode, reportsTo, jobTitle, O.city, O.country from Employees E
left join Offices O on E.officeCode = O.officeCode) T1 on ODF.employeeNumber = T1.employeeNumber
where TD.Month = 12
group by T1.city, T1.country
order by Sales desc;

-- query 3 - bestselling products from top performing employee of all time
select T1.firstName, T1.lastName, T1.jobTitle, P.productName, count(P.productCode) 'Sold' from OrderDetailFacts ODF
left join Employees E on ODF.employeeNumber = E.employeeNumber
left join Products P on ODF.productCode = P.productCode
left join (select top(1) E.employeeNumber, E.firstName, E.lastName, E.jobTitle, count(*) 'Sales' from OrderDetailFacts ODF
left join Employees E on ODF.employeeNumber = E.employeeNumber
group by E.employeeNumber, E.firstName, E.lastName, E.jobTitle
order by Sales desc) T1 on ODF.employeeNumber = T1.employeeNumber
where ODF.employeeNumber = T1.employeeNumber
group by T1.firstName, T1.lastName, T1.jobTitle, P.productName
order by Sold desc;

-- query 4 - percent of orders coming from different countries (pain/suffering)
select count(T1.orderNumber) 'totalOrders', T1.country from OrderDetailFacts ODF
left join Orders O on ODF.orderNumber = O.orderNumber
left join Customers C on ODF.customerNumber = C.customerNumber
where ODF.orderNumber = T1.orderNumber
group by T1.country
order by totalOrders desc;

-- query 4.1 - amount of money made from each customer (hope?)
select P.amount, C.customerNumber from OrderDetailFacts ODF
left join Customers C on C.customerNumber = ODF.customerNumber
left join Payments P on C.customerNumber = P.customerNumber

-- select C.customerNumber, 
-- left join Payments P on C.customerNumber = 


-- SELECT  *
-- FROM    (SELECT ID, SKU, Product,
--                 ROW_NUMBER() OVER (PARTITION BY PRODUCT ORDER BY ID) AS RowNumber
--          FROM   MyTable
--          WHERE  SKU LIKE 'FOO%') AS a
-- WHERE   a.RowNumber = 1