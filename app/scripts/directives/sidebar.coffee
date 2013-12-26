'use strict'

angular.module('iproferoApp')
	.directive 'sidebar', () ->
		restrict: 'A'
		link: (scope, element, attrs) ->

			$(element).sidr(
				name: 'sidebar'
				side: 'left'
			)