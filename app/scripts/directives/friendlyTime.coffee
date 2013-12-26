'use strict'

angular.module('iproferoApp')
	.directive 'friendlyTime', () ->
		restrict: "A"
		require: 'ngModel'
		link: (scope, element, attrs, ngModelController) ->
			element.on "blur", ->
				number = $(element).val()
				number = (Math.round(number * 4) / 4)
				if number % 1 != 0
					number = number.toFixed(2)

				scope.$parent.$apply ->
					$(element).val(number)

			ngModelController.$parsers.push (data) ->
				if data
					clean = data.toString().replace(/[^0-9,.]+/g, "")
					tmp = (Math.round(clean * 4) / 4)
					if tmp % 1 == 0
						tmp
					else
						tmp.toFixed(2)

			element.on "blur", ->
				if element.val() < 0 then element.val(0)
				if element.val() > 24 then element.val(24)

			element.bind "keypress", (event) ->
				event.preventDefault() if event.keyCode is 32