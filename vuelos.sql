create schema vuelos2;

use vuelos2;

select schema();

create table marcas(
	codigo int primary key,
    nombre varchar(45),
    pais varchar(45)
    );
    
show create table marcas;

create table aviones(
	matricula varchar(45) primary key,
    marcas_codigo int not null,
    modelo varchar(45),
    fecha_entrada_servicio date,
    foreign key (marcas_codigo) references marcas(codigo)
    );
    
create table aeropuertos(
	codigo varchar(45) primary key,
    nombre varchar(45),
    ciudad varchar (45)
);

create table calle(
	codigo int primary key,
    nombre varchar(45)
);
create table provincia(
	codigo int primary key,
    nombre varchar(45)
  );
create table localidad(
	codigo int primary key,
    nombre varchar(45)
);

create table pilotos(
	cuil varchar(45)primary key,
    dni int ,
    nombre varchar(45),
    apellido varchar(45),
    fecha_ingreso date,
    calle_idcalle int,
    numero int,
    localidad_idlocalidad int,
    provincia_idprovincia int,
    foreign key (calle_idcalle) references calle(codigo),
    foreign key (localidad_idlocalidad) references localidad(codigo),
    foreign key (provincia_idprovincia) references provincia(codigo)
    
);

select * from pilotos;

create table pasajeros(
	dni int primary key,
    nombre varchar(45),
    apellido varchar(45),
    viajero_frecuente boolean,
    calle_idcalle int,
    numero int,
    localidad_idlocalidad int,
    provincia_idprovincia int,
	foreign key (calle_idcalle) references calle (codigo),
    foreign key (provincia_idprovincia ) references provincia(codigo),
    foreign key (localidad_idlocalidad) references localidad(codigo)
);

CREATE TABLE vuelos (
	codigo varchar(45) primary key,
    aviones_marticula varchar(45),
    cuil varchar(45),
    aeropuertos_codigo_origen varchar(45),
    aeropuertos_codigo_destino varchar(45),
    fecha_hora_partida datetime,
    fecha_hora_llegada datetime,
    distancia int,
    
    foreign key (cuil) references pilotos(cuil),
	foreign key (aeropuertos_codigo_origen) references aeropuertos(codigo),
	foreign key (aeropuertos_codigo_destino) references aeropuertos(codigo)
    );
    

create table vuelos_has_pasajeros(
	vuelos_codigo varchar(45) ,
    pasajeros_dni int,
    foreign key (vuelos_codigo) references vuelos(codigo),
    foreign key (pasajeros_dni) references pasajeros(dni),
    primary key (vuelos_codigo,pasajeros_dni)
    );


drop table vuelos_has_pasajeros;
drop table vuelos;
drop table aeropuertos;
drop table pilotos;

/* carga de datos*/

insert into marcas values
(1,"Cessna","Estados Unidos"),(2,"Beechcraft","Estados Unidos"),(3,"Fokker","Alemania");
select * from aviones;

insert into aviones values
("LV-ABC",1,"Citation","2010/12/12");
insert into aviones values
("LV-CDE",2,"Baron","2011/10/01"),
("LV-FGH",3,"F-27","2008/05/04"),
("LV-IJK",1,"Citation","2014/06/07"),
("LV-LMN",2,"King Air","2012/07/08");


insert into calle values 
(1,"Ituzaingo"),
(2,"Roca"),
(3,"Campichuelo"),
(4,"Meeks"),
(5,"Mamberti"),
(6,"Amenabar"),
(7,"Capello"),
(8,"Amenabar"),
(9,"Meeks"),
(10,"San Martìn"),
(11,"Azara"),
(12,"Sarmiento"),
(13,"Rivadavia"),
(14,"Martinto"),
(15,"Bolaños"),
(16,"Loria");
select *from calle;

insert into localidad values
(1,"Lanus"),
(2,"CABA"),
(3,"Avellaneda"),
(4,"Lomas de Zamora");

insert into provincia values(1,"Buenos Aires"),(2,"CABA");

insert into pasajeros values
(11111111,"Alejo","Barragan",true,1,123,1,1);

insert into pasajeros values
(22222222,"Andrès Alfredo","casas",true,2,4561,2,2),
(33333333,"Barbara","Chaves",false,3,6532,3,1),
(44444444,"Brisa","Casal",true,4,562,4,1),
(55555555,"camila","Fernandez",false,5,2356,1,1),
(66666666,"Carlos","Lopez",true,6,2345,2,2),
(77777777,"Carlos","Gonzalez",false,7,1589,4,1),
(88888888,"Christian","Dominguez",true,8,356,2,2),
(99999999,"Cristian","Rodriguez",true,9,1296,4,1),
(10111213,"Cristian","Rodriguez", true, 10, 3652,3,1);
select * from pasajeros;



insert into pilotos (nombre,apellido,dni,cuil,fecha_ingreso,calle_idcalle,numero,localidad_idlocalidad,provincia_idprovincia) values
("Juarez","Federico Bernardo",12345678,"20-12345678-8","1994/10/01",10,2235,2,2);

insert into pilotos 
(apellido,nombre,dni,cuil,fecha_ingreso,calle_idcalle,numero,localidad_idlocalidad,provincia_idprovincia) values
("Lacoste","Franco",		34567890,"20-34567890-1","2003/07/01",11,1254,4,1),
("Lopez","Mariana",			45678901,"27-45678901-1","2001/04/01",12,500,1,1),
("Lopez","Ignacio",	56789123,"20-56789123-3","2013/05/01",13,2351,2,2),
("Martinez","Giuliano",		67891234,"20-67891234-4","2010/07/01",14,663,1,1),
("Medina","Adriana",		78912345,"27-78912345-5","2015/08/01",15,1256,1,1),
("Martinez","Alberto",90123456,"20-90123456-6","2011/03/01",16,333,4,1);
select * from pilotos;

delete from pilotos where dni>1;

insert into aeropuertos values
("BUE","Aeroparque Jorge Newbery","CABA"),
("MDQ","Astor Piazolla","Mar Del Plata"),
("BRC","Teniente Luis Candelaria","San Carlos de Bariloche");
select * from aeropuertos;


select * from vuelos;
insert into vuelos values
("TT1234","LV-ABC","20-12345678-8","BUE","BRC","2018/05/01 20:00","2018/05/01 23:45",null);

insert into vuelos (codigo,aviones_marticula,cuil,aeropuertos_codigo_origen,aeropuertos_codigo_destino,fecha_hora_partida,fecha_hora_llegada) values
("TT3456","LV-CDE","27-78912345-5","BUE","MDQ","2018/05/02 10:00","2018/05/02 12:00");

insert into vuelos (codigo,aviones_marticula,cuil,aeropuertos_codigo_origen,aeropuertos_codigo_destino,fecha_hora_partida,fecha_hora_llegada) values
("TT1235","LV-ABC","20-12345678-8","BRC","BUE","2018/05/02 07:00","2018/05/02 10:50"),
("TT1256","LV-FGH","27-45678901-1","BUE","MDQ","2018/05/02 08:00","2018/05/02 10:05"),
("TT5632","LV-IJK","20-56789123-3","MDQ","BUE","2018/05/03 07:00","2018/05/03 09:15"),
("TT3333","LV-IJK","20-12345678-8","BUE","BRC","2018/05/03 07:00","2018/05/03 10:50"),
("TT1257","LV-FGH","27-45678901-1","BUE","MDQ","2018/05/04 08:00","2018/05/04 10:05"),
("TT3457","LV-CDE","27-78912345-5","MDQ","BUE","2018/05/04 10:00","2018/05/04 12:00"),
("TT5633","LV-IJK","20-56789123-3","BUE","MDQ","2018/05/05 07:00","2018/05/05 09:15");

INSERT INTO vuelos_has_pasajeros values
("TT1234",44444444),
("TT1234",55555555),
("TT1234",66666666);
insert into vuelos_has_pasajeros values
("TT3456",77777777),
("TT3456",88888888),
("TT3456",99999999);
insert into vuelos_has_pasajeros values
("TT1235",44444444),
("TT1235",55555555),

("TT1256",11111111),
("TT1256",22222222),
("TT1256",33333333),

("TT5632",77777777),
("TT5632",88888888),
("TT5632",99999999),

("TT3333",77777777),
("TT3333",88888888),
("TT3333",99999999),

("TT1257",22222222),

("TT3457",77777777),
("TT3457",88888888),
("TT3457",99999999),

("TT5633",77777777),
("TT5633",88888888),
("TT5633",99999999);




/*************************CONSULTAS*************************practica 2.3*/
-- Listado de pasajeros de la empresa (apellido, nombre, dni) 
select p.nombre, p.apellido, p.dni from pasajeros p;

-- Listado de pasajeros de la empresa (apellido, nombre, dni, domicilio) *  
select p.nombre,p.apellido,p.dni, c.nombre as calle, p.numero, l.nombre as localidad, pr.nombre as provincia from pasajeros p 
inner join calle c on p.calle_idcalle= c.codigo
inner join localidad l on p.localidad_idlocalidad= l.codigo
inner join provincia pr on p.provincia_idprovincia= pr.codigo;
 
-- Listado de pasajeros de la empresa (apellido, nombre, dni, domicilio) 
-- mostrando sólo a los que participan del programa de viajeros frecuentes, ordenados por apellido y nombre 

select p.apellido, p.nombre, p.dni, calle.nombre as calle, p.numero
from pasajeros p inner join calle on calle.codigo=p.calle_idcalle
where p.viajero_frecuente=true
order by apellido asc, nombre;

-- Listado de los aviones de la compañía, (marca, modelo, matrícula, fecha de entrada en servicio, país de origen) 
select m.nombre as marca, a.modelo, a.matricula, a.fecha_entrada_servicio, m.pais from aviones a
inner join marcas m on a.marcas_codigo=m.codigo order by m.nombre asc;

-- Listado de los aviones de la compañía, (marca, modelo, matrícula, fecha de entrada en servicio, país de origen)
-- cuyo paìs de origen sea “Alemania”  
 
select m.nombre as marca, a.modelo, a.matricula, a.fecha_entrada_servicio, m.pais from aviones a 
inner join marcas m on a.marcas_codigo=m.codigo
where m.pais="Alemania";

-- Listado de vuelos realizados mostrando código, marca, modelo y matrìcula del avión, Código IATA del Aeropuerto origen,
-- Código IATA del Aeropuerto destino, fecha hora partida, fecha hora llegada y CUIL piloto

select v.codigo as vuelo, m.nombre as marca, a.modelo, a.matricula, v.aeropuertos_codigo_origen ,v.aeropuertos_codigo_destino,
v.fecha_hora_partida, v.fecha_hora_llegada, v.cuil as cuil_piloto from vuelos v
inner join aviones a on v.aviones_marticula= a.matricula
inner join marcas m on a.marcas_codigo=m.codigo;

-- Listado de vuelos realizados mostrando código, marca, modelo y matrìcula del avión, 
-- Código IATA del Aeropuerto origen, Código IATA del Aeropuerto destino, fecha hora partida, fecha hora llegada 
-- y CUIL piloto que hayan partido del aeropuerto “BUE” ordenados por fecha hora de partida 
 
select v.codigo as vuelo, m.nombre as marca, a.modelo, v.aviones_marticula, 
v.aeropuertos_codigo_origen, v.aeropuertos_codigo_destino,v.fecha_hora_partida, v.fecha_hora_llegada, v.cuil
from vuelos v 
inner join aviones a on v.aviones_marticula=a.matricula
inner join marcas m on a.marcas_codigo = m.codigo
where v.aeropuertos_codigo_origen="BUE"
order by v.fecha_hora_partida asc;

-- Listado de vuelos realizados mostrando codigo, Código IATA del Aeropuerto origen, Código IATA del Aeropuerto destino, 
-- fecha hora partida y fecha hora llegada que hayan partido del aeropuerto “BUE” y  hayan arribado al aeropuerto “MDQ” 

select v.codigo as vuelo, v.aeropuertos_codigo_origen, v.aeropuertos_codigo_destino, v.fecha_hora_partida, v.fecha_hora_llegada
from vuelos v
where v.aeropuertos_codigo_origen="BUE" and
v.aeropuertos_codigo_destino="MDQ";

-- Listado de todos los vuelos realizados y sus pasajeros, (código, apellido, nombre, dni) 
select v.codigo as vuelo,  p.nombre, p.apellido, p.dni
from vuelos v 
inner join vuelos_has_pasajeros vp on v.codigo=vp.vuelos_codigo
inner join pasajeros p on vp.pasajeros_dni=p.dni;

-- Cantidad de vuelos realizados que hayan partido del aeropuerto “BUE” y  hayan arribado al aeropuerto “BRC” 
select count(*) from vuelos where aeropuertos_codigo_origen="BUE" and aeropuertos_codigo_destino="BRC";
select * from vuelos;

-- Cantidad de vuelos realizados que hayan partido del aeropuerto “MDQ” 
select count(*) from vuelos where aeropuertos_codigo_origen="MDQ";

-- Cantidad de vuelos realizados, por aeropuerto de origen (Código IATA, cantidad) 
select aeropuertos_codigo_origen, count(*) from vuelos group by aeropuertos_codigo_origen;

-- Cantidad de pasajeros transportados, por localidad del pasajero (localidad, cantidad) 
select l.nombre as localidad, count(p.dni) as Pasajeros from pasajeros p
inner join localidad l on p.localidad_idlocalidad=l.codigo
group by p.localidad_idlocalidad;


-- Cantidad de pasajeros transportados, por dìa (fecha, cantidad) 
select v.fecha_hora_partida, count(p.dni) as cant_pasajeros from vuelos v
inner join vuelos_has_pasajeros vp on v.codigo=vp.vuelos_codigo
inner join pasajeros p on vp.pasajeros_dni=p.dni
group by v.fecha_hora_partida;


-- Cantidad de vuelos por pasajero (apellido, nombre, dni, cantidad) 
select p.apellido, p.nombre, p.dni, count(v.codigo) as cant_vuelos from vuelos v 
inner join vuelos_has_pasajeros vhp on v.codigo=vhp.vuelos_codigo
inner join pasajeros p on p.dni=vhp.pasajeros_dni
group by p.dni;


-- Total de tiempo de vuelo por avión (el tiempo de vuelo se calcula como la diferencia entre
-- la fecha y hora de llegada y la de partida) en horas (matrìcula, horas).

-- no select v. codigo as vuelo, v.aviones_marticula, (v.fecha_hora_llegada-v.fecha_hora_partida) as distancia from vuelos v;
-- si
select  v.aviones_marticula,(v.fecha_hora_llegada-v.fecha_hora_partida) as distancia from vuelos v group by aviones_marticula;

select  v.aviones_marticula, timestampdiff(hour,v.fecha_hora_partida,v.fecha_hora_llegada),
timestampdiff(minute,v.fecha_hora_partida,v.fecha_hora_llegada) as distancia
from vuelos v group by aviones_marticula;


select  v.aviones_marticula,
timestampdiff(v.fecha_hora_partida,v.fecha_hora_llegada)

from vuelos v group by aviones_marticula;

select  v.aviones_marticula, timestampdiff(hour,v.fecha_hora_partida,v.fecha_hora_llegada) as horas, 
timestampdiff(minute,v.fecha_hora_partida,v.fecha_hora_llegada) /60 as minutos from vuelos v group by aviones_marticula;








-- Listado de pasajeros transportados con su tiempo de vuelo, que vivan en la calle Meeks, 
-- Lomas de Zamora, Buenos Aires, entre las alturas 0 y 1000. (Apellido, nombre,dni, total tiempo de vuelo) 
select p.apellido,p. nombre, p.dni, (v.fecha_hora_llegada-v.fecha_hora_partida) as tiempo_vuelo,
c.nombre as calle ,l.nombre as localidad, pr.nombre as provincia, p.numero
from pasajeros p 
inner join vuelos_has_pasajeros vp on p.dni=vp.pasajeros_dni
inner join vuelos v on vp.vuelos_codigo=v.codigo
inner join calle c on p.calle_idcalle=c.codigo
inner join localidad l on p.localidad_idlocalidad=l.codigo
inner join provincia pr on p.provincia_idprovincia= pr.codigo
where c.nombre="Meeks" and l.nombre="Lomas de Zamora" and pr.nombre="Buenos Aires" and 1000>p.numero>0
group by pasajeros_dni;
