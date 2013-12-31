'use strict'

describe 'Service: Activity', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Activity = {}
  beforeEach inject (_Activity_) ->
    Activity = _Activity_

  it 'should do something', () ->
    expect(!!Activity).toBe true
