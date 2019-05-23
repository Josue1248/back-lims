create database lims
use lims

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'M3t@gr0ss'

create table Muestras(
id_muestra int PRIMARY KEY,
nombre varchar(11))

create table Pruebas(
id_prueba int PRIMARY KEY,
nombre varchar(30))

create table Operador(
id_operador int PRIMARY KEY)

create table Estado(
id_estado int PRIMARY KEY ,
nombre varchar(50))

create table Atributos(
id_atributo int PRIMARY KEY,
nombre varchar(12),
unidad varchar(5))

create table ValoresMuestras(
id_muestra int,
id_atributo int,
valor varchar(8))

create table Registros(
id_registro int PRIMARY KEY,
id_operador int,
id_muestra int,
id_estado int,
id_prueba int,
fecha datetime)

insert into Estado values (1, 'Prueba de electricidad pasada'),
	(2, 'Muestra lista para prueba de calor'),
	(3, 'Prueba de calor pasada'),
	(4, 'Muestra lista para prueba de química'),
	(5, 'Prueba de química pasada'),
	(6, 'Muestra lista para prueba de centrifugado'),
	(7, 'Prueba de centrifugadora pasada'),
	(8, 'Muestra utilizada');

insert into Pruebas values (1, 'Prueba de electricidad'),
	(2, 'Prueba de calor'),
	(3, 'Prueba de quimica'),
	(4, 'Prueba de centrifuga');

insert into Atributos values (1, 'Tiempo', 's'),
	(2, 'Temperatura', 'Cº'),
	(3, 'Quimico', ''),
	(4, 'Velocidad', 'rpm');

insert into Muestras values (10, 'MU-00-00010'),
	(20, 'MU-00-00020'),
	(30, 'MU-00-00030'),
	(40, 'MU-00-00040');

insert into Operador values (12345);

insert into ValoresMuestras values (20, 2, '100'),
	(20, 1, '120'),
	(30, 2, '100'),
	(30, 1, '120'),
	(30, 3, 'QU-00000'),
	(40, 2, '100'),
	(40, 1, '120'),
	(40, 3, 'QU-00000'),
	(40, 4, '1200');
	
insert into Registros values (1, 12345, 10, 1, 1, '2019-03-27'),
	(2, 12345, 10, 2, 1, '2019-03-27'),
	(3, 12345, 20, 1, 1, '2019-03-27'),
	(4, 12345, 20, 2, 1, '2019-03-27'),
	(5, 12345, 20, 3, 2, '2019-03-27'),
	(6, 12345, 20, 4, 2, '2019-03-27'),
	(7, 12345, 30, 1, 1, '2019-03-27'),
	(8, 12345, 30, 2, 1, '2019-03-27'),
	(9, 12345, 30, 3, 2, '2019-03-27'),
	(10, 12345, 30, 4, 2, '2019-03-27'),
	(11, 12345, 30, 5, 3, '2019-03-27'),
	(12, 12345, 30, 6, 3, '2019-03-27'),
	(13, 12345, 40, 1, 1, '2019-03-27'),
	(14, 12345, 40, 2, 1, '2019-03-27'),
	(15, 12345, 40, 3, 2, '2019-03-27'),
	(16, 12345, 40, 4, 2, '2019-03-27'),
	(17, 12345, 40, 5, 3, '2019-03-27'),
	(18, 12345, 40, 6, 3, '2019-03-27'),
	(19, 12345, 40, 7, 4, '2019-03-27'),
	(20, 12345, 40, 8, 4, '2019-03-27');

/* -CONSULTA TODOS LOS OPERADORES REGISTRADOS */
select * from Operador

/* -CONSULTA TODAS LAS PRUEBAS CONSIDERADAS */
select * from Pruebas

/*-CONSULTA TODOS LOS ATRIBUTOS POSIBLES DE UTILIZAR SOBRE MUESTRAS */
select * from Atributos

/* -CONSULTA LAS MUESTRAS REGISTRADAS Y LOS ATRIBUTOS RELACIONADOS CON ELLAS */
select M.nombre, A.nombre, V.valor, A.unidad from Muestras as M, ValoresMuestras as V, Atributos as A where M.id_muestra = V.id_muestra and A.id_atributo = V.id_atributo

/* -CONSULTA TODOS LOS REGISTROS LLEVADOS ACABO Y LAS MUESTRAS RELACIONADAS */
select * from Muestras as M, Registros as R where M.id_muestra = R.id_muestra

/* -CONSULTA TODOS LOS REGISTROS CORRESPONDIENTES A UNA SOLA MUESTRA */
select * from Muestras as M, Registros as R where M.id_muestra = R.id_muestra and M.id_muestra = 20

/* -CONSULTA TODAS LAS MUESTRAS PERTENECIENTES A UN SOLO REGISTRO Y EL ESTADO RELACIONADO */
select * from Muestras as M, Registros as R, Estado as E where M.id_muestra = R.id_muestra and R.id_registro = 10 and R.id_estado = E.id_estado

SELECT O.id_operador AS 'Operador', 
	M.nombre AS 'Muestra',
	E.nombre AS 'Estado',
	P.nombre AS 'Prueba',
	R.fecha AS 'Fecha'
FROM Registros as R
JOIN Estado as E ON R.id_estado = E.id_estado
JOIN Pruebas as P ON R.id_prueba = P.id_prueba
JOIN Operador as O ON R.id_operador = O.id_operador
JOIN Muestras as M ON R.id_muestra = M.id_muestra
WHERE R.id_muestra=30

/* -CONSULTA TODOS LOS ESTADOS DE "LISTO"*/
SELECT O.id_operador AS 'Operador', 
	M.nombre AS 'Muestra',
	E.nombre AS 'Estado',
	P.nombre AS 'Prueba',
	R.fecha AS 'Fecha'
FROM Registros as R
JOIN Estado as E ON R.id_estado = E.id_estado
JOIN Pruebas as P ON R.id_prueba = P.id_prueba
JOIN Operador as O ON R.id_operador = O.id_operador
JOIN Muestras as M ON R.id_muestra = M.id_muestra
WHERE R.id_muestra=40 and E.nombre like 'Muestra lista para%' ORDER BY R.fecha ASC

SELECT M.nombre AS 'Muestra',
	A.nombre as'Atributo',
    VM.valor as 'Valor'
FROM ValoresMuestras as VM
JOIN Atributos as A ON VM.id_atributo = A.id_atributo
JOIN Muestras as M ON VM.id_muestra = M.id_muestra
WHERE VM.id_muestra=20

SELECT * FROM ValoresMuestras WHERE valor='QU-00000'

SELECT M.nombre AS 'Muestra',
	A.nombre as'Atributo',
    VM.valor as 'Valor'
FROM ValoresMuestras as VM
JOIN Atributos as A ON VM.id_atributo = A.id_atributo
JOIN Muestras as M ON VM.id_muestra = M.id_muestra
WHERE VM.valor='QU-00000'
