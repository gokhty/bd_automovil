automovil.controller('cargar', function($scope, $http) {

	$scope.listaOtroUsuario = function() {
	
		$http({
		method: 'POST',
		url: 'servicio/consultaAutomovilDisponible.php',
		data: { ini: $scope.ini, fin: $scope.fin }
		}).then(function(response) {
		$scope.autos = response.data.autosdisponibles;
		if($scope.autos == null){
			alert("No hay autos");
		}
		if($scope.autos == ""){
			alert("No hay autos");
		}
		});
	}
	$scope.validaUsu = function() {
	//alert($scope.usu+" "+$scope.pass);
		$http({
		method: 'POST',
		url: 'on/validaUsuario.php',
		data: {usu: $scope.usu, pass: $scope.pass}
		}).then(function(response) {
		$scope.vvv = response.data.vavava;
		});
	}
	var g_matricula;
	$scope.seleccionar = function(x) {
		g_matricula = x;
		document.querySelector(".modal").style.display="block";
	}
	$scope.reservar = function() {
		var x = document.getElementById("ini").value;
		var u = document.getElementById("fin").value;
		//var matric = document.querySelector("#matri").value;
		$http({
		method: 'POST',
		url: 'on/reservar.php',
		data: {usu: $scope.usu, matric: g_matricula, ini:$scope.ini, fin: $scope.fin}
		}).then(function(response) {
		$scope.mensaje = response.data.vavava;
		alert("Datos de reserva"+"\n Licencia: "+$scope.usu+"\n Auto: "+g_matricula+"\n Fecha inicio: "+x+"\n Fecha fin: "+u);
		location.reload();
		});
	}
	$scope.cerrarModal = function() {
		document.querySelector(".modal").style.display="none";
	}
});