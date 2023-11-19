-- top 5 productos por categoria 
SELECT *
FROM (
    SELECT
        dp.*,
        ROW_NUMBER() OVER (PARTITION BY dp.category ORDER BY fv.valor DESC) AS ranking
    FROM
        FACT_VENTAS fv
        JOIN DIM_PRODUCTO dp ON fv.producto_id = dp.producto_id
) ranked
WHERE
    ranking <= 5;

-- Top 5 productos por subcategoria 
SELECT *
FROM (
    SELECT
        dp.*,
        ROW_NUMBER() OVER (PARTITION BY dp.sub_category ORDER BY fv.valor DESC) AS ranking
    FROM
        FACT_VENTAS fv
        JOIN DIM_PRODUCTO dp ON fv.producto_id = dp.producto_id
) ranked
WHERE
    ranking <= 5;

-- Top 5 productos por continente
CREATE TABLE TOP_PRODUCTOS_POR_CONTINENTE AS
SELECT *
FROM (
    SELECT
        dt.continente,
        dp.*,
        ROW_NUMBER() OVER (PARTITION BY dt.continente ORDER BY fv.valor DESC) AS ranking
    FROM
        FACT_VENTAS fv
        JOIN DIM_PRODUCTO dp ON fv.producto_id = dp.producto_id
        JOIN DIM_TIENDA dt ON fv.tienda_id = dt.tienda_id
) ranked_data
WHERE
    ranking <= 5;

SELECT * FROM TOP_PRODUCTOS_POR_CONTINENTE;


-- Numero de tiendas 


-- top productos por ventas
SELECT
    dp.nombre AS nombre_producto,
    dp.category AS categoria,
    dp.sub_category AS subcategoria,
    SUM(fv.valor) AS total_ventas
FROM FACT_VENTAS fv
JOIN DIM_PRODUCTO dp ON fv.producto_id = dp.producto_id
GROUP BY dp.producto_id
ORDER BY total_ventas DESC
LIMIT 5;
 

--top 5 vendidos por año
SELECT *
FROM (
    SELECT
        df.ano,
        dp.producto_id,
        dp.nombre AS nombre_producto,
        SUM(fv.valor) AS total_ventas,
        ROW_NUMBER() OVER (PARTITION BY df.ano ORDER BY SUM(fv.valor) DESC) AS ranking
    FROM
        FACT_VENTAS fv
        JOIN DIM_PRODUCTO dp ON fv.producto_id = dp.producto_id
        JOIN DIM_FECHA df ON fv.fecha = df.fecha
    GROUP BY
        df.ano,
        dp.producto_id,
        dp.nombre
) ranked
WHERE
    ranking <= 5
ORDER BY
    ano,
    total_ventas DESC;
