'use strict'

angular.module('iproferoApp')
	.directive 'uniqueEmail', ['$http', ($http) ->
		restrict: "A"
		require: "ngModel"
		link: (scope, element, attrs, ngModel) ->
			validate = (value) ->
				unless value
					ngModel.$setValidity "unique", true
					return
				$http.get("/auth/check_email/" + value).success (user) ->
					unless user.exists
						ngModel.$setValidity "unique", true
					else
						ngModel.$setValidity "unique", false
	
			scope.$watch (->
				ngModel.$viewValue
			), validate
	]