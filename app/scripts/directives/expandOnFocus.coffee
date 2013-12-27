'use strict'

angular.module('iproferoApp')
	.directive 'expandOnFocus', () ->
		restrict: 'A'
		link: (scope, element, attrs) ->
			element.on "focus", ->
				element.addClass "expanded"

			element.on "blur", ->
				element.removeClass "expanded"