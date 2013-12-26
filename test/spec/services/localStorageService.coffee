'use strict'

describe 'Service: Localstorageservice', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Localstorageservice = {}
  beforeEach inject (_Localstorageservice_) ->
    Localstorageservice = _Localstorageservice_

  it 'should do something', () ->
    expect(!!Localstorageservice).toBe true
