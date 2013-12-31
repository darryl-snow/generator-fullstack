'use strict'

angular.module('iproferoApp')
	.factory 'Activity', ['$resource', ($resource) ->
		$resource "/api/1/agencies/:agencyId/activities/:activityId",
			agencyId: "@agency"
			activityId: "@_id"
		,
			update:
				method: "PUT"
	]