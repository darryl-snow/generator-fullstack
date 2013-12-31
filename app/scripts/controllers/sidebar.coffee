'use strict'

angular.module('iproferoApp')
	.controller 'SidebarCtrl', ['$scope', '$location', 'Agency', ($scope, $location, Agency) ->

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
			title: "Activities"
			link: "/activities"
			icon: "tools"
		]

		$scope.hasAuth = false
		if $scope.currentUser.agency? and $scope.currentUser.agency isnt ""
			if $scope.currentUser.role in ["manager", "admin", "superuser"]
				$scope.hasAuth = true
				Agency.get
					agencyId: $scope.currentUser.agency
				, (response) ->
					$scope.agency = response

					$scope.adminmenu.push
						title: $scope.agency.name
						link: "/agency/" + $scope.agency._id
						icon: "cog"
	]