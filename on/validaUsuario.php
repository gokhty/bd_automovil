<?php
include("../util/conexion.php");

$pd = file_get_contents("php://input");
$rq = json_decode($pd);
$usu = $rq->usu;
$pass = $rq->pass;

$query3 = $db->prepare('select count(*) as val from cliente where licencia = ? and pass = ?');
$query3->bindParam(1,$usu);
$query3->bindParam(2,$pass);
$query3->execute();
$res = $query3->fetch(PDO::FETCH_ASSOC);
echo  '{"vavava":[{"val":'.$res['val'][0].'}]}';
?>