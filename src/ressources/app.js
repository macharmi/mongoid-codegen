var myApp = angular.module('myApp', ['ngRoute']);

myApp.service('AppService',function service($http,$q,$rootScope){
	var service = this;
	
	// generic function for post calls using promise
	service.post = function(url, postdata){
		var defer = $q.defer();
		$http({
		       withCredentials: false,
		       method: 'post',
		       url: url,
		       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
		       data: postdata
		 })
		.success(function(res){
			service.message = res;
			defer.resolve(res);
		})
		.error(function(err, status){
			defer.reject(err);
		})
		return defer.promise;		
	}

	// generic function for get calls using promise
	service.get = function(url){
		var defer = $q.defer();
		$http.get(url)
		.success(function(res){
			service.message = res;
			defer.resolve(res);
		})
		.error(function(err, status){
			defer.reject(err);
		})
		return defer.promise;
	}
});

// sidebar controller
myApp.controller('SideBarController', function($scope, $routeParams, $location, $window, AppService)
{
	$window.document.title = "SideBarController"
	$scope.page = $location.path();
	if ($location.path().indexOf('/user/update') > -1){
		$scope.text = 'Update';
	}
	else if($location.path().indexOf('/user/create') > -1){
		$scope.text = 'Create';
	}
	else if($location.path().indexOf('/user/get') > -1){
		id = $routeParams.id;
		$scope.text = 'Get';
	}
});

/* <<include_entities_controllers>> */




// define application routes
myApp.config(['$routeProvider',
	function($routeProvider) {
		$routeProvider
			/* <<include_routes>> */
			otherwise({
				templateUrl: '404.htm',
				controller:  'AppController'		
		});
	}
]);