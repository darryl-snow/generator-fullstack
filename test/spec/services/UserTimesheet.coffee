'use strict'

describe 'Service: Usertimesheet', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Usertimesheet = {}
  beforeEach inject (_Usertimesheet_) ->
    Usertimesheet = _Usertimesheet_

  it 'should do something', () ->
    expect(!!Usertimesheet).toBe true
