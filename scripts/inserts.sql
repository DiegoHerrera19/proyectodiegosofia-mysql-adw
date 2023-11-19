INSERT INTO adw_proyecto.DIM_PRODUCTO (producto_id, nombre, category,sub_category)
select
    p.ProductId as producto_id,
    p.name as descripcion,
    pc.name as category,
    psc.name as sub_category
    
from
    adw.Production_Product p
    join adw.Production_ProductSubcategory psc on p.productsubcategoryid = psc.productsubcategoryid
    join adw.Production_ProductCategory pc on psc.productcategoryid = pc.productcategoryid;
    
INSERT INTO adw_proyecto.DIM_CLIENTE(cliente_id, pais, continente)
select
    c.customerid as cliente_id,
    st.name as continente,
    cr.name as pais
from
    adw.Sales_Customer c
    join adw.Sales_SalesTerritory  st on c.territoryid = st.territoryid
    join adw.Person_CountryRegion cr on st.countryregioncode = cr.countryregioncode;

insert INTO adw_proyecto.DIM_FECHA(fecha, dia, mes, ano, dias_semana)
select DISTINCT(DATE(orderdate)) as fecha, DAY(DATE(orderdate)) AS dia, MONTH(DATE(orderdate)) as mes, YEAR(DATE(orderdate)) as ano, DAYOFWEEK(DATE(orderdate)) as dias_semana
from
    adw.Sales_SalesOrderHeader;

INSERT INTO adw_proyecto.DIM_TIENDA(tienda_id, continente, pais)
SELECT
    st.territoryid AS tienda_id,
    st.name AS continente,
    cr.name AS pais
FROM
    adw.Sales_SalesTerritory st
JOIN
    adw.Person_CountryRegion cr ON st.countryregioncode = cr.countryregioncode;

INSERT INTO adw_proyecto.FACT_VENTAS (ventas_id, detalle_venta_id, valor, tasa_de_retorno, producto_id, fecha, tienda_id, cliente_id)
SELECT
    soh.SalesOrderID as ventas_id,
    sod.SalesOrderdetailid as detalle_venta_id,
    soh.SubTotal as valor,
    sod.Unitprice as tasa_de_retorno,
    sod.ProductId as producto_id,
    soh.OrderDate as fecha,
    soh.TerritoryId as tienda_id,
    soh.CustomerId as cliente_id
FROM
    adw.Sales_SalesOrderHeader soh
    JOIN adw.Sales_SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE
    NOT EXISTS (
        SELECT 1
        FROM adw_proyecto.FACT_VENTAS fv
        WHERE fv.ventas_id = soh.SalesOrderID
    );
