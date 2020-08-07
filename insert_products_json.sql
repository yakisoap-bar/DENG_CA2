use CarSalesTeamE;
declare @products varchar(max);
select @products = BulkColumn from OPENROWSET(BuLk '/media/Products.json', single_blob) JSON;

delete from Products;

insert into Products 
    select * from OpenJson(@products, '$')
        with (
            productCode varchar(15) '$.productCode',
            productName varchar(70) '$.productName',
            productLine varchar(50) '$.productLine',
            productScale varchar(10) '$.productScale',
            productVendor varchar(50) '$.productVendor',
            productDescription varchar(max) '$.productDescription',
            quantityInStock integer '$.quantityInStock',
            buyPrice float '$.buyPrice',
            MSRP float '$.MSRP'
        )

select * from Products;