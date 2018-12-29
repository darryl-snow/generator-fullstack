'use strict'

angular.module('iproferoApp')
	.factory 'Session', ['$resource', ($resource) ->
		$resource "/auth/session"
	]