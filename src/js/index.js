	$scope.Get = function(((entity))){
		AppService.get('/((entity))/index')
		.then(
			function(res){
				return res;
			},
			function(err){
				return(err);
			}
		)
    }
