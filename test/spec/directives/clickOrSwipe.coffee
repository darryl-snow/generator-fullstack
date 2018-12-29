'use strict'

describe 'Directive: clickOrSwipe', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<click-or-swipe></click-or-swipe>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the clickOrSwipe directive'
