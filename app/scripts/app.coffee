'use strict'

angular.module('iproferoApp', [
 'ngCookies',
 'ngResource',
 'ngSanitize',
 'ngRoute',
 'ui.route',
 'http-auth-interceptor',
 'ui.bootstrap',
 'ui.select2'
])
	.config(['$routeProvider', '$locationProvider', '$httpProvider', ($routeProvider, $locationProvider, $httpProvider) ->

		$routeProvider
			.when '/',
				templateUrl: 'partials/main'
				controller: 'MainCtrl'
			.when '/login',
				templateUrl: 'partials/login'
				controller: 'MainCtrl'
			.when '/signup',
				templateUrl: 'partials/signup'
				controller: 'MainCtrl'
			.when '/me',
				templateUrl: 'partials/profile'
				controller: 'ProfileCtrl'
			.otherwise
				redirectTo: '/'
		$locationProvider.html5Mode(true)
	]).run ['$rootScope', '$location', 'Auth', ($rootScope, $location, Auth) ->

		#watching the value of the currentUser variable.
		$rootScope.$watch 'currentUser', (currentUser) ->
			# if no currentUser and on a page that requires authorization then try to update it
			# will trigger 401s if user does not have a valid session
			Auth.currentUser() if not currentUser and (['/', '/login', '/logout', '/signup'].indexOf($location.path()) == -1)
		
		# On catching 401 errors, redirect to the login page.
		$rootScope.$on 'event:auth-loginRequired', ->
			$location.path '/login'
			false
	]