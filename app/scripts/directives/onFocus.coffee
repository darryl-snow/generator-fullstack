'use strict'

angular.module('iproferoApp')
	.constant("focusConfig", focusClass: "focused")
	.directive 'onFocus', ['focusConfig', (focusConfig) ->
		restrict: "A"
		require: "ngModel"
		link: (scope, element, attrs, ngModel) ->
			ngModel.$focused = false
			element.bind("focus", (evt) ->
				element.addClass focusConfig.focusClass
				scope.$apply ->
					ngModel.$focused = true

			).bind "blur", (evt) ->
				element.removeClass focusConfig.focusClass
				scope.$apply ->
					ngModel.$focused = false
	]