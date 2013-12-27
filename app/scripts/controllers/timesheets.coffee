'use strict'

angular.module('iproferoApp')
	.controller 'TimesheetsCtrl', ['$scope', '$http', 'UserTimesheet', 'Project', ($scope, $http, UserTimesheet, Project) ->		

		$scope.find = (query) ->
			UserTimesheet.query
				userId: $scope.currentUser._id
			, (timesheets) ->
				$scope.timesheets = timesheets

				for timesheet in $scope.timesheets

					Project.get
						projectId: timesheet.project
					, (project) ->
						if project
							timesheet.projectname = project.name


	]