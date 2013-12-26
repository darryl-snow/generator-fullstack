'use strict'

describe 'Directive: formElements', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<form-elements></form-elements>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the formElements directive'
