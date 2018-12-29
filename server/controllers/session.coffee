"use strict"
mongoose = require("mongoose")
passport = require("passport")

# returns authenticated user
exports.session = (req, res) ->
	res.jsonp req.user

# returns nothing
exports.logout = (req, res) ->
	if req.user
		req.logout()
		res.send 200
	else
		res.send 400, "Not logged in anyway"

# requires: {email, password}
exports.login = (req, res, next) ->
	passport.authenticate("local", (err, user, info) ->
		error = err or info
		return res.jsonp(400, error) if error
		req.logIn user, (err) ->
			return res.send(err) if err
			res.jsonp req.user
	) req, res, next