'use strict'

angular.module('iproferoApp')
	.controller 'TimetrackerCtrl', ['$scope', '$http', 'localStorageService', 'Project', 'Activity', 'Timesheet', '$rootScope', '$notification', '$routeParams', '$location', ($scope, $http, localStorageService, Project, Activity, Timesheet, $rootScope, $notification, $routeParams, $location) ->

		$scope.timesheets = [];
		$scope.user = $rootScope.currentUser
		$scope.loading = false

		if $routeParams.id?
			$scope.editing = $routeParams.id

		# Setup date picker options
		$scope.dateformat = "DD/MM/YYYY"

		$scope.dateranges =
			'Today': [moment(), moment()]
			'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)]
			'Past 5 Days': [moment().subtract('days', 4), moment()]
			'Last Week': [moment().subtract(1, 'week').subtract('days',moment().subtract(1, 'week').day()-1), moment().subtract(1, 'week').subtract('days',moment().subtract(1, 'week').day()-1).add('days', 4)]

		# if today is tuesday then "today" and "yesterday" are fine
		# if today is weds-friday, then also need to add previous
		# days of the week days to the date range menu
		daystoadd = moment().isoWeekday() - 2
		switch daystoadd
			when 1
				$scope.dateranges["Monday"] = [moment().subtract('days', 2),moment().subtract('days', 2)]
			when 2
				$scope.dateranges["Monday"] = [moment().subtract('days', 3),moment().subtract('days', 3)]
				$scope.dateranges["Tuesday"] = [moment().subtract('days', 2),moment().subtract('days', 2)]
			when 3
				$scope.dateranges["Monday"] = [moment().subtract('days', 4),moment().subtract('days', 4)]
				$scope.dateranges["Tuesday"] = [moment().subtract('days', 3),moment().subtract('days', 3)]
				$scope.dateranges["Wednesday"] = [moment().subtract('days', 2),moment().subtract('days', 2)]
			when 4
				$scope.dateranges["Monday"] = [moment().subtract('days', 5),moment().subtract('days', 5)]
				$scope.dateranges["Tuesday"] = [moment().subtract('days', 4),moment().subtract('days', 4)]
				$scope.dateranges["Wednesday"] = [moment().subtract('days', 3),moment().subtract('days', 3)]
				$scope.dateranges["Thursday"] = [moment().subtract('days', 2),moment().subtract('days', 2)]
			when 5
				$scope.dateranges["Monday"] = [moment().subtract('days', 6),moment().subtract('days', 6)]
				$scope.dateranges["Tuesday"] = [moment().subtract('days', 5),moment().subtract('days', 5)]
				$scope.dateranges["Wednesday"] = [moment().subtract('days', 4),moment().subtract('days', 4)]
				$scope.dateranges["Thursday"] = [moment().subtract('days', 3),moment().subtract('days', 3)]
				$scope.dateranges["Friday"] = [moment().subtract('days', 2),moment().subtract('days', 2)]

		# Get list of user/agency projects to populate
		# projects list
		Project.query "", (projects) ->
			$scope.projects = projects

		if $scope.currentUser.agency? and $scope.currentUser.agency isnt ""
			# Get list of agency activities to populate
			# activities list
			Activity.query
				agencyId: $scope.currentUser.agency
			, (activities) ->
				$scope.activities = activities

		# Setup new timesheet, getting data from LS if it's there
		# or otherwise using default values
		$scope.date = "Today"
		if $scope.editing?

			Timesheet.get
				timesheetId: $scope.editing
			, (timesheet) ->

				$scope.editing = timesheet

				$scope.newtimesheet =
					time: timesheet.duration.toString()
					date:
						from: moment(timesheet.date)
						to: moment(timesheet.date)
					project: timesheet.project
					activity: timesheet.activity
					comment: timesheet.comment

				$scope.changedate($scope.newtimesheet.date.from, $scope.newtimesheet.date.to)
				$scope.validate()

		else if localStorageService.get('timesheet')

			$scope.newtimesheet =
				time: localStorageService.get('timesheet').time
				date:
					from: moment()
					to: moment()
				project: localStorageService.get('timesheet').project
				activity: localStorageService.get('timesheet').activity

			if localStorageService.get('timesheet').datePreference?
				$scope.date = localStorageService.get('timesheet').datePreference

				if $scope.date is "Yesterday"
					$scope.newtimesheet.date =
						from: moment().subtract(1, 'Days')
						to: moment().subtract(1, 'Days')

		else

			$scope.newtimesheet =
				time: 8
				date:
					from: moment()
					to: moment()
				project: ""

		# validate input
		$scope.validate = ->
			if $scope.newtimesheet?
				$scope.checkTime() and $scope.checkDate() and $scope.checkProject()

		$scope.checkTime = ->
			$scope.newtimesheet.time isnt 'undefined' and $scope.getHours() > 0

		$scope.checkDate = ->
			$scope.validDate

		$scope.getHours = ->
			if $scope.newtimesheet.time? and $scope.newtimesheet.time != ""
				time = $scope.newtimesheet.time.toString()
				time = time.split(" ")
				if time.length > 1
					hours = time[0].replace("hrs", "")
					minutes = time[1].replace("mins", "") / 60
					time = Number(hours) + Number(minutes)
				else
					time = Number(time[0].replace("hrs", ""))
				time

		$scope.okDates = [
			"Today", "Yesterday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
		]
		$scope.validDate = true
		# watch for when user manually types a date
		$scope.$watch 'date', ->

			if $scope.date.indexOf(" - ") is -1

				# not a range, single date

				if moment($scope.date).isValid()
					start = end = moment($scope.date)
					$scope.newtimesheet.date =
						from: start
						to: end
					$scope.validDate = true
				else if($scope.date in $scope.okDates)
					$scope.validDate = true
				else
					$scope.validDate = false

			else

				# date range

				split = $scope.date.split(" - ")
				start = undefined
				end = undefined
				if split.length is 2 and moment(split[0], $scope.dateformat).isValid() and moment(split[1], $scope.dateformat).isValid()
					start = moment(split[0], $scope.dateformat)
					end = moment(split[1], $scope.dateformat)
					$scope.newtimesheet.date =
						from: start
						to: end
					$scope.validDate = true
				else
					$scope.validDate = false

		$scope.checkProject = ->
			$scope.newtimesheet.project isnt 'undefined' and $scope.newtimesheet.project isnt ""

		$scope.changedate  = (from, to) ->

			if from.isValid() and to.isValid()

				if from.isSame(to)

					# single day selected

					switch moment().diff(from, 'days')
						when 0
							$scope.date = "Today"
							$scope.newtimesheet.datePreference = "Today"
						when 1
							$scope.date = "Yesterday"
							$scope.newtimesheet.datePreference = "Yesterday"
						else
							# if it's this week, show day name
							if moment().diff(from, 'weeks') is 0 and from.weekday() < moment().weekday()
								switch from.weekday()
									when 0 then $scope.date = "Sunday"
									when 1 then $scope.date = "Monday"
									when 2 then $scope.date = "Tuesday"
									when 3 then $scope.date = "Wednesday"
									when 4 then $scope.date = "Thursday"
									when 5 then $scope.date = "Friday"
							else
								$scope.date = from.format($scope.dateformat)
				else
					$scope.date = from.format($scope.dateformat) + " - " + to.format($scope.dateformat)

				$scope.newtimesheet.date =
					from: from
					to: to

				if !$scope.$$phase
					$scope.$apply()

		$scope.$watch "newtimesheet.time + newtimesheet.date.from + newtimesheet.project", ->
			$scope.valid = $scope.validate()

		$scope.logtime = ->

			if $scope.validate()

				$scope.loading = true

				if $scope.editing?
					
					$scope.editing.date = moment($scope.newtimesheet.date.from, $scope.dateformat).local().toISOString()
					$scope.editing.duration = $scope.getHours()
					$scope.editing.project = $scope.newtimesheet.project
					$scope.editing.comment = $scope.newtimesheet.comment
					$scope.editing.activity = $scope.newtimesheet.activity

					$scope.editing.$update (response) ->

						if !response.errors?
							$notification.success("success", "Updated")
							$scope.loading = false
							$location.path "/timesheets"
						else
							console.log response.errors.name.message
							$notification.error("failed", response.errors.name.message)
							$scope.loading = false

				else

					localStorageService.add('timesheet', $scope.newtimesheet)

					if $scope.newtimesheet.date.from.isSame($scope.newtimesheet.date.to)

						newdata = new Timesheet
							date: moment($scope.newtimesheet.date.from, $scope.dateformat).local().toISOString()
							duration: $scope.getHours()
							project: $scope.newtimesheet.project
							user: $scope.user._id
							comment: $scope.newtimesheet.comment
							activity: $scope.newtimesheet.activity
							agency: $scope.user.agency

						$scope.loading = false

						newdata.$save (response) ->

							if !response.errors?
								# timesheet saved successfully, add to list
								$scope.addTimesheet(response)
								$scope.cleartime()
								$notification.success("success", "Saved")
								$scope.loading = false
							else
								console.log response.errors.name.message
								$notification.error("failed", response.errors.name.message)
								$scope.loading = false

					else

						# we have a range of dates so create a new timesheet for each
						# being careful to avoid weekends (which probably aren't workdays)

						days = $scope.newtimesheet.date.to.diff($scope.newtimesheet.date.from, 'days')
						for n in [0..days]

							date = moment($scope.newtimesheet.date.from, $scope.dateformat).add(n, 'days').local()
							if date.day() isnt 0 and date.day() isnt 6

								newdata = new Timesheet
									date: date.toISOString()
									duration: $scope.getHours()
									project: $scope.newtimesheet.project
									user: $scope.user._id
									comment: $scope.newtimesheet.comment
									activity: $scope.newtimesheet.activity
									agency: $scope.user.agency

								newdata.$save (response) ->

									if !response.errors?
										# timesheet saved successfully, add to list
										$scope.addTimesheet(response)
										$scope.cleartime()
										$notification.success("success", "Saved")
										$scope.loading = false
									else
										console.log response.errors.name.message
										$notification.error("failed", response.errors.name.message)
										$scope.loading = false

			else
				console.log "Missing or invalid timesheet data"
				$notification.error("failed", "Missing or invalid timesheet data")

		$scope.cleartime = ->
			$scope.newtimesheet =
				time: 0
				date:
					from: moment()
					to: moment()
				project: ""

		$scope.addTimesheet = (timesheet) ->
			$scope.timesheets.push timesheet

	]