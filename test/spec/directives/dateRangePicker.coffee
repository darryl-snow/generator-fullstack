'use strict'

describe 'Directive: dateRangePicker', () ->

  # load the directive's module
  beforeEach module 'iproferoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<date-range-picker></date-range-picker>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the dateRangePicker directive'
