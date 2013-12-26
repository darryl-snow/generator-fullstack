'use strict'

angular.module('iproferoApp')
	.directive 'alphanumericInput', () ->
		require: "?ngModel"
		link: (scope, element, attrs, ngModelCtrl) ->
			ngModelCtrl.$parsers.push (inputValue) ->
				return "" if inputValue is 'undefined'
				transformedInput = inputValue.replace(/[^a-zA-Z0-9,.!'"\s]/g, "")
				unless transformedInput is inputValue
					ngModelCtrl.$setViewValue transformedInput
					ngModelCtrl.$render()
				transformedInput