mongoose = require("mongoose")
Holiday = mongoose.model("Holiday")
_ = require("underscore")

exports.create = (req, res) ->
	holiday = new Holiday(req.body)
	holiday.save (err) ->
		if err
			return res.send "Could not create holiday"
		else
			res.jsonp holiday

exports.forUser = (req, res) ->
	Holiday.find(user: req.user._id).exec (err, holidays) ->
		if err
			res.send "Could not get holidays"
		else
			res.jsonp holidays

exports.forAgency = (req, res) ->
	Holiday.find(agency: req.agency._id).exec (err, holidays) ->
		if err
			res.send "Could not get holidays"
		else
			res.jsonp holidays

exports.update = (req, res) ->
	holiday = req.holiday
	holiday = _.extend(holiday, req.body)
	holiday.save (err) ->
		if err
			res.send "Could not update holiday"
		else
			res.jsonp holiday

exports.remove = (req, res) ->
	holiday = req.holiday
	Holiday.findOne(_id: holiday._id).remove (err, holiday) ->
		if err
			res.send "Could not delete holiday"
		else
			res.send "OK"

exports.holiday = (req, res, next, id) ->
	Holiday.findOne(_id: id).exec (err, holiday) ->
		return next(err) if err
		return next(new Error("Failed to load Holiday " + id)) unless holiday
		req.holiday = holiday
		next()