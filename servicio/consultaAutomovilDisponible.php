<?php
include("../util/conexion.php");
$ini = "2018-11-24";
$fin = "2018-11-27";
$query = $db->prepare('call sp_consultaAutomovilDisponible(?,?)');
$query->bindParam(1,$ini);
$query->bindParam(2,$fin);
$query->execute();
$datos = array();
$cont = 0;
while($res = $query->fetch(PDO::FETCH_ASSOC)){
	//$fjson = json_encode($res);
	//echo $fjson;	
	$datos[$cont]['matricula'] = $res['matricula'];
	$datos[$cont]['modelo'] = $res['modelo'];
	$datos[$cont]['anno'] = $res['anno'];
	$datos[$cont]['precio'] = $res['precio'];
$cont++;
}
//$njson = str_replace("}}","},",$fjson);
$fjson = json_encode($datos);
echo '{"autosdisponibles":'.$fjson."}";
?>