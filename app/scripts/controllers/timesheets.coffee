'use strict'

angular.module('iproferoApp')
	.controller 'TimesheetsCtrl', ['$scope', '$http', 'UserTimesheet', 'Timesheet', 'Project', 'Activity', '$notification', ($scope, $http, UserTimesheet, Timesheet, Project, Activity, $notification) ->		

		$scope.timesheets = []
		$scope.timesheetdays = []

		Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

		$scope.find = (query) ->
			UserTimesheet.query
				userId: $scope.currentUser._id
			, (timesheets) ->

				for timesheet in timesheets

					normaliseddate = new Date(timesheet.date)
					normaliseddate.setHours(0)
					normaliseddate.setMinutes(0)
					normaliseddate.setSeconds(0)
					normaliseddate = normaliseddate.toString()

					if normaliseddate not in $scope.timesheetdays

						$scope.timesheetdays.push normaliseddate
						$scope.timesheets.push
							date: normaliseddate
							timesheets: []

					$scope.insertTimesheet(timesheet, normaliseddate)

		$scope.insertTimesheet = (ts, date) ->

			for timesheet in $scope.timesheets
				if timesheet.date is date
					if $scope.currentUser.agency? and $scope.currentUser.agency != ""
						timesheet.timesheets.push
							id: ts._id
							date: date
							duration: ts.duration
							project: $scope.getProjectName(ts.project)
							activity: $scope.getActivityName(ts.activity)
							comment: ts.comment
					else
						timesheet.timesheets.push
							id: ts._id
							date: date
							duration: ts.duration
							project: $scope.getProjectName(ts.project)
							comment: ts.comment

		$scope.getProjectName = (id) ->
			Project.get
				projectId: id
			, (project) ->
				if project
					project.name
				else
					"[unknown]"

		$scope.getActivityName = (id) ->
			Activity.get
				agencyId: $scope.currentUser.agency
				activityId: id
			, (activity) ->
				if activity
					activity.name
				else
					"[unknown]"

		$scope.swipeLeft = (sheet) ->
			sheet.swiped = true

		$scope.swipeRight = (sheet) ->
			sheet.swiped = false

		$scope.toggleSwipe = (sheet) ->
			sheet.swiped = !sheet.swiped

		$scope.cancelEdit = ->
			for timesheet in $scope.timesheets
				for sheet in timesheet.timesheets
					sheet.swiped = false

		$scope.deletetimesheet = (sheet) ->
			tmp = 
				date: sheet.date
				duration: sheet.duration
				project: sheet.project
				activity: sheet.activity
				comment: sheet.comment

			Timesheet.get
				timesheetId: sheet.id
			, (timesheet) ->

				timesheet.$remove (response) ->

					$notification.warning("success", "Removed " + tmp.project.name + " timesheet")

					for ts in $scope.timesheets
						for s in ts.timesheets
							if s is sheet
								if ts.timesheets.length is 1
									$scope.timesheets.remove(ts)
									break
								else
									ts.timesheets.remove(s)
									break

	]