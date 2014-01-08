'use strict'

angular.module('iproferoApp')
	.controller 'ProjectsCtrl', ['$scope', '$http', 'Project', '$notification', ($scope, $http, Project, $notification) ->

		# Get list of user/agency projects to populate
		# projects list
		Project.query "", (projects) ->
			$scope.projects = projects

		$scope.addproject = ->

			if $scope.newproject._id isnt ""
				
				editingproject =
							$scope.projects.filter (proj) -> proj._id is $scope.newproject._id
				editingproject = editingproject[0]
				if editingproject.name isnt $scope.newproject.name
					editingproject.name = $scope.newproject.name
					editingproject.$update (response) ->
						$scope.clearproject()

			else

				if $scope.newproject.name isnt ""

					project = new Project
						name: $scope.newproject.name
						agency: $scope.currentUser.agency
						owner: $scope.currentUser._id

					project.$save (response) ->
						if !response.errors?
							$scope.projects.push response
							$scope.clearproject()
							$notification.success("success", "Saved " + project.name)
						else
							console.log response.errors.name.message
							$notification.error("failed", response.errors.name.message)

		$scope.swipeLeft = (project) ->
			project.swiped = true

		$scope.swipeRight = (project) ->
			project.swiped = false

		$scope.toggleSwipe = (project) ->
			project.swiped = !project.swiped

		$scope.editproject = (project) ->
			project.editing = true
			$scope.newproject =
				_id: project._id
				name: project.name
				editing: project.editing

		$scope.cancelEdit = ->
			for project in $scope.projects
				project.editing = false
				project.swiped = false
			$scope.clearproject()

		$scope.deleteproject = (project) ->
			tmp = 
				name: project.name
				id: project.id
			console.log tmp
			project.$remove (response) ->
				if response.$resolved
					
					$notification.warning("success", "Removed " + tmp.name)

					if $scope.projects?
						$scope.projects =
							$scope.projects.filter (proj) -> proj._id != tmp.id

		$scope.clearproject = ->

			$scope.newproject =
				_id: ""
				name: ""
				editing: false

		$scope.clearproject()
	]