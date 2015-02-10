	if ($location.path().indexOf('//edit') > -1){
		id = $routeParams.id;
		AppService.get('//get/' + id)		
		.then(
			function(res){
				$scope. = res;
			},
			function(err){
				
			}
		)
		$
		$scope.action = function(){
			$scope.((Entity))Edit()
		}
	}
	else if($location.path().indexOf('//new') > -1){
		$scope.action = function(){
			$scope.((Entity))Add()
		}
	}
	else if($location.path().indexOf('//delete') > -1){
		id = $routeParams.id;
		AppService.get('//delete/' + id)		
		.then(
			function(res){
				$scope.message = "((Entity)) " + id + " successfully deleted ";
				AppService.get('//index')		
				.then(
					function(res){
						$scope.s = res;
					},
					function(err){
						
					}
				)
			},
			function(err){
				$scope.message = err;
				AppService.get('//index')		
				.then(
					function(res){
						$scope.s = res;
					},
					function(err){
						
					}
				)
			}
		)

	}
	else if($location.path().indexOf('//get') > -1){
		id = $routeParams.id;
		AppService.get('//get/' + id)		
		.then(
			function(res){
				$scope.Current((Entity)) = res;
			},
			function(err){
				
			}
		)
	}
	else {
		AppService.get('//index')		
		.then(
			function(res){
				$scope.s = res;
			},
			function(err){
				
			}
		)
	}