
/* Distintas funciones y ejercicios que no vimos antes */

-- Obtener Product_name y Unit_Price de la tabla products, y si Unit_Price es NULL, use el precio de 10 en su lugar
-- En este caso el coalesce sirve para expresar una lista de resultados posible
-- en caso de que el campo sea nulo. Es muy util en los full joins.
select productname , coalesce (Price, 10) as Price
from products p 

-- Obtener el nombre de los productos que nunca han sido pedidos por clientes de Francia
select product_name 
from products p 
where ProductID not in (select distinct od.ProductID
			from OrderDetails od 
			left join orders o on od.orderID = o.orderID 
			left join customers c on o.CustomerID = c.CustomerID
			where c.country = 'France');


-- Obtener el nombre del producto y su categoría, pero muestre discontinued en lugar del nombre de la categoría
-- si el producto se ha discontinuado.
-- Las clasulas case when sirve para crear una condición a la hora de crear un atributo
select 
	p.productname,
	case when p.discontinued = 1 then 'discontinued'
	else c.CategoryName end as Categoria
from products p 
left join categories c 
on p.CategoryID = c.CategoryID 


/* Windows functions :
Son similares a las agregaciones que se realizan en las sentencias group by pero en
lugar de agrupar los resultados en una sola fila pero lo podemos realizar por cada
una de las filas. Es decir que cada fila conservaría su identidad.*/

-- Obtener el promedio de precios por cada categoría de producto. 
-- La cláusula OVER(PARTITION BY CategoryID) específica que se debe calcular 
--el promedio de precios por cada valor único de CategoryID en la tabla.
select 
	c.CategoryName,
	p.productname,
	p.Price,
	avg(p.Price) over (partition by p.CategoryID) as avgpricebycategory 
from products p 
left join categories c on p.CategoryID = c.CategoryID 


-- Obtener la suma de venta de cada cliente.
select 
	sum(od.Price * od.quantity) over (partition by o.CustomerID) as sumaVenta,
	o.*
from OrderDetails od 
left join orders o on od.orderID = o.orderID 

-- Seleccione el id de producto, el nombre de producto, el precio unitario, 
-- el id de categoría y el precio unitario máximo para cada categoría de la tabla Products
select 
	p.ProductID ,
	p.productname ,
	p.Price ,
	c.CategoryID ,
	max(p.price) over (partition by c.CategoryID) as maxunitprice
from products p 
left join categories c on p.CategoryID = c.CategoryID 


-- Obtener el ranking de los productos más vendidos
-- row_number determina el numero ordinal de la fila pero dentro de un grupo de filas
select 
	p.ProductName ,
	a.totalquantity,
	row_number () over (order by a.totalquantity desc) as ranking
from products p 
left join (select od.ProductID , sum(od.quantity) as totalquantity from OrderDetails od group by od.ProductID) as a
on p.ProductID = a.ProductID 


-- Ranking de empleados por fecha de contratación
-- Rank si queremos ver la posición de cualqueir fila dentro de una partición
select 
	EmployeeID ,
	FirstName ,
	LastName ,
	BirthDate ,
	rank () over (order by BirthDate) as ranking
from Employees e 

-- Mostrar por cada producto de una orden, la cantidad vendida y la cantidad vendida del producto previo.
select 
	orderID ,
	ProductID ,
	quantity ,
	lag(quantity, 1) over (order by orderID) as cantidadAnterior
from OrderDetails od 

-- Obtener un listado que muestra el precio de un producto junto con el precio 
-- del producto siguiente
select 
	ProductID ,
	productname ,
	Price ,
	lead(Price, 1) over (order by ProductID) as productoSig
from products p 


-- Ejercicio integrador
-- Crear una vista temporal que nos muestre los 3 productos más vendidos
-- por categoria. Utilizar la expreción With para darle orden a las distintas
-- subconsultas que se tienen que crear.
WITH total_sales_per_product AS (
    SELECT
        od.ProductID,
        SUM(od.Quantity) AS TotalQuantity
    FROM
        OrderDetails od
    GROUP BY
        od.ProductID
),
ranked_products AS (
    SELECT
        tp.ProductID,
        tp.ProductName,
        tp.CategoryID,
        tp.UnitPrice,
        tp.UnitsInStock,
        tp.UnitsOnOrder,
        ts.TotalQuantity,
        RANK() OVER (PARTITION BY tp.CategoryID ORDER BY ts.TotalQuantity DESC) AS SalesRank
    FROM
        Products tp
    JOIN
        total_sales_per_product ts ON tp.ProductID = ts.ProductID
)
CREATE TEMPORARY VIEW top_products_by_category AS
SELECT
    r.ProductID,
    r.ProductName,
    c.CategoryName,
    r.UnitPrice,
    r.UnitsInStock,
    r.UnitsOnOrder,
    r.TotalQuantity,
    r.SalesRank
FROM
    ranked_products r
JOIN
    Categories c ON r.CategoryID = c.CategoryID
WHERE
    r.SalesRank <= 3;  -- Mostrar solo los 3 productos más vendidos por categoría

