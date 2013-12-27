'use strict'

angular.module('iproferoApp')
	.directive 'selectAll', () ->
		restrict: 'A'
		link: (scope, element, attrs) ->
			setTimeout ->
				element.select()
			, 1000