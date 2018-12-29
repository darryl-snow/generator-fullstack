'use strict'

describe 'Service: Modalservice', () ->

  # load the service's module
  beforeEach module 'iproferoApp'

  # instantiate service
  Modalservice = {}
  beforeEach inject (_Modalservice_) ->
    Modalservice = _Modalservice_

  it 'should do something', () ->
    expect(!!Modalservice).toBe true
