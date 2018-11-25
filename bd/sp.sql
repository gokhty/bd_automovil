-- call procedure sp_consultaAutomovilDisponible;
delimiter |
create procedure sp_consultaAutomovilDisponible(ini date, fin date)
begin
select * from automovil where matricula not in(select idAuto from reserva r where 
ini between fechaIni and fechaFin
or
fin between fechaIni and fechaFin
or 
fechaIni >= ini and fechaFin <=fin
and
r.estado = '1');
end
|
-- select * from reserva where fechaIni >= '2018-04-30' and fechaFin <= '2018-09-03'

-- select * from reserva

-- call sp_consultaAutomovilDisponible ('2018-01-02', '2018-01-09');

-- call sp_consultaAutomovilDisponible ('2018-11-24', '2018-11-27');

delimiter |
create procedure sp_recepcionReserva(cli char(9),idR int)
-- lista las reservas ya iniciadas, estado 1
-- quiere decir que le auto ya fue entregado al cliente
begin
select rr.*, r.fechaIni, r.fechaFin from recepcionReserva rr
join reserva r
on rr.idReserva = r.id
where rr.estado = 0 and (r.idCliente = cli or rr.idReserva = idR) order by fechaIni desc;
end
|
-- call sp_recepcionReserva ('G71962605' ,'1');


select * from recepcionReserva;

-- call procedure sp_registraReservaAutomovil;
delimiter |
create procedure sp_registraReservaAutomovil(cli char(9), movil char(7),ini date,fin date)
-- solo inserta los valores si antes consulto "sp_consultaAutomovilDisponible"
-- solo se elije los valores que se obtuvo a travez de "sp_consultaAutomovilDisponible"
begin
-- 0 disponible
-- 1 reservado
if not exists(select * from reserva where idAuto = movil) then
	insert into reserva values(null, cli, movil, ini, fin,'1');
end if;
end
|
-- call sp_consultaAutomovilDisponible ('2018-11-24', '2018-11-27');

-- call sp_registraReservaAutomovil ('G71962605','CC1-2AA','2018-11-24','2018-11-27');

select * from reserva;

delimiter |
create procedure sp_consultaReserva(cli char(9))
begin
select * from reserva where
id not in (select id from recepcionReserva)
and
idCliente = cli order by fechaIni desc;
end
|

-- call sp_consultaReserva('G71962605');

delimiter |
create procedure sp_cancelarReserva(id int)
-- ejecutar sp_consultaReserva para ver que reserva cancelar
begin
update reserva set estado = '0' where id =  id;
end
|
-- call sp_cancelarReserva (1);
delimiter |
create procedure sp_volverAbrirReserva(id int)
-- ejecutar sp_consultaReserva para ver que reserva cancelar
begin
update reserva set estado = '1' where id =  id;
end
|
-- call sp_volverAbrirReserva (1);

-- call procedure sp_checkInAuto;
delimiter |
create procedure sp_checkInAuto(idR int,idRep char(8))
-- consulta reserva por cliente
-- procedimiento -- call sp_consultaReserva('G71962605')
begin
-- estado
-- 0 activo
-- 1 finalizado
insert into recepcionReserva values (null,idR, idRep, 0);
end
|
-- -- call sp_consultaReserva('G71962605')
-- 5 G71962605	CC1-2AA	2018-06-10	2018-06-12	1
-- se obtine el dni de la recepcionista -- select * from recepcionista

-- select * from  recepcionReserva
-- call sp_checkInAuto( 1,'12345678');
delimiter |
create procedure sp_checkOutAuto(idR int,idRep char(8))
-- consulta reserva por cliente
-- procedimiento -- call sp_recepcionReserva 'G71962605' ,1
begin
-- estado
-- 0 activo
-- 1 finalizado
update recepcionReserva set estado = 1 where idReserva = idR;
end
|
-- call sp_checkOutAuto( 2,'12345678')