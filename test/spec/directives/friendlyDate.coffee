'use strict'

describe 'Directive: friendlyDate', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<friendly-date></friendly-date>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the friendlyDate directive'
