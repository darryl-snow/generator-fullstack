'use strict'

angular.module('iproferoApp')
  .controller 'MainCtrl', ['$scope', '$http', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
          $scope.awesomeThings = awesomeThings
  ]
