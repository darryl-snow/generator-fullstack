'use strict'

angular.module('iproferoApp')
	.controller 'AgencyCtrl', ['$scope', '$http', 'User', 'Agency', '$routeParams', '$notification', 'ngDialog', '$location', 'Auth', ($scope, $http, User, Agency, $routeParams, $notification, ngDialog, $location, Auth) ->

		$scope.getpeople = ->
			$scope.people =
				name: "people"
				valueKey: "email"
				prefetch: "/api/1/users/all"

			console.log $scope.people

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
				if $scope.currentUser._id not in $scope.agency.admins
					$location.path "/" 

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
				$scope.agency.people = $scope.agency.people.filter (p) -> p != person._id
				person.agency = ""
				console.log person
				$scope.agency.$update (response) ->
					person.$update (response) ->
						$notification.warning("undo?", "Removed " + person.email)
						$scope.getpeople()
			$scope.cancelSwipe()

		$scope.confirmdelete = ->
			ngDialog.open
				template: 'partials/modal.html'
				showClose: false
				scope: $scope

		$scope.closedialog = ->
			ngDialog.closeAll()

		$scope.testforconfirmation = ->
			if $scope.agencyname? and $scope.agency.name?
				$scope.agencyname.toLowerCase() is $scope.agency.name.toLowerCase()

		$scope.removeagency = ->

			agency = $scope.agency
			tmp =
				name: agency.name

			if $scope.testforconfirmation()

				console.log "removing " + $scope.agency.name

				agency.$remove (response) ->
					if response.$resolved
						if !response.errors?
							$scope.closedialog()
							$notification.warning("undo?", "Removed " + tmp.name)
							me = Auth.currentUser()
							me.agency = ""
							me.$update (response) ->
							for person in $scope.agencypeople
								person.agency = ""
								person.$update (response) ->
							setTimeout ->
								$location.path "/"
							, 1500

						else
							console.log response.errors.name.message
							$notification.error("failed", response.errors.name.message)

	]