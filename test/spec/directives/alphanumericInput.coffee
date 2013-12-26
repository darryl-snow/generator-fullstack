'use strict'

describe 'Directive: alphanumericInput', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<alphanumeric-input></alphanumeric-input>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the alphanumericInput directive'
