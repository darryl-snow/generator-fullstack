'use strict'

angular.module('iproferoApp')
	.controller 'NavbarCtrl', ['$scope', '$http', 'Auth', '$location', ($scope, $http, Auth, $location) ->

		$scope.logout = ->
			Auth.logout (err) ->
				if (!err)
					$location.path '/login'

	]