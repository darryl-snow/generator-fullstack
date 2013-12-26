'use strict'

angular.module('iproferoApp')
	.directive 'toggleSidebar', () ->
		restrict: 'A'
		link: (scope, element, attrs) ->

			element.on 'click', ->

				$.sidr('toggle', 'sidebar');