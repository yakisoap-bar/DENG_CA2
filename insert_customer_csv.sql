use CarSalesTeamE;
go
BULK INSERT Customers
from '/media/Customers.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    maxerrors = 100,
    batchsize = 1,
    keepnulls
);