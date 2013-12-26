'use strict'

angular.module('iproferoApp')
	.factory 'Timesheet', ['$resource', ($resource) ->
		$resource "/api/1/timesheets/:id", {},
			update:
				method: "PUT"
	]