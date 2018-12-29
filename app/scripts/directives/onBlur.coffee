'use strict'

angular.module('iproferoApp')
	.directive 'onBlur', () ->
		restrict: "A"
		link: (scope, element, attrs) ->
			element.on "blur", (event) ->

				if !scope.$$phase

					scope.$apply attrs.onBlur