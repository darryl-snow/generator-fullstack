'use strict'

angular.module('iproferoApp')
	.factory 'Agency', ['$resource', ($resource) ->
		$resource "/api/1/agencies/:agencyId",
			agencyId: "@_id"
		,
			update:
				method: "PUT"
	]