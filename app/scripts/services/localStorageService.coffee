'use strict'

angular.module('iproferoApp')
	.provider 'localStorageService', ->

		@prefix = "organisr"
		@cookie =
			expiry: 30
			path: "/"

		@notify =
			setItem: true
			removeItem: false

		@setPrefix = (prefix) ->
			@prefix = prefix

		@setStorageCookie = (exp, path) ->
			@cookie =
				expiry: exp
				path: path

		@setNotify = (itemSet, itemRemove) ->
			@notify =
				setItem: itemSet
				removeItem: itemRemove

		$get: ["$rootScope", ($rootScope) =>
			prefix = @prefix
			cookie = @cookie
			notify = @notify
			prefix = (if !!prefix then prefix + "." else "") if prefix.substr(-1) isnt "."
			browserSupportsLocalStorage = ->
				try
					supported = ("localStorage" of window and window["localStorage"] isnt null)
					key = prefix + "__" + Math.round(Math.random() * 1e7)
					if supported
						localStorage.setItem key, ""
						localStorage.removeItem key
					true
				catch e
					$rootScope.$broadcast "LocalStorageModule.notification.error", e.message
					false

			addToLocalStorage = (key, value) ->
				unless browserSupportsLocalStorage
					$rootScope.$broadcast "LocalStorageModule.notification.warning", "LOCAL_STORAGE_NOT_SUPPORTED"
					if notify.setItem
						$rootScope.$broadcast "LocalStorageModule.notification.setitem",
							key: key
							newvalue: value
							storageType: "cookie"

					return addToCookies(key, value)
				value = null  if typeof value is "undefined"
				try
					value = angular.toJson(value)  if angular.isObject(value) or angular.isArray(value)
					localStorage.setItem prefix + key, value
					if notify.setItem
						$rootScope.$broadcast "LocalStorageModule.notification.setitem",
							key: key
							newvalue: value
							storageType: "localStorage"

				catch e
					$rootScope.$broadcast "LocalStorageModule.notification.error", e.message
					return addToCookies(key, value)
				true

			getFromLocalStorage = (key) ->
				unless browserSupportsLocalStorage
					$rootScope.$broadcast "LocalStorageModule.notification.warning", "LOCAL_STORAGE_NOT_SUPPORTED"
					return getFromCookies(key)
				item = localStorage.getItem(prefix + key)
				return null if not item or item is "null"
				return angular.fromJson(item) if item.charAt(0) is "{" or item.charAt(0) is "["
				item

			removeFromLocalStorage = (key) ->
				unless browserSupportsLocalStorage
					$rootScope.$broadcast "LocalStorageModule.notification.warning", "LOCAL_STORAGE_NOT_SUPPORTED"
					if notify.removeItem
						$rootScope.$broadcast "LocalStorageModule.notification.removeitem",
							key: key
							storageType: "cookie"

				  return removeFromCookies(key)
				try
					localStorage.removeItem prefix + key
					if notify.removeItem
						$rootScope.$broadcast "LocalStorageModule.notification.removeitem",
							key: key
							storageType: "localStorage"

				catch e
					$rootScope.$broadcast "LocalStorageModule.notification.error", e.message
					return removeFromCookies(key)
				true

			getKeysForLocalStorage = ->
				unless browserSupportsLocalStorage
					$rootScope.$broadcast "LocalStorageModule.notification.warning", "LOCAL_STORAGE_NOT_SUPPORTED"
					return false
				prefixLength = prefix.length
				keys = []
				for key of localStorage
					if key.substr(0, prefixLength) is prefix
						try
							keys.push key.substr(prefixLength)
						catch e
							$rootScope.$broadcast "LocalStorageModule.notification.error", e.Description
							return []
				keys

			clearAllFromLocalStorage = (regularExpression) ->
				regularExpression = regularExpression or ""
				tempPrefix = prefix.slice(0, -1) + "."
				testRegex = RegExp(tempPrefix + regularExpression)
				unless browserSupportsLocalStorage
					$rootScope.$broadcast "LocalStorageModule.notification.warning", "LOCAL_STORAGE_NOT_SUPPORTED"
					return clearAllFromCookies()
				prefixLength = prefix.length
				for key of localStorage
					if testRegex.test(key)
						try
							removeFromLocalStorage key.substr(prefixLength)
						catch e
							$rootScope.$broadcast "LocalStorageModule.notification.error", e.message
							return clearAllFromCookies()
				true

			browserSupportsCookies = ->
				try
					return navigator.cookieEnabled or ("cookie" of document and (document.cookie.length > 0 or (document.cookie = "test").indexOf.call(document.cookie, "test") > -1))
				catch e
					$rootScope.$broadcast "LocalStorageModule.notification.error", e.message
					return false

			addToCookies = (key, value) ->
				return false  if typeof value is "undefined"
				unless browserSupportsCookies()
					$rootScope.$broadcast "LocalStorageModule.notification.error", "COOKIES_NOT_SUPPORTED"
					return false
				try
					expiry = ""
					expiryDate = new Date()
					if value is null
						expiryDate.setTime expiryDate.getTime() + (-1 * 24 * 60 * 60 * 1000)
						expiry = "; expires=" + expiryDate.toGMTString()
						value = ""
					else if cookie.expiry isnt 0
						expiryDate.setTime expiryDate.getTime() + (cookie.expiry * 24 * 60 * 60 * 1000)
						expiry = "; expires=" + expiryDate.toGMTString()
					document.cookie = prefix + key + "=" + encodeURIComponent(value) + expiry + "; path=" + cookie.path  unless not key
				catch e
					$rootScope.$broadcast "LocalStorageModule.notification.error", e.message
					return false
				true

			getFromCookies = (key) ->
				unless browserSupportsCookies()
					$rootScope.$broadcast "LocalStorageModule.notification.error", "COOKIES_NOT_SUPPORTED"
					return false
				cookies = document.cookie.split(";")
				i = 0

				while i < cookies.length
					thisCookie = cookies[i]
					thisCookie = thisCookie.substring(1, thisCookie.length) while thisCookie.charAt(0) is " "
					return decodeURIComponent(thisCookie.substring(prefix.length + key.length + 1, thisCookie.length))  if thisCookie.indexOf(prefix + key + "=") is 0
					i++
				null

			removeFromCookies = (key) ->
				addToCookies key, null

			clearAllFromCookies = ->
				thisCookie = null
				thisKey = null
				prefixLength = prefix.length
				cookies = document.cookie.split(";")
				i = 0

				while i < cookies.length
					thisCookie = cookies[i]
					thisCookie = thisCookie.substring(1, thisCookie.length)  while thisCookie.charAt(0) is " "
					key = thisCookie.substring(prefixLength, thisCookie.indexOf("="))
					removeFromCookies key
					i++

			isSupported: browserSupportsLocalStorage
			set: addToLocalStorage
			add: addToLocalStorage
			get: getFromLocalStorage
			keys: getKeysForLocalStorage
			remove: removeFromLocalStorage
			clearAll: clearAllFromLocalStorage
			cookie:
				set: addToCookies
				add: addToCookies
				get: getFromCookies
				remove: removeFromCookies
				clearAll: clearAllFromCookies
		]