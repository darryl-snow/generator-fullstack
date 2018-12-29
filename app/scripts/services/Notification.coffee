'use strict'

angular.module('iproferoApp')
	.factory '$notification', ['$timeout', 'localStorageService', ($timeout, localStorageService) ->

		html5Notify = (icon, title, content, ondisplay, onclose) ->
			if window.webkitNotifications.checkPermission() is 0
				icon = "favicon.ico" unless icon
				noti = window.webkitNotifications.createNotification(icon, title, content)
				noti.ondisplay = ondisplay if typeof ondisplay is "function"
				noti.onclose = onclose if typeof onclose is "function"
				noti.show()
			else
				settings.html5Mode = false

		notifications = localStorageService.get('notifications') or []

		queue = []
		settings =
			info:
				duration: 5000
				enabled: true

			warning:
				duration: 5000
				enabled: true

			error:
				duration: 5000
				enabled: true

			success:
				duration: 5000
				enabled: true

			progress:
				duration: 0
				enabled: true

			custom:
				duration: 35000
				enabled: true

			details: true
			localStorage: false
			html5Mode: false
			html5DefaultIcon: "icon.png"

		# ========== SETTINGS RELATED METHODS =============
		disableHtml5Mode: ->
			settings.html5Mode = false

		getHtml5Mode: ->
			settings.html5Mode

		disableType: (notificationType) ->
			settings[notificationType].enabled = false

		enableHtml5Mode: ->

			# settings.html5Mode = true;
			settings.html5Mode = @requestHtml5ModePermissions()

		enableType: (notificationType) ->
			settings[notificationType].enabled = true

		getSettings: ->
			settings

		toggleType: (notificationType) ->
			settings[notificationType].enabled = not settings[notificationType].enabled

		toggleHtml5Mode: ->
			settings.html5Mode = not settings.html5Mode

		requestHtml5ModePermissions: ->
			if window.webkitNotifications
				console.log "notifications are available"
				if window.webkitNotifications.checkPermission() is 0
					true
				else
					window.webkitNotifications.requestPermission ->
						if window.webkitNotifications.checkPermission() is 0
							settings.html5Mode = true
						else
							settings.html5Mode = false

					false
			else
				console.log "notifications are not supported"
				false

		# ============ QUERYING RELATED METHODS ============
		getAll: ->

			# Returns all notifications that are currently stored
			notifications

		getQueue: ->
			queue

		# ============== NOTIFICATION METHODS ==============
		info: (title, content, userData) ->
			console.log title, content
			@awesomeNotify "info", "info", title, content, userData

		error: (title, content, userData) ->
			@awesomeNotify "error", "remove", title, content, userData

		success: (title, content, userData) ->
			@awesomeNotify "success", "ok", title, content, userData

		warning: (title, content, userData) ->
			@awesomeNotify "warning", "exclamation", title, content, userData

		awesomeNotify: (type, icon, title, content, userData) ->

			# image = '<i class="icon-' + image + '"></i>';
			@makeNotification type, false, icon, title, content, userData

		notify: (image, title, content, userData) ->
			
			# Wraps the makeNotification method for displaying notifications with images
			# rather than icons
			@makeNotification "custom", image, true, title, content, userData

		makeNotification: (type, image, icon, title, content, userData) ->
			notification =
				type: type
				image: image
				icon: icon
				title: title
				content: content
				timestamp: +new Date()
				userData: userData

			notifications.push notification
			if settings.html5Mode
				html5Notify image, title, content, (->
					console.log "inner on display function"
				), ->
					console.log "inner on close function"

			else
				queue.push notification
				$timeout (removeFromQueueTimeout = ->
					queue.splice queue.indexOf(notification), 1
				), settings[type].duration
			@save()
			notification

		# ============ PERSISTENCE METHODS ============ 
		save: ->
			
			# Save all the notifications into localStorage
			# console.log(JSON);
			localStorageService.add('notifications', JSON.stringify(notifications)) if settings.localStorage

		# console.log(localStorage.getItem('$notifications'));
		restore: ->

		# Load all notifications from localStorage
		clear: ->
			notifications = []
			@save()

	]