	$scope.((Entity))Add = function(((entity))){
		AppService.post('/((entity))/new', $.param(((entity))))
		.then(
			function(res){
				$location.path('/((entity))/get/' + res.id.$oid);
			},
			function(err){
				$scope.message = err
			}
		)
	}
