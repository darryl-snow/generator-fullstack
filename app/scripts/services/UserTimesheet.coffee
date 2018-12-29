'use strict'

angular.module('iproferoApp')
	.factory 'UserTimesheet', ['$resource', ($resource) ->
		$resource "/api/1/users/:userId/timesheets",
			userId: "@_id"
		,
			update:
				method: "PUT"
	]