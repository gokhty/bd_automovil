<?php
include("../util/conexion.php");

$lic = $_POST["lic"];
$pass = $_POST["pass"];
$msj;

try{
	$query = $db->prepare('select count(*) as val from cliente where licencia = ?');
	$query->bindParam(1,$lic);
	$query->execute();
	$res = $query->fetch(PDO::FETCH_ASSOC);
	$num = $res['val'][0];
	if(num == 1){
		$query3 = $db->prepare('insert into cliente(licencia, pass)values(?,?)');
		$query3->bindParam(1,$lic);
		$query3->bindParam(2,$pass);
		$query3->execute();
		$msj = "Registro_completado";		
	}else{
		$msj = "Error";
	}
}catch(Exception $e){
	$msj = "Error";
}finally{
	header('Location:../index.html?msj='.$msj);
}
?>