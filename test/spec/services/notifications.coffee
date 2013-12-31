'use strict'

describe 'Service: Notifications', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Notifications = {}
  beforeEach inject (_Notifications_) ->
    Notifications = _Notifications_

  it 'should do something', () ->
    expect(!!Notifications).toBe true
