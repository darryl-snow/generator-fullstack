'use strict'

describe 'Directive: onEnter', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<on-enter></on-enter>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the onEnter directive'
