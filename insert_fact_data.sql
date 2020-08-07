-- noinspection SqlInsertValuesForFile

use CarSalesTeamE;

-- ensure table is empty to avoid conflict
delete from CarSalesDWTeamE..OrderDetailFacts;

insert into CarSalesDWTeamE..OrderDetailFacts (orderNumber, productCode, customerNumber, employeeNumber, timeKey, quantityOrdered, priceEach)
select OD.orderNumber, OD.productCode, C.customerNumber, E.employeeNumber, replace(convert(date, O.orderDate, 112), '-', ''), OD.quantityOrdered, OD.priceEach from OrderDetails OD
left join Orders O on OD.orderNumber = O.orderNumber
left join Customers C on O.customerNumber = C.customerNumber
left join Employees E on C.salesRepEmployeeNumber = E.employeeNumber

