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
* MySQL (contenedor de docker)
* DBeaver
* Base de datos: Northwind

Documentación de base de datos Northwind:

* https://en.wikiversity.org/wiki/Database_Examples/Northwind/MySQL

Lo primero que tenemos que hacer es crear el archivo de docker-compose.yaml para poder
correr la imagen ¿Por qué lo hacemos a través de docker-compose? Dado que es una buena
práctica y puede ser medio engorroso cuando necesitamos definir variables de entorno, volumenes, puertos, etc.

Lo primero que hacemos una vez seteado el archivo de docker compose es ejecutarlo para levantar el contenedor. En caso que no hayamos hecho el pull, esto lo va a hacer por nosotros también.

```docker
docker-compose up -d
```

Algo útil para esto es chequear la IP donde esta levantado el contenedor

```docker
docker inspect mysql
```

Luego lo que vamos a hacer es entrar al contenedor

```docker
docker exec -it mysql bash
```

Una vez dentro del contenedor, tenemos que acceder a nuestra base de datos. Para esto fue necesario realizar el docker inspect

```docker
mysql -h 172.18.0.2 -u root -p
```

En caso de cualquier falla acá hay un video que nos explica como realizarlo:

* https://www.youtube.com/watch?v=XMPYAouPLvo


Una vez que tenemos mysql dentro del contenedor tenemos que proceder a crear la base de datos northwind. Para eso vamos a copiar el script de la base de datos dentro del contenedor

```docker
docker cp ./northwind.sql mysql:/northwind.sql
```

Una vez dentro de mysql lo que tenemos que hacer es ejecutar el código que copiamos dentro del contenedor:

```sql
source ./northwind.sql
```

Una vez que el proceso finaliza correctamente tenemos que realizar la conexión con DBeaver para poder realizar las consultas de forma fácil para poder proseguir con el curso.


#### Como se empieza a trabjar con SQL

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


#### ¿Cual es el orden para ejecutar las sentencias?

SI bien esto es algo que se va a ir viendo a lo largo del curso. La jerarquía para ejecutar sentencias en SQL es:

1)  select ... from
2)  where
3)  group by
4)  having
5)  order by
6)  Limit


#### Cardinalidad (notación de chen)

La cardinalidad se utiliza para especificar la relación que hay entre dos entidades. En particular, nos dice como se relacionan las claves que vimos antes ¿Qué tipos hay?

* **1:1** un registro de una tabla se relaciona con un registro en otra tabla (ej: una tabla con clientes y otra tabla con números de documentos de los clientes)

* **1:n** o **n:1** un registro de una tabla se relaciona con muchos registros de otra tabla (ej: Una tabla de clientes y otra de zona geográfica donde vive, cada cliente tiene una sola ubicación pero una ubicación tiene muchos clientes)

* **n:m** un registro en una tabla se relaciona con varios registros en una tabla y viceversa. (ej: una tabla de estudiantes y una tabla de cursos, un estudiante puede tomar varios cursos y un curso puede ser tomado por varios estudiantes)

Para manejar ese último tipo se utilizan tablas intermedias donde cada una de las tablas tiene una relación **1:n** con la nueva tabla intermedia


#### Normalización de base de datos

La normalización es un proceso que nos sirve para eliminar anomalias y hacer que la base de datos sea más eficiente. Los niveles de normalización se conocen como "formas normales":

* **1NF**: Cada atributo (columna) contenga una valor único atómico. No podemos tener en un valores que sean conjuntos o listas. Tampoco tenemos que tener valores repetidos en una fila

* **2NF**: Cada atributo que no sea un key tiene que depender de toda la clave primaria. Esto busca eliminar el problema de las *dependencias parciales*. Es decir, no podemos tener atributos que dependan de otro atributo (llamemoslo atributo*). Para eso tenemos que crear una tabla separada donde atributo* sea nuestra primary key y los atributos en cuestión. EJ: Tenemos una tabla que tiene cliente_id, nombre, producto_id y nombre del producto, acá el campo que esta incorrecto es nombre del producto.

* **3NF**: Estable que cada tributo debe depender de la clave primaria y no de atributos que no son claves. No tiene que haber *dependencias transitivas*. Es decir, no podemos tener un atributo que dependa de otro que si dependa directamente de la key. Ej: Tenemos una tabla que tiene cliente_id, nombre, provincia y departamente. Esto lo deberíamos escribir en otra tabla. Entonces tendríamos dos tablas una para "cliente_id", "nombre" y "zona_id" y otra para la dimensión de zonas con "zona_id", "provincia" y "estado".

* **4NF**: Estable que cada tabla tiene que tener una clave primaria compuesta con el objetivo de eliminar dependencias multivaluadas. Esto suele pasar mucho con las subcategorías donde un producto puede tener una categoria pero muchas subcategorias aunque una subcategoria este asociada directamente con una categoria.



















