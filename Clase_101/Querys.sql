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