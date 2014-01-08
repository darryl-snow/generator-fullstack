'use strict'

angular.module('iproferoApp')
	.controller 'NewAgencyCtrl', ['$scope', '$http', 'Agency', '$location', 'User', ($scope, $http, Agency, $location, User) ->

		if $scope.currentUser.agency? and $scope.currentUser.agency isnt ""
			$location.path "/"

		$scope.error = {}
		$scope.agency = {}
		User.get
			userId: $scope.currentUser._id
		, (user) ->
			$scope.user = user

		$scope.createAgency = (form) ->
			if $scope.newagency? and $scope.newagency.name? and $scope.newagency.name isnt ""
				agency = new Agency
					name: $scope.newagency.name
					admins: [$scope.currentUser._id]
					people: [$scope.currentUser._id]
					paymentdate: new Date()

				agency.$save (response) ->
					
					$scope.errors = {}

					unless response.errors?
						$scope.user.agency = response._id
						$scope.user.$update ->
							$location.path "/agency/" + response._id
					else
						angular.forEach response.errors, (error, field) ->
							form[field].$setValidity "mongoose", false
							$scope.errors[field] = error.type

						$scope.error.other = response.message

	]