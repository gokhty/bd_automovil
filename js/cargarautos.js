automovil.controller('cargar', function($scope, $http) {

	$scope.listaOtroUsuario = function() {
		$http({
		method: 'POST',
		url: 'servicio/consultaAutomovilDisponible.php'
		}).then(function(response) {
		$scope.autos = response.data.autosdisponibles;
		});
	}
});