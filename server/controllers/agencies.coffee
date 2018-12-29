mongoose = require("mongoose")
Agency = mongoose.model("Agency")
_ = require("underscore")

exports.create = (req, res) ->
	agency = new Agency(req.body)
	agency.save (err) ->
		if err
			return res.send "Could not create agency"
		else
			res.jsonp agency

exports.show = (req, res) ->
	agency = req.agency
	res.jsonp agency

exports.update = (req, res) ->
	agency = req.agency
	agency = _.extend(agency, req.body)
	agency.save (err) ->
		if err
			res.send "Could not update agency"
		else
			res.jsonp agency

exports.remove = (req, res) ->
	agency = req.agency
	Agency.findOne(_id: agency._id).remove (err, agency) ->
		if err
			res.send "Could not delete agency"
		else
			res.send "OK"

exports.agency = (req, res, next, id) ->
	Agency.findOne(_id: id).exec (err, agency) ->
		return next(err) if err
		return next(new Error("Failed to load Agency " + id)) unless agency
		req.agency = agency
		next()