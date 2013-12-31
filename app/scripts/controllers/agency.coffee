'use strict'

angular.module('iproferoApp')
	.controller 'AgencyCtrl', ['$scope', '$http', 'User', 'Agency', '$routeParams', '$notification', ($scope, $http, User, Agency, $routeParams, $notification) ->

		$scope.getpeople = ->
			$scope.people =
				name: "people"
				valueKey: "email"
				prefetch: "/api/1/users/all"

			User.query "", (people) ->
				$scope.agencypeople = people

		$scope.swipeLeft = (person) ->
			person.swiped = true

		$scope.swipeRight = (person) ->
			person.swiped = false

		$scope.toggleSwipe = (person) ->
			person.swiped = !person.swiped

		$scope.cancelSwipe = ->
			for person in $scope.agencypeople
				person.swiped = false

		$scope.get = ->
			Agency.get
				agencyId: $routeParams.id
			, (agency) ->
				$scope.agency = agency
			$scope.getpeople()

		$scope.addperson = ->
			newperson = $scope.agencypeople.filter (p) -> p._id is $scope.newperson._id
			newperson = newperson[0]
			newperson.agency = $scope.agency._id
			newperson.$update (response) ->
				$scope.agency.$update (response) ->
					$notification.success("success", "Added " + newperson.email)
			$scope.agency.people.push newperson._id
			

		$scope.removeperson = (person) ->
			# if user is agency admin, can't be removed
			if person._id not in $scope.agency.admins
				agencypeople = $scope.agency.people.filter (p) -> p != person._id
				person.agency = ""
				$scope.agency.$update (response) ->
					person.$update (response) ->
						$notification.warning("undo?", "Removed " + person.email)
					$scope.getpeople()
			$scope.cancelSwipe()

	]