'use strict'

angular.module('iproferoApp')
	.directive 'mongooseError', () ->
		restrict: "A"
		require: "ngModel"
		link: (scope, element, attrs, ngModel) ->
			element.on "keydown", ->
				ngModel.$setValidity "mongoose", true