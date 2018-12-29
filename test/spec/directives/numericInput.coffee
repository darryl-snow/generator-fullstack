'use strict'

describe 'Directive: numericInput', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<numeric-input></numeric-input>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the numericInput directive'
