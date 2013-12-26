'use strict'

angular.module('iproferoApp')
	.directive 'onEscape', () ->
		restrict: "A"
		link: (scope, element, attrs) ->
			element.on "keydown", (event) ->
				if event.which == 27
					scope.$apply attrs.onEscape
					element.focus()