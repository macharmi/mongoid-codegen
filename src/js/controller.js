	if ($location.path().indexOf('/((entity))/edit') > -1){
		id = $routeParams.id;
		AppService.get('/((entity))/get/' + id)		
		.then(
			function(res){
				$scope.((entity)) = res;
			},
			function(err){
				
			}
		)
		$
		$scope.action = function(((entity))){
			$scope.((Entity))Edit(((entity)))
		}
	}
	else if($location.path().indexOf('/((entity))/new') > -1){
		$scope.action = function(((entity))){
			$scope.((Entity))Add(((entity)))
		}
	}
	else if($location.path().indexOf('/((entity))/delete') > -1){
		id = $routeParams.id;
		AppService.get('/((entity))/delete/' + id)		
		.then(
			function(res){
				$scope.message = "((Entity)) " + id + " successfully deleted ";
				AppService.get('/((entity))/index')		
				.then(
					function(res){
						$scope.((entity))s = res;
					},
					function(err){
						
					}
				)
			},
			function(err){
				$scope.message = err;
				AppService.get('/((entity))/index')		
				.then(
					function(res){
						$scope.((entity))s = res;
					},
					function(err){
						
					}
				)
			}
		)

	}
	else if($location.path().indexOf('/((entity))/get') > -1){
		id = $routeParams.id;
		AppService.get('/((entity))/get/' + id)		
		.then(
			function(res){
				$scope.Current((Entity)) = res;
			},
			function(err){
				
			}
		)
	}
	else {
		AppService.get('/((entity))/index')		
		.then(
			function(res){
				$scope.((entity))s = res;
			},
			function(err){
				
			}
		)
	}