'use strict'

angular.module('iproferoApp')
	.directive 'notifications', ['$notification', '$compile', ($notification, $compile) ->
		html =
			"<div class='notification {{noti.type}}' data-ng-repeat='noti in queue' data-ng-animate=\"{enter: 'animate-enter', leave: 'animate-leave'}\">" +
				"<i class='small cross close icon' data-ng-click='removeNotification(noti)'></i>" +
				"<span data-ng-bind='noti.content'></span>" +
			"</div>"
		restrict: "E"
		template: html
		link: (scope, element, attrs) ->

			scope.queue = $notification.getQueue()

			scope.removeNotification = (noti) ->
				element.find(".notification").addClass "animate-enter"
				setTimeout ->
					scope.queue.splice scope.queue.indexOf noti, 1
				, 300
	]