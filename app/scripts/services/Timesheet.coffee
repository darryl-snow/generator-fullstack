'use strict'

angular.module('iproferoApp')
	.factory 'Timesheet', ['$resource', ($resource) ->
		$resource "/api/1/timesheets/:timesheetId",
			timesheetId: "@_id"
		,
			update:
				method: "PUT"
	]