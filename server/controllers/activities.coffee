mongoose = require("mongoose")
Activity = mongoose.model("Activity")
_ = require("underscore")

exports.create = (req, res) ->
	activity = new Activity(req.body)
	activity.save (err) ->
		if err
			res.send "Could not create activity"
		else
			res.jsonp activity

exports.all = (req, res) ->
	Activity.find(agency: req.agency._id).exec (err, activities) ->
		if err
			res.send "Could not get activities"
		else
			if req.user._id in req.agency.admins or req.user.role is "superuser"
				res.jsonp activities
			else
				data = []
				for activity in activities
					data.push
						name: activity.name
				res.jsonp data

exports.show = (req, res) ->
	activity = req.activity
	res.jsonp activity

exports.update = (req, res) ->
	activity = req.activity
	activity = _.extend(activity, req.body)
	activity.save (err) ->
		if err
			res.send "Could not update activity"
		else
			res.jsonp activity

exports.remove = (req, res) ->
	activity = req.activity
	Activity.findOne(_id: activity._id).remove (err, activity) ->
		if err
			res.send "Could not delete activity"
		else
			res.send "OK"

exports.activity = (req, res, next, id) ->
	Activity.findOne(_id: id).exec (err, activity) ->
		return next(err) if err
		return next(new Error("Failed to load Activity " + id)) unless activity
		req.activity = activity
		next()