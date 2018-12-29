mongoose = require("mongoose")
Timesheet = mongoose.model("Timesheet")
User = mongoose.model("User")
_ = require("underscore")

exports.create = (req, res) ->
	timesheet = new Timesheet(req.body)
	timesheet.save (err) ->
		if err
			return res.send "Could not create timesheet"
		else
			res.jsonp timesheet

exports.forUser = (req, res) ->
	Timesheet.find(user: req.user._id).exec (err, timesheets) ->
		if err
			res.send "Could not get timesheets"
		else
			res.jsonp timesheets

exports.forProject = (req, res) ->
	Timesheet.find(project: req.project._id).exec (err, timesheets) ->
		if err
			res.send "Could not get timesheets"
		else
			res.jsonp timesheets

exports.forAgency = (req, res) ->
	Timesheet.find(agency: req.agency._id).exec (err, timesheets) ->
		if err
			res.send "Could not get timesheets"
		else
			res.jsonp timesheets

exports.update = (req, res) ->
	timesheet = req.timesheet
	timesheet = _.extend(timesheet, req.body)
	timesheet.save (err) ->
		if err
			res.send "Could not update timesheet"
		else
			res.jsonp timesheet

exports.remove = (req, res) ->
	timesheet = req.timesheet
	Timesheet.findOne(_id: timesheet._id).remove (err, timesheet) ->
		if err
			res.send "Could not delete timesheet"
		else
			res.send "OK"

exports.peopletoremind = (req, res) ->
	peopletoremind = []
	timesheetusers = []
	today = new Date()
	startofthisweek = new Date(today.setDate(today.getDate() - today.getDay()))
	Timesheet.find(date: $gte: startofthisweek).select("user").sort("user").exec (err, timesheets) ->
		for timesheet in timesheets
			if timesheet.user not in timesheetusers
				timesheetusers.push timesheet.user.toString()
		User.find(agency: req.user.agency).select("_id name email").sort("_id").exec (err, users) ->
			for user in users
				# see if user has not submitted a timesheet
				if user._id.toString() not in timesheetusers
					peopletoremind.push
						name: user.name
						email: user.email

			res.jsonp peopletoremind

exports.show = (req, res) ->
	timesheet = req.timesheet
	res.jsonp timesheet

exports.timesheet = (req, res, next, id) ->
	Timesheet.findOne(_id: id).exec (err, timesheet) ->
		return next(err) if err
		return next(new Error("Failed to load Timesheet " + id)) unless timesheet
		req.timesheet = timesheet
		next()