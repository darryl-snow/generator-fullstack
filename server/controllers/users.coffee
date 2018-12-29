mongoose = require("mongoose")
User = mongoose.model("User")
Agency = mongoose.model("Agency")
_ = require("underscore")

# Create new user
exports.create = (req, res) ->
	user = new User(req.body)
	# This is only called when the user uses a local
	# authorisation strategy
	user.provider = "local"
	user.save (err) ->
		if err
			return res.render("error",
				errors: err.errors
				user: user
			)
		req.logIn user, (err) ->
			return next(err) if err
			res.redirect "/"

# Fetch all user profiles for agency
exports.all = (req, res) ->
	agency = req.user.agency
	if agency
		User.find(agency: agency).sort("-created").populate("user").exec (err, users) ->
			if err
				res.render "error",
					status: 500
			else
				res.jsonp users
	else
		res.jsonp {}

exports.everyone = (req, res) ->
	User.find(agency: "").sort("-created").populate("user").exec (err, users) ->
		if err
			res.render "error",
			status: 500
		else
			res.jsonp users

# Show single user profile
exports.show = (req, res) ->
	if req.profile._id.toString() is req.user._id.toString() or (req.profile.agency is req.user.agency and (req.user.role is "admin" or req.user.role is "superuser"))
		user = req.profile
		res.jsonp user
	else
		user =
			_id: req.profile._id
			name: req.profile.name
			email: req.profile.email
			username: req.profile.username
			agency: req.profile.agency
			job: req.profile.job
			manager: req.profile.manager
		res.jsonp user

# Update single user profile
exports.update = (req, res) ->
	if req.user._id is req.body._id
		user = req.user
		user = _.extend(user, req.body)
		user.save (err) ->
			if err
				res.render "error",
					status: 500
			else
				res.jsonp user
	else
		User.findOne(_id: req.body._id).exec (err, user) ->
			return next(err) if err
			return next(new Error("Failed to update User " + id)) unless user
			user = _.extend(user, req.body)
			user.save (err) ->
				if err
					res.render "error",
						status: 500
				else
					res.jsonp user

# Delete user
exports.remove = (req, res) ->
	user = req.profile
	User.findOne(_id: user._id).remove (err, user) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"

exports.exists = (req, res, next) ->
	email = req.params.email
	User.findOne
		email: email
	, (err, user) ->
		return next(new Error("Failed to load User " + email)) if err
		if user
			res.json exists: true
		else
			res.json exists: false

# Fetch single user profile
exports.user = (req, res, next, id) ->
	User.findOne(_id: id).exec (err, user) ->
		return next(err) if err
		return next(new Error("Failed to load User " + id)) unless user
		req.profile = user

		if user.agency
			Agency.findOne(_id: user.agency).exec (err, agency) ->
				return next(err) if err
				return next(new Error("Failed to load Agency " + id)) unless agency
				req.agency = agency
				next()
		else
			next()