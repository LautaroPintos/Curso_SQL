-- 1. Hacemos una primera vista de la tabla
select * from Employees e limit 10;
select * from Products p  limit 10;


-- 2. Creamos una nueva tabla pero solamente con nombres y apellidos y cambiandoles el nombre
SELECT LastName as Apellido, FirstName as nombre from Employees e ;


-- 3. Como realizamos cálculos en la tabla
select Price , Price*2 as precio_bis from Products p ;


-- 4. Ordenamos la tabla de forma ascendente
select * from Products p order by Price ASC ;


-- 5. Ordenamos la tabla de forma descendente
select * from Products p order by Price DESC  ;


-- 6. Ordenamos la tabla de forma descendente. ¿Cómo es el orden jerarquico para el ordenamiento?
-- Letras, caracteres especiales, números y, por último, nulos.
-- En este caso los nulos por ejemplo aparecerían primero, pero si la tabla estaría ordenada ascendente
-- lo primero que mostraría la tabla son los nulos
select * from Products p order by ProductName  DESC  ;


-- 7. ¿Cómo hacer para ordenar la tabla ascendentemente y poner los nulos al final?
-- AL final de la sentencia podemos escribri "nulls last" o "nulls first". Siempre teniendo en cuenta
-- que dependiendo de como funcione la base de datos con la que estamos trabajando podemos tener
-- diferencias en las sentencias.


-- 8. ¿Cómo hacemos un select distinct y además ordenarlos de forma aleatoria?
SELECT DISTINCT ProductName  
from Products p ORDER BY rand();


-- 9. ¿Cómo aplicamos condiciones a la hora de ejecutar la consulta?
-- SQL trabaja mirando registro por registro comprobando las condiciones
select * 
from Products p where ProductID = 14; 

select * 
from Products p where ProductName = "Tofu";

select * 
from Products p where Price >= 40;


-- 10. Operadores lógicos en una condición ("and")
select * 
from Customers c where CustomerID >= 50 and CustomerID < 55;


-- 11 Operadores lógicos en una condición ("or")
select * 
from Employees e where FirstName = "Nancy" or FirstName = 'Anne';


-- 12 Operadores lógicos en una condición ("or" y "and" juntos)
-- En estos casos es muy importante el uso de parentesis porque eso puede cambiar la consulta
select *
from Products p 
where price < 20 or (CategoryID = 6 and SupplierID = 7);

select *
from Products p 
where (price < 20 or CategoryID = 6) and SupplierID = 7;


-- 14 condición not en las clausulas where
select *
from Employees e 
where not FirstName = "Nancy";


-- Estos son los resultados que no son de francia y no son de méxico
select *
from Customers c 
where not Country = "France" and not Country = "Mexico";


-- 15. ¿Cómo podemos usar la clausula limit eficientemente: Es una forma de tener un rango de valores
select * 
from Customers c where CustomerID >= 50 and not Country = "Argentina"
limit 5;

-- 16 ¿Cómo utilizar el limit con un random? Para eso tenemos que agregar la clausula order by
SELECT *
from Products p 
where not CategoryID = 6
and not SupplierID = 1
and Price <= 30
ORDER by RAND() 
limit 3; 


-- 17. ¿Cual es la diferencia entre el operador "distinto de" en lugar del not?
-- el operador "distinto de" es un operador de comparación (es distinto de un operador lógico o booleano)
-- Por otro lado, "not" es un operador booleano.
select *
from Employees e 
where FirstName != "Nancy";

select *
from Employees e 
where not FALSE ;

select *
from Employees e 
where not TRUE  ;

select *
from Employees e 
where TRUE or TRUE;

select *
from Employees e 
where FALSE or TRUE;


-- 18. Operador between. Algo a tener en cuenta es que between incluye los límites y siempre
-- trabaja de menor a mayor entre el mismo tipo de datos
SELECT *
from Products p 
where (Price BETWEEN 20 and 40) and CategoryID = 7


SELECT *
from Products p 
where not (Price BETWEEN 20 and 40)


-- 19 ¿Cómo usamos between para seleccionar fechas?
select *
from Employees e 
where BirthDate BETWEEN "1960-01-1" and "1970-01-1"


-- 20. Operador like es un operador de comparación que se parece a las expresiones regulares
-- pero mucho más simple. Like funciona como un igual pero tiene ciertos comodines.
-- Comodin 1: "%ling" el porcentaje dice que puede haber cosas antes del string detallado.
-- Podemos usar esto para buscar palabras que contangan "pepe" haciendo like "%pepe%"
-- Comodin 2: "Lerver_ing" el "_" sirve para especificarle que ahí hay un caracter pero no sabemos cual
-- Recordar que podemos combinarlo con los distintos operadores lógicos
select *
from Employees e 
where LastName LIKE "%ling"

select *
from Employees e 
where LastName LIKE "Lever_ing"


-- 21. Operador is null o is not null. Acá también se puede jugar con el operador NOT 
select * 
from Products p 
where ProductName is not NULL 
order by ProductName ASC 

select * 
from Products p 
where ProductName is NULL 
order by ProductName ASC 

select * 
from Products p 
where not ProductName is NULL 
order by ProductName ASC 


-- 22. Operador IN (cuarto operador lógico). Esto es una forma elegante de concatenar operadores OR.
-- Obviamente esto lo podemos cancelar con un operador NOT antes.
select * 
from Products p 
where SupplierID in (3,4,5,6)

select * 
from Products p 
where not SupplierID in (3,4,5,6)

select * 
from Products p 
where SupplierID not in (3,4,5,6)

select * 
from Employees e  
where LastName in ("Fuller", "King")


-- 23. Funciones de agregacion (count, sum, avg, min)
select count(FirstName) as cantidad_nombres from Employees e ;

select sum(Price) from Products p 

select avg(Price) from Products p 

select round(avg(Price), 1) as promediofrom from Products p 

-- Depende de como este configurada la base de datos van a poder utilizar este tipo de sentencias
-- pero en otros casos van a necesitar incluir todos los campos que no sean agregaciones dentro de una
-- clausula group by
select ProductName, min(Price) from Products p 


-- 24. Group by y having.
-- Sentencia básica de como aplicar un group by
select SupplierID , round(avg(price)) as promedio
from Products p 
group by SupplierID 
order by promedio DESC 


-- ¿Qué sucede si incluimos una variable y  no la incluimos dentro del group by?
-- Nos muestra el primer registro que aparezca con el supplier ID.
-- Obviamente esto no es posible en mysql
select ProductName , SupplierID , round(avg(price)) as promedio
from Products p 
group by SupplierID 
order by promedio DESC 


-- ¿Cómo funciona internamente? Primero tenemos que utilizar las condiciones (where) y luego los group by
-- Además, es importante saber que con el where no podemos hacer uso de la función de agregación porque
-- las funciones de agregación trabajan con grupos y no con registros (aunque sea intuitivamente lo mismo)
-- La clasula having filtra grupos. Con lo cual, si queremos filtrar una agrupación haciendo referencia
-- a una función de agregación tenemos que usar el having que se utilizar luego del group by.
select SupplierID , round(avg(price)) as promedio
from Products p 
group by SupplierID 
having promedio > 40
order by promedio DESC 

-- Adicionalmente, podemos filtrar la tabla para que ciertos campos no se incluyan dentro del promedio
-- Lo que vemos acá es que estamos eliminando algunos registros del supplier_id 12 y por eso tenemos
-- otros resultados en la tabla
select SupplierID , round(avg(price)) as promedio
from Products p 
where ProductID not BETWEEN 75 and 77
group by SupplierID 
having promedio > 40
order by promedio DESC 

-- Lo que si no podemos hacer es mezclar dos funciones de agregación en una misma sentencia.
-- Por ejemplo que querramo el máximo promedio de precio de los suppliers_id
select SupplierID , round(avg(price)) as promedio
from Products p 
where ProductID not BETWEEN 75 and 77
group by SupplierID 
having max(promedio)
order by promedio DESC 

-- Para hacer esto directamente podemos ordenar y aplicar un limit 1
select SupplierID , round(avg(price)) as promedio
from Products p 
where ProductID not BETWEEN 75 and 77
group by SupplierID 
order by promedio DESC 
limit 1


-- 25. Subquerys o subconsultas
-- ¿Que sucede si ahora queremos relacionar tablas? Las subconsultas es una forma no tan eficiente
-- de relacionar tablas. Las subconsultas nos devuelven información es por eso que siempre son selects.
-- ¿Para que se utilizan? 
-- Por ejemplo dentro de un where para realizar un filtro
-- También dentro de un from para crear una especie de tabla virtual
-- Dentro de un having para aplicar un filtro dentro de una agrupación

select ProductID , Quantity  from OrderDetails od 

select * from Products p 

-- ¿Que pasa si en la primera tabla queremos saber el nombre del producto?
-- Podemos juntar las tablas haciendo uso de su primary key
select  ProductID ,
		Quantity ,
		(select ProductName from Products where od.ProductID = ProductID) as nombre_producto,
		(select price from Products where od.ProductID = ProductID) as precio
from OrderDetails od 

select  ProductID , 
		sum(Quantity) as total_vendido  ,
		(select price from Products p where od.ProductID = ProductID) as Precio
from OrderDetails od 
group by ProductID 

-- ¿Que sucede si ahora queremos multiplicar el precio por el total_vendido?
-- Lo importante para recordar es que en el select no podemos usar alias para hacer operaciones matemáticas
-- en esos casos deberíamos copiar ambas consultas nuevamente
select  ProductID , 
		sum(Quantity) as total_vendido  ,
		(select productname from Products p where od.ProductID = ProductID) as nombre,
		(select price from Products p where od.ProductID = ProductID) as Precio,
		(sum(Quantity) * (select price from Products p where od.ProductID = ProductID)) as recaudacion
from OrderDetails od 
group by ProductID 
order by recaudacion DESC 

-- EL problema: Las sub consultas son muy pesadas. Para esto es mejor utilizar joins.

-- ¿Cómo utilizamos una subconsulta dentro de un where?
select  ProductID , 
		sum(Quantity) as total_vendido  ,
		(select productname from Products p where od.ProductID = ProductID) as nombre,
--		(select price from Products p where od.ProductID = ProductID) as Precio,
		(sum(Quantity) * (select price from Products p where od.ProductID = ProductID)) as recaudacion
from OrderDetails od 
where (select price from Products p where od.ProductID = ProductID) > 40
group by ProductID 
order by recaudacion DESC ;

-- ¿Cómo utilizamos una subconsulta dentro de un from?
-- Algo importante en MySQL es que tenemos que defnirle un nombre a la tabla para que la subquery funcione
select  nombre,
		recaudacion
from (select  ProductID , 
		sum(Quantity) as total_vendido  ,
		(select productname from Products p where od.ProductID = ProductID) as nombre,
--		(select price from Products p where od.ProductID = ProductID) as Precio,
		(sum(Quantity) * (select price from Products p where od.ProductID = ProductID)) as recaudacion
		from OrderDetails od 
		where ( select price  from Products p where od.ProductID = ProductID) > 40
		group by ProductID 
		order by recaudacion DESC) as subquery
where recaudacion > 1000;


/*    Ejercicio complejo de subconsultas :
 * 	  Queremos ver la cantidad de ventas que tiene un empleado  */


-- Lo primero que vemos acá es para cada empleado que tenemos. Esta es una forma de hacer joins
-- entre tablas por su primary key pero dentro de una sentencia where. Por esto a adam me lo trae
-- como nulo dado que no se encuentra en la tabla de orders.
select FirstName , LastName ,
	(select sum(od.quantity) from Orders o , OrderDetails od 
	 where o.EmployeeID = e.EmployeeID and o.orderID = od.orderID) as unidades
from Employees e ;

-- corroboramos: Correcto
select distinct o.EmployeeID  from Orders o ;
select * from Employees e ;


-- ¿Que pasa si ahora queremos utilizar filtrar por las unidades mayores al promedio?
-- Esto no nos devuelve nada porque al agrupar por empleado, las unidades terminan siendo un único valor
-- con lo cual parece que si queremos mantener la subconsulta no podemos agrupar.
select FirstName , LastName ,
	(select sum(od.quantity) from Orders o , OrderDetails od 
	where o.EmployeeID = e.EmployeeID and o.orderID = od.orderID) as unidades
from Employees e 
group by e.EmployeeID 
having unidades > avg(unidades);

-- Probamos con un where entonces. Pero acá tenemos dos problemas:
-- El primero: No podemos llamar a unidades dentro del where en mysql con lo cual 
-- 				tenemos que reescribir la subquery. (Solucionado abajo)
-- El segundo: Es que tenemos que calcular el promedio de unidades y no podemos
select FirstName , LastName ,
	(select sum(od.quantity) from Orders o , OrderDetails od 
	where o.EmployeeID = e.EmployeeID and o.orderID = od.orderID) as unidades
from Employees e 
where (select sum(od.quantity) from Orders o , OrderDetails od 
	where o.EmployeeID = e.EmployeeID and o.orderID = od.orderID) > 28;

-- Para atacar el problema dos tenemos que hacer una subconsulta de una subconsulta. Expliquemos en detalle esto:
-- 1) Las primeras 4 filas son exactamente igual.
-- 2) Sabemos además que dentro de los where no podemos tener campos calculados en MySQL con lo cual, para que
-- 		el campo unidades sea mayor al promedio no podemos escribir unidades sino toda la sentencia.
-- 3) Tenemos que calcular el promedio de la tabla que vimos antes-
--			Ese promedio es el promedio de una columna que se llma nuevas_unidades pero que se crea sobre
--			la tabla de empleados.
-- 			Tenemos que recordar que todas las subconsultas en MySQL tiene que tener un alias cuando
-- 			creamos una tabla (ya sea en formato columna o campo para comparar)
	
select FirstName , LastName ,
	(select sum(od.quantity) from Orders o , OrderDetails od 
	where o.EmployeeID = e.EmployeeID and o.orderID = od.orderID) as unidades
from Employees e 
where (select sum(od.quantity) from Orders o , OrderDetails od 
		where o.EmployeeID = e.EmployeeID and o.orderID = od.orderID) > (select avg(nuevas_unidades) from (
		select ( select sum(od2.quantity) from Orders o2 , OrderDetails od2 
					where o2.EmployeeID = e2.EmployeeID and o2.orderID = od2.orderID) as nuevas_unidades
		from  Employees e2 
		group by e2.EmployeeID) as subquery); 
	
		
-- Acá podemos el cálculo del punto 3. Que se lee mucho mejor cuando identamos el código
select avg(nuevas_unidades) 
from (select (
			select sum(od2.quantity) 
			from Orders o2 , OrderDetails od2 
		    where o2.EmployeeID = e2.EmployeeID and o2.orderID = od2.orderID) as nuevas_unidades
		from  Employees e2 
		group by e2.EmployeeID) as subquery ;
	
	
/*   JOINS      */
	
-- inner join: Hay dos formas de utilizar inner joins. La forma implicita y la forma explicita.
-- En las sentencias anteriores sin decir nada hicimos un join.
-- Esto lo que esta haciendo es un producto cartesiano (nrow tabla 1 x nrow tabla 2)
-- En este resultado tenemos una tabla de 1960 registros porque la tabla orders tiene 196 registros
-- y la tabla de empleados tiene 10 registros
select * 
from Orders o , Employees e  

		
-- Si nosotros ahora le agregamos una condición a estas tablas basicamente estamos filtrando
-- el producto cartesiano por los valores de empleados que COINCIDAN EN AMBAS TABLAS.
select * 
from Orders o , Employees e  
where o.EmployeeID = e.EmployeeID 


-- La forma explicita de hacer un inner join es...
select * 
from Orders o 
inner join Employees e on o.EmployeeID = e.EmployeeID 		
		

-- Ahora lo que vamos a hacer es crear una tabla para luego realizar joins más complejos
create table Northwind.Rewards (
RewardID integer auto_increment primary key,
EmployeeID integer,
Reward integer,
Month Varchar(100)
)

-- Ahora lo que hacemos es insertar datos en la tabla
insert into Northwind.Rewards (EmployeeID, Reward, Month)
	values  (3, 200, "January"),
			(2, 180, "February"),
			(5, 250, "March"),
			(1, 280, "April"),
			(8, 160, "May"),
			(null, null, "June");


-- 26. Inner Join. Esto se puede hacer con subconsultas lo que sucede es que es mucho menos eficientes dado
-- que esa forma tiene que buscar en toda la tabla y luego filtrar. En este caso, usando joins lo que sucede
-- es que SQL trabaja con indices.
select e.FirstName , r.Reward, r.Month
from Employees e 
inner join Rewards r on e.EmployeeID = r.EmployeeID 


-- 27. left join. Esto es exactamente igual a un right join pero invirtiendo las tablas
select e.FirstName , r.Reward, r.Month
from Employees e 
left join Rewards r on e.EmployeeID = r.EmployeeID 


-- 28. Full join. El full join se llama full outter join, no nos devuelve un producto cartersiano cruzado
-- porque en ese caso se estan multiplicando en lugar de sumarse. En MySQL no soporta hacer full joins con
-- lo cual la forma de hacerlo es con. En SQlite funciona de la misma manera. Se tiene que simular el left
-- y el right a través de un union.

select e.FirstName , r.Reward, r.Month
from Employees e 
left join Rewards r on e.EmployeeID = r.EmployeeID 

UNION

select e.FirstName , r.Reward, r.Month
from Employees e 
right join Rewards r on e.EmployeeID = r.EmployeeID 


-- 29. Union. Se combinan dos o más consultas (tablas). Lo que sucede es que si se repiten filas, union lo
-- que hace es devolver los campos no repetidos. Por eso también existe el union all. Lo importante del
-- union es que la consulta con las que unimos tienen que tener los mismos campos.

select e.FirstName , r.Reward, r.Month
from Employees e 
left join Rewards r on e.EmployeeID = r.EmployeeID 

UNION all

select e.FirstName , r.Reward, r.Month
from Employees e 
right join Rewards r on e.EmployeeID = r.EmployeeID 















		
		
