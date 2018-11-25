<?php
include("../util/conexion.php");

$pd = file_get_contents("php://input");
$rq = json_decode($pd);
$usu = $rq->usu;
$matric = $rq->matric;
$ini = $rq->ini;
$fin = $rq->fin;

$query3 = $db->prepare('call sp_registraReservaAutomovil(?,?,?,?)');
$query3->bindParam(1,$usu);
$query3->bindParam(2,$matric);
$query3->bindParam(1,$ini);
$query3->bindParam(2,$fin);
$query3->execute();
$res = $query3->fetch(PDO::FETCH_ASSOC);
echo  '{"vavava":[{"val":"se reservף","usu":"$usu","matricula":"$matric","ini":"$ini","fin":"$fin"}]}';
?>