'use strict'

angular.module('iproferoApp')
	.directive 'friendlyTime', () ->
		restrict: "A",
		require: "?ngModel"
		link: (scope, element, attrs, ngModelCtrl) ->

			return unless ngModelCtrl

			ngModelCtrl.$render = ->
				$(element).val(ngModelCtrl.$viewValue || "")

			ngModelCtrl.$formatters.push () ->
				write()

			write = ->

				number = ngModelCtrl.$modelValue

				if !number.match(/^[0-9][0-9]?(hrs)(\s[0-9][0-9](mins))?/g)

					if number % 1 isnt 0
						hours = number - (number % 1) + "hrs "
						minutes = (number % 1) * 60 + "mins"
						time = hours + minutes
					else
						time = number + "hrs"

					# write to input val
				else number

			read = ->

				number = $(element).val()

				# see if it's already friendly formatted
				if !number.match(/^[0-9][0-9]?(hrs)(\s[0-9][0-9](mins))?/g)

					# ensure it's a number
					clean = number.replace(/[^0-9,.]+/g, "")
					if clean isnt number then number = clean

					# round to the closest quarter
					number = (Math.round(number * 4) / 4)
					if number % 1 != 0
						number = number.toFixed(2)

					#ensure it's within range
					if number < 0 then number = 0
					if number > 24 then number = 24

					# format
					parts = number.toString().split(".")
					if parts.length > 1
						hours = parts[0]
						minutes = parts[1] / 100 * 60
						number = hours + "hrs " + minutes + "mins"
					else
						number = parts[0] + "hrs"

					ngModelCtrl.$setViewValue number
					ngModelCtrl.$render()

			element.on "blur", ->
				scope.$apply read

			element.on "keypress", (event) ->
				event.preventDefault() if event.keyCode is 32