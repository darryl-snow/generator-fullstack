'use strict'

angular.module('iproferoApp')
	.controller 'ActivitiesCtrl', ['$scope', '$http', 'Activity', '$notification', ($scope, $http, Activity, $notification) ->

		$scope.predicate = "name"

		$scope.getAll = ->
			Activity.query
				agencyId: $scope.currentUser.agency
			, (activities) ->
				$scope.activities = activities

		$scope.cancelEdit = ->
			for activity in $scope.activities
				activity.editing = false

		$scope.update = (activity) ->
			activity.editing = false
			if $scope.validate(activity)
				activity.$update (response) ->
					if response.errors?
						console.log response.errors.name.message

		$scope.create = ->

			if $scope.newactivity? and $scope.newactivity.name isnt ""

				if !$scope.newactivity.hourlyrate? or $scope.newactivity.hourlyrate is "" then $scope.newactivity.hourlyrate = 0
				if !$scope.newactivity.dailyrate? or $scope.newactivity.dailyrate is "" then $scope.newactivity.dailyrate = 0

				activity = new Activity
					name: $scope.newactivity.name
					hourlyrate: $scope.newactivity.hourlyrate
					dailyrate: $scope.newactivity.dailyrate
					agency: $scope.currentUser.agency

				activity.$save (response) ->
					if !response.errors?
						$scope.activities.push response
						$scope.clearActivity()
						$notification.success("success", "Created " + activity.name)
					else
						console.log response.errors.name.message
						$notification.error("failed", "Created " + response.errors.name.message)

		$scope.clearActivity = ->
			$scope.newactivity =
				name: ""
				hourlyrate: 0
				dailyrate: 0

		$scope.validate = (activity) ->

			if !activity.name? or activity.name is ""
				$scope.delete(activity)
				return false
			else if activity.name.match(/[^a-zA-Z0-9,.!'"\s]/g)
				activity.name = activity.name.replace(/[^a-zA-Z0-9,.!'"\s]/g, "")

			if !activity.hourlyrate? or activity.hourlyrate is ""
				acvitity.hourlyrate = 0
			else if(activity.hourlyrate.toString().match(/[^0-9,.]+/g))
				activity.hourlyrate = Number(activity.hourlyrate.toString().replace(/[^0-9,.]+/g, ""))

			if !activity.dailyrate? or activity.dailyrate is ""
				activity.dailyrate = 0
			else if(activity.dailyrate.toString().match(/[^0-9,.]+/g))
				activity.dailyrate = Number(activity.dailyrate.toString().replace(/[^0-9,.]+/g, ""))

			activity

		$scope.delete = (activity) ->
			console.log activity
			tmp =
				name: activity.name
				id: activity.id
			activity.$remove (response) ->
				if response.$resolved
					$notification.warning("undo?", "Removed " + tmp.name)
					if $scope.activities?
						$scope.activities =
							$scope.activities.filter (act) -> act._id != tmp.id


	]