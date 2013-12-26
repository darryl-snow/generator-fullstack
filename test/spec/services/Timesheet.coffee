'use strict'

describe 'Service: Timesheet', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Timesheet = {}
  beforeEach inject (_Timesheet_) ->
    Timesheet = _Timesheet_

  it 'should do something', () ->
    expect(!!Timesheet).toBe true
