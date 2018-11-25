automovil.controller('cargar', function($scope, $http) {

	$scope.listaOtroUsuario = function() {
	
		$http({
		method: 'POST',
		url: 'servicio/consultaAutomovilDisponible.php',
		data: { ini: $scope.ini, fin: $scope.fin }
		}).then(function(response) {
		$scope.autos = response.data.autosdisponibles;
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
	$scope.seleccionar = function() {
		document.querySelector(".modal").style.display="block";
	}
	$scope.reservar = function() {
		//var matric = document.querySelector("#matri").value;
		alert($scope.usu+" | "+$scope.matric+" | "+$scope.ini+" | "+$scope.fin);
		$http({
		method: 'POST',
		url: 'on/reservar.php',
		data: {usu: $scope.usu, matric: $scope.matric, ini:$scope.ini, fin: $scope.fin}
		}).then(function(response) {
		$scope.mensaje = response.data.vavava;
		});
	}
});