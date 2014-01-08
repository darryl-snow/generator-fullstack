'use strict'

angular.module('iproferoApp')
	.filter 'friendlyTime', () ->
		(input) ->
			time = input
			if input % 1 isnt 0
					hours = input - (input % 1) + "hrs "
					minutes = (input % 1) * 60 + "mins"
					time = hours + minutes
				else
					time = input + "hrs"
			time