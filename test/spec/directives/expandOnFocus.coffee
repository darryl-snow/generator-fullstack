'use strict'

describe 'Directive: expandOnFocus', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<expand-on-focus></expand-on-focus>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the expandOnFocus directive'
