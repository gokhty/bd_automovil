-- drop database autoExpres1
-- ;
create database autoExpres1
;
use autoExpres1
;
create table cliente(
licencia char(9) primary key,
nombre varchar(45),
email varchar(45),
telefono varchar(45),
pass varchar(45)
)
;
create table automovil(
matricula char(7) primary key,
modelo varchar(45),
anno int,
precio double
)
;
create table reserva(
id int primary key auto_increment,
idCliente char(9) references cliente,
idAuto char(7) references automovil,
fechaIni date,
fechaFin date,
estado char(1)
)
;
create table recepcionista(
dni char(8) primary key,
nombre varchar(45),
pass varchar(45)
)
;
create table recepcionReserva(
id int primary key auto_increment,
idReserva int,
idRecepcionista char(8),
estado char(1),
foreign key(idReserva) references reserva(id),
foreign key(idRecepcionista) references recepcionista(dni)
)
;

insert into automovil values
('ABC-931','sony 3','2017',300),
('ABC-A32','pun racer','2007',400),
('CC1-2AA','orion 45','2001',100)
;

insert into cliente  (licencia,pass)values('G71962605','1234')
;
insert into recepcionista values
('12345678','luisa','Lu3Qr11'),
('12345671','Ana','Au3Qr11'),
('12345672','Maria','Mu3Qr11')
;

/*
insert into reserva values
(null,'G71962605','ABC-931','2018-05-30','2018-09-02','1'),
(null,'G71962605','ABC-931','2017-01-01','2017-02-02','1')
;

insert into recepcionReserva values
(null, 1,'12345678',1)
;
select * from reserva;
select * from recepcionReserva

*/