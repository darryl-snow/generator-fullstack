'use strict'

angular.module('iproferoApp')
	.factory 'User', ['$resource', ($resource) ->
		$resource "/api/1/users/:userId",
			userId: "@_id"
		,
			update:
				method: "PUT"
	]