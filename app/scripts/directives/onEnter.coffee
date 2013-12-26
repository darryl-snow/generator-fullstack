'use strict'

angular.module('iproferoApp')
	.directive 'onEnter', () ->
		restrict: "A"
		link: (scope, element, attrs) ->
			element.on "keydown", (event) ->
				if event.which == 13
					scope.$apply attrs.onEnter