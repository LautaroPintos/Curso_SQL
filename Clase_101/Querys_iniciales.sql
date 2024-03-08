-- ¿Cómo crear una base de datos?
create database practica;

-- ¿Cómo creamos una tabla?
create table usuarios (
    Campo1 string,
    Campo2 int,
    Campo3 float
)
comment 'Información de usuarios';

-- ¿Cómo podemos seleccionar la base de datos para usarla?
-- (de esta forma no tenemos que escribir más la BBDD)
use database practica;

-- ¿Cómo insertamos datos en la tabla?
insert into usuarios (nombre, apellido, edad)
values ('Jorge', 'Broun', 35),
       ('Ignacio', 'Malcorra', 33);

-- ¿Cómo hacemos una consulta a la tabla?
-- (Con asterisco lo que hacemos es seleccionar todos los campos)
select * from usuarios;

-- ¿Cómo eliminamos los registros de una tabla?
delete * from usuarios;

-- ¿Cómo actalizamos una tabla en base a una condición?
update usuario 
set nombre = "fatura"
where nombre = "Jorge" ;

-- ¿Cómo creamos una primery Key (PK)?
-- Es un campo que se tiende a autoincrementar sin tener valores duplicados
-- Esto lo hacemos al momento de crear la tabla. No podemos hacerlo modificando la tabla
create table usuarios (
    id_usuario int 
    Campo1 string,
    Campo2 int,
    Campo3 float,
    PRIMARY KEY('id_usuario' AUTO_INCREMENT)
)
comment 'Información de usuarios';

-- Dependiendo el gestor de base de datos a veces se hace como:
create table usuarios (
    id_usuario int AUTO_INCREMENT PRIMARY KEY,
    Campo1 string,
    Campo2 int,
    Campo3 float,
)
comment 'Información de usuarios';

-- ¿Cómo podemos crear una clave foranea dentro de una tabla?
create table usuarios (
    id_usuario int AUTO_INCREMENT PRIMARY KEY,
    Campo1 string,
    Campo2 int,
    Campo3 float,
    id_otra_tabla int,
    FOREIGN KEY (id_clientes) REFERENCES tabla_clientes (id_clientes)
);







