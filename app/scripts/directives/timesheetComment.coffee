'use strict'

angular.module('iproferoApp')
	.directive 'timesheetComment', () ->
		restrict: 'A'
		link: (scope, element, attrs) ->
			# element.on "focus", ->
			# 	element.addClass "expanded"

			# element.on "blur", ->
			# 	element.removeClass "expanded"

			originalheight = element.height()
			fontsize = Number(getComputedStyle(element[0], null).fontSize.match(/(\d*(\.\d*)?)px/)[1])

			element.on "keydown", (event) ->

				if event.keyCode is 13
					event.preventDefault()
					element.height(element.height() + fontsize)
					element.val(element.val() + "\r\n").focus()
				else if event.keyCode is 8
					text = element.val().replace(/\s+$/g,"")
					split = text.split("\n")
					if Math.floor(element.height()/10) - Math.floor(split.length * fontsize/10) > 1
						element.height(element.height() - fontsize)