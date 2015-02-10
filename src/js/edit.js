    $scope.((Entity))Edit = function(((entity))){
		AppService.post('/((entity))/edit', $.param(((entity))))
		.then(
			function(res){
				$location.path('/((entity))/get/' + ((entity)).id.$oid);
			},
			function(err){
				alert(err);
			}
		)
	}
