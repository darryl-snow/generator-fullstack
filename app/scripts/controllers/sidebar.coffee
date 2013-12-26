'use strict'

angular.module('iproferoApp')
	.controller 'SidebarCtrl', ($scope, Auth, $location) ->
		$scope.menu = [
			title: "Dashboard"
			link: "/"
			icon: "gauge"
		,
			title: "Timesheets"
			link: "/timesheets/report"
			icon: "clock"
		]
		$scope.adminmenu = []