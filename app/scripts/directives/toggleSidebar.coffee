'use strict'

angular.module('iproferoApp')
	.directive 'toggleSidebar', ['$notification', ($notification) ->
		restrict: 'A'
		link: (scope, element, attrs) ->

			element.on 'click', ->

				$.sidr('toggle', 'sidebar');

				if !$notification.getHtml5Mode()
					$notification.enableHtml5Mode()
	]