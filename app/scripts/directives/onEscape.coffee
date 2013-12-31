'use strict'

angular.module('iproferoApp')
	.directive 'onEscape', () ->
		restrict: "A"
		link: (scope, element, attrs) ->

			if attrs.global
				$(window).on "keydown", (event) ->
					if event.which == 27
						scope.$apply attrs.onEscape
						element.focus()
			else
				element.on "keydown", (event) ->
					if event.which == 27
						scope.$apply attrs.onEscape
						element.focus()