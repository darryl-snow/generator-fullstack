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
	# make array of people to remind, key:value
	# get all users: ID, name, email
	# make list of all user IDs and make ID the key in peopletoremind array
	# get user IDs for all timesheets for this week
	# where there's no overlap (users IDs that aren't in the timesheets list), add user email to peopletoremind array at user ID key

	peopletoremind = null
	userdetails = []
	userids = []
	User.find().select("_id name email").exec (err, users) ->
		for user in users
			userdetails[user._id] = 
				name: user.name
				email: user.email
			userids.push user._id
		console.log userdetails
		# get all timesheets for this week
		
		res.jsonp users


exports.timesheet = (req, res, next, id) ->
	Timesheet.findOne(_id: id).exec (err, timesheet) ->
		return next(err) if err
		return next(new Error("Failed to load Timesheet " + id)) unless timesheet
		req.timesheet = timesheet
		next()