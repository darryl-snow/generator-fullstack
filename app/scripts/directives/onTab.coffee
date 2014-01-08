'use strict'

angular.module('iproferoApp')
	.directive 'onTab', [() ->
		restrict: 'A'
		link: (scope, element, attrs) ->

			element.on "keydown", (event) ->
				if event.keyCode is 9
					event.preventDefault()

					element.parent().parent().find("[tabindex="+(attrs.tabindex-1)+"]").focus()
					

	]