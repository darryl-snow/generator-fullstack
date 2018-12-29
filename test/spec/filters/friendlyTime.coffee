'use strict'

describe 'Filter: friendlyTime', () ->

  # load the filter's module
  beforeEach module 'iproferoApp'

  # initialize a new instance of the filter before each test
  friendlyTime = {}
  beforeEach inject ($filter) ->
    friendlyTime = $filter 'friendlyTime'

  it 'should return the input prefixed with "friendlyTime filter:"', () ->
    text = 'angularjs'
    expect(friendlyTime text).toBe ('friendlyTime filter: ' + text)
