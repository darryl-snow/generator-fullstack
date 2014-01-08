'use strict'

describe 'Filter: timesheetDate', () ->

  # load the filter's module
  beforeEach module 'iproferoApp'

  # initialize a new instance of the filter before each test
  timesheetDate = {}
  beforeEach inject ($filter) ->
    timesheetDate = $filter 'timesheetDate'

  it 'should return the input prefixed with "timesheetDate filter:"', () ->
    text = 'angularjs'
    expect(timesheetDate text).toBe ('timesheetDate filter: ' + text)
