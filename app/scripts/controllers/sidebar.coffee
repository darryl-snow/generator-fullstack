'use strict'

angular.module('iproferoApp')
	.controller 'SidebarCtrl', ['$scope', '$location', ($scope, $location) ->

		$scope.hasAuth = false
		if $scope.currentUser.agency? and $scope.currentUser.agency isnt ""
			if $scope.currentUser.role in ["manager", "admin", "superuser"]
				$scope.hasAuth = true

		$scope.menu = [
			title: "Dashboard"
			link: "/"
			icon: "gauge"
		,
			title: "Timesheets"
			link: "/timesheets/report"
			icon: "clock"
		,
			title: "Projects"
			link: "/projects"
			icon: "archive"
		]
		$scope.adminmenu = [
		]
	]