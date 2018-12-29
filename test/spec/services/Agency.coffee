'use strict'

describe 'Service: Agency', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Agency = {}
  beforeEach inject (_Agency_) ->
    Agency = _Agency_

  it 'should do something', () ->
    expect(!!Agency).toBe true
