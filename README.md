## Curso de SQL

SQL es un lenguaje de programación que significa lenguaje de consultas estructuradas (Structure Query Language). Es el lenguaje que nos permite trabajar con bases de datos relacionales. Todos los gestores de bases de datos trabajan con SQL.

SQL nos va a permitir crear y administrar bases de datos aunque mayormente (y para quien esta destinado este curso) lo vamos a utilizar para consultar datos.

Glosario básico:

* Base de datos: Es un conjunto de información estructurada (aunque también tenemos de no estructurados) a la que podemos acceder para hacer consultas.
* Entidad: Es una representación de algo. Generalmente esto lo vemos como tablas (Ej: Persona)
* Atributos: Son características particulares de la entidad.Existen atributos simples o compuestos (los que pueden ser generados por otros atributos simples)
* Key: Es una forma única de identificar algo dentro de la entidad. (Ej: DNI de la persona)

Glosario auxiliar:

* Tabla: Es una estructura de datos que la podemos organizar en filas y columnas
* Registros: Es una fila de la tabla.
* Campo: Son los nombres de las columnas de la tabla.


¿Qué tipos de bases de datos (o gestores de bases de datos) existen? Muchas, Mysql, Postgres, SQLite, SQLserver, Oracle, etc.

#### ¿Qué necesitamos para arrancar el curso?

Vamos a trabajar con la base de datos northwind que es una base de datos relacional que es altamente utilizada para realizar pruebas. Entonces que necesitamos instalar:

* Docker
* SQlite (contenedor de docker)
* DBeaver
* Base de datos: Northwind

Documentación de base de datos Northwind:

* https://en.wikiversity.org/wiki/Database_Examples/Northwind/SQLite


#### Como se empieza a trabjar con SQL (Clase_101)

Lo primero que tenemos que hacer es crear una base de datos y luego crear una tabla dentro de la base de datos. Cuando creamos la tabla tenemos que setear la estructura de primera mano y, al momento de crearla, vamos a tener que definir los tipos de datos que se van a almacenar en cada uno de los campos. Esto puede cambiar dependiendo el gestor de base de datos (Ej: podemos tener formato text o formato string)

Lo siguiente es realizarle una consulta a la base de datos y en particular a la tabla. La sentencia que nos permite hacer esto es "**Select**". Todo en realidad es una query en SQL.

¿Cuales son los primeros pasos entonces?

* Crear una base de datos
* Crear una tabla
* Insertar información en la tabla
* Realizar consultas

Nota: **CRUD:** Create, Read, Update, Delete.

Algo importante es que todas las sentencias "Select" nos devuelven una tabla nueva. Cuando antes generamos un glosario dos fue por este motivo. Una entidad se representa como una tabla pero podemos tener tablas que sean entidades y tablas que sean consultas sobre una entidad específica.

Cuando trabajamos con tablas muchas veces tenemos filas repetidas. Filas que son exactamente igual. Esto nosotros lo vamos a visualizar en la tabla pero en términos de metadatos esos dos campos son iguales ¿Cómo podemos diferenciar los registros entonces? Usamos **identificadores**

Hay dos tipos de identificadores: "Primary Keys" y "Foreign Keys". Las claves primerias no se pueden repetir solo si se "convierten" en claves foraneas. Una "Foreign Keys" dentro de una tabla siempre es una "Primary Key" de otra tabla. De esta forma podemos entender y relacionar tablas correctamente.












