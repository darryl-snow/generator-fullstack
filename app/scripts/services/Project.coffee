'use strict'

angular.module('iproferoApp')
	.factory 'Project', ['$resource', ($resource) ->
		$resource "/api/1/projects/:id", {},
			update:
				method: "PUT"
	]