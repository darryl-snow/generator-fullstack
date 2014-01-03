'use strict'

angular.module('iproferoApp')
	.service 'modalService', ['$modal', ($modal) ->

		class Modal

			constructor: ->

			modalDefaults =
				backdrop: true
				keyboard: true
				modalFade: true
				templateUrl: "partials/modal.html"

			modalOptions =
				closeButtonText: "Close"
				actionButtonText: "OK"
				headerText: "Proceed?"
				bodyText: "Perform this action?"

			@showModal = (customModalDefaults, customModalOptions) ->
				customModalDefaults = {} unless customModalDefaults
				customModalDefaults.backdrop = "true"
				@show customModalDefaults, customModalOptions

			@show = (customModalDefaults, customModalOptions) ->
				
				#Create temp objects to work with since we're in a singleton service
				tempModalDefaults = {}
				tempModalOptions = {}
				
				#Map angular-ui modal custom defaults to modal defaults defined in service
				angular.extend tempModalDefaults, modalDefaults, customModalDefaults
				
				#Map modal.html $scope custom properties to defaults defined in service
				angular.extend tempModalOptions, modalOptions, customModalOptions

				unless tempModalDefaults.controller
					tempModalDefaults.controller = ($scope, $modalInstance) ->
						$scope.modalOptions = tempModalOptions
						$scope.modalOptions.ok = (result) ->
							$modalInstance.close result
		
						$scope.modalOptions.close = (result) ->
							$modalInstance.dismiss "cancel"
				$modal.open(tempModalDefaults).result

	]