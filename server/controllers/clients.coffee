mongoose = require("mongoose")
Client = mongoose.model("Client")
_ = require("underscore")

exports.create = (req, res) ->
	client = new Client(req.body)
	client.save (err) ->
		if err
			return res.send "Could not create client"
		else
			res.jsonp client

exports.all = (req, res) ->
	agency = req.user.agency
	if agency
		Client.find(agency: agency).exec (err, clients) ->
			if err
				res.render "error",
					status: 500
			else
				res.jsonp clients
	else
		res.jsonp {}

exports.show = (req, res) ->
	# only return the client if the user belongs to the client's agency
	client = req.client
	if client.agency is req.user.agency
		res.jsonp client
	else
		res.jsonp {}

exports.update = (req, res) ->
	client = req.client
	client = _.extend(client, req.body)
	client.save (err) ->
		if err
			res.send "Could not update client"
		else
			res.jsonp client

exports.remove = (req, res) ->
	client = req.client
	Client.findOne(_id: client._id).remove (err, client) ->
		if err
			res.send "Could not delete client"
		else
			res.send "OK"

exports.client = (req, res, next, id) ->
	Client.findOne(_id: id).exec (err, client) ->
		return next(err) if err
		return next(new Error("Failed to load Client " + id)) unless client
		req.client = client
		next()