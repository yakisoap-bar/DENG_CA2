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
left join (
    select employeeNumber, lastName, firstName, extension, email, E.officeCode, reportsTo, jobTitle, O.city, O.country from Employees E
    left join Offices O on E.officeCode = O.officeCode
) T1 on ODF.employeeNumber = T1.employeeNumber
where TD.Month = 12
group by T1.city, T1.country
order by Sales desc;

-- query 3 - bestselling products from top performing employee of all time
select T1.firstName, T1.lastName, T1.jobTitle, P.productName, count(P.productCode) 'Sold' from OrderDetailFacts ODF
left join Employees E on ODF.employeeNumber = E.employeeNumber
left join Products P on ODF.productCode = P.productCode
left join (
    select top(1) E.employeeNumber, E.firstName, E.lastName, E.jobTitle, count(*) 'Sales' from OrderDetailFacts ODF
    left join Employees E on ODF.employeeNumber = E.employeeNumber
    group by E.employeeNumber, E.firstName, E.lastName, E.jobTitle
    order by Sales desc
) T1 on ODF.employeeNumber = T1.employeeNumber
where ODF.employeeNumber = T1.employeeNumber
group by T1.firstName, T1.lastName, T1.jobTitle, P.productName
order by Sold desc;

-- query 4 - find out how much profit each product made --
select T1.productName, sum(T1.[Profit Made]) 'Total Profit' from (
    select P.productName, (count(*) * ODF.priceEach) - (count(*) * P.buyPrice) 'Profit Made' from OrderDetailFacts ODF
    left join Products P on P.productCode = ODF.productCode
    group by P.productName, ODF.priceEach, P.buyPrice
) T1
group by T1.productName
order by [Total Profit] desc;