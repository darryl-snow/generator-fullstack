'use strict'

angular.module('iproferoApp')
	.directive 'flipper', () ->
		restrict: 'A'
		link: (scope, element, attrs) ->

			front = element.find(".front")
			back = element.find(".back")
			element.height(front.outerHeight())

			setTimeout ->
				if front.height() > back.height()
					back.height(front.height())
				else
					front.height(back.height())
				element.height(front.outerHeight())
			, 1000

			$(window).on "resize", ->
				element.height(front.outerHeight())