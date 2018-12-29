'use strict'

angular.module('iproferoApp')
	.directive 'dateRangePicker', () ->
		restrict: 'A'
		scope:
			format: "="
			ranges: "="
			change: "="
		link: (scope, element, attrs) ->
			
			$(element).daterangepicker(
				format: scope.format
				ranges: scope.ranges
				dateLimit: moment.duration(31, "days")
				startDate: new Date()
				endDate: new Date()
				maxDate: new Date()
				tapEvents: true
			, scope.change)

			element.on "blur", ->
				date = moment($(this).val())
				if date.isValid()
					scope.change(date, date)