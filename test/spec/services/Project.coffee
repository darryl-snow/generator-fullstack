'use strict'

describe 'Service: Project', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Project = {}
  beforeEach inject (_Project_) ->
    Project = _Project_

  it 'should do something', () ->
    expect(!!Project).toBe true
