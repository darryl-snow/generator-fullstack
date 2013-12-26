'use strict'

angular.module('iproferoApp')
	.controller 'ProfileCtrl', ['$scope', '$rootScope', 'User', '$http', ($scope, $rootScope, User, $http) ->

		$scope.user = $rootScope.currentUser

	]