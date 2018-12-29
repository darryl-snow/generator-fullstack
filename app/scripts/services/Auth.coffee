'use strict'

angular.module('iproferoApp')
	.factory 'Auth', ['$location', '$rootScope', 'Session', 'User', '$cookieStore', ($location, $rootScope, Session, User, $cookieStore) ->

		$rootScope.currentUser = $cookieStore.get('user') || null
		$cookieStore.remove('user')

		return {
			login: (provider, user, callback) ->
				cb = callback || angular.noop
				Session.save
					provider: provider
					email: user.email
					password: user.password
					rememberMe: user.rememberMe
				, (user) ->
					$rootScope.currentUser = user
					cb()
				, (err) ->
					cb(err.data)

			logout: (callback) ->
				cb = callback || angular.noop
				Session.delete (res) ->
					$rootScope.currentUser = null
					cb()
				, (err) ->
					cb(err.data)

			createUser: (userinfo, callback) ->
				cb = callback || angular.noop
				User.save userinfo, (user) ->
					$rootScope.currentUser = user
					return cb()
				, (err) ->
					return cb(err.data)

			currentUser: ->
				Session.get (user) ->
					$rootScope.currentUser = user

			changePassword: (email, oldPassword, newPassword, callback) ->
				cb = callback || angular.noop
				User.update
					email: email
					oldPassword: oldPassword
					newPassword: newPassword
				, (user) ->
					console.log('password changed')
					cb()
				, (err) ->
					cb(err.data)

			removeUser: (email, password, callback) ->
				cb = callback || angular.noop
				User.delete
					email: email
					password: password
				, (user) ->
					console.log(user + 'removed')
					cb()
				, (err) ->
					cb(err.data)
		}
	]