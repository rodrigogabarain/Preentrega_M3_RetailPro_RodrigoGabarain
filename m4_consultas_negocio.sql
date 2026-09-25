
------------------------------------------------------------
-- Consulta 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio
------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

------------------------------------------------------------
-- Consulta 2: Ranking de productos (Top 5)
-- Total facturado y unidades vendidas por producto
------------------------------------------------------------
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;

------------------------------------------------------------
-- Consulta 3: Clientes recurrentes
-- Clientes con más de un pedido
------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC;

------------------------------------------------------------
-- Consulta 4: Meses por encima/por debajo del promedio
-- Etiquetar cada mes según el promedio general
------------------------------------------------------------
WITH facturacion_mensual AS (
    SELECT 
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
)
SELECT 
    mes,
    total_facturado,
    CASE 
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM facturacion_mensual) 
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_mensual
ORDER BY mes;

----------------------------------------------------------------------------
-- Bloque de hallazgos
-- 1) En marzo (mes 3) se facturaron $6444, por debajo del promedio mensual.
-- 2) El producto con mayor facturación fue el id_producto 1.
-- 3) El cliente con más pedidos fue el id_cliente 2, considerado recurrente.
-----------------------------------------------------------------------------
