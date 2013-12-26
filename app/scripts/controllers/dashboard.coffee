'use strict'

angular.module('iproferoApp')
	.controller 'DashboardCtrl', ['$scope', '$http', ($scope, $http) ->
	]
		
		# # List of users got from the server
		# $scope.users = []

		# # Fill the array to display it in the page
		# $http.get("/users").success (users) ->
		# 	for i of users
		# 		$scope.users.push users[i]