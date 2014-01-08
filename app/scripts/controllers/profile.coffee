'use strict'

angular.module('iproferoApp')
	.controller 'ProfileCtrl', ['$scope', '$rootScope', 'User', '$http', 'Agency', '$notification', ($scope, $rootScope, User, $http, Agency, $notification) ->

		$scope.name = ""

		$scope.find = ->
			User.get
				userId: $rootScope.currentUser._id
			, (user) ->
				$scope.user = user
				$scope.name = user.name

			if $rootScope.currentUser.agency?
				Agency.get
					agencyId: $scope.user.agency
				, (agency) ->
					$scope.agency = agency

		$scope.update = ->
			$scope.user.name = $scope.name

			$scope.user.$update (response) ->
				if !response.errors?
					$notification.success("success", "Saved")
				else
					console.log response.errors.name.message
					$notification.error("failed", response.errors.name.message)

		$scope.savename = ->
			if $scope.name?
				$scope.user.name = $scope.name
	]