'use strict'

angular.module('iproferoApp')
	.directive('friendlyDate', () ->
		restrict: 'A'
		require: 'ngModel'
		link: (scope, element, attrs, ngModelController) ->
			ngModelController.$parsers.push (data) ->

				# array = getHoursMinutesSeconds(data)
				# array[0] 
				console.log data

				data #convert view to model
			ngModelController.$formatters.push (data) ->
				data #convert model to view
	)