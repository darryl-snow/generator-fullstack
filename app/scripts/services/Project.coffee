'use strict'

angular.module('iproferoApp')
	.factory 'Project', ['$resource', ($resource) ->
		$resource "/api/1/projects/:projectId",
			projectId: "@_id"
		,
			update:
				method: "PUT"
	]