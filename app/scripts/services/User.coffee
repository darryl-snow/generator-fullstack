'use strict'

angular.module('iproferoApp')
	.factory 'User', ['$resource', ($resource) ->
		$resource "/api/1/users/:id", {},
			update:
				method: "PUT"
	]