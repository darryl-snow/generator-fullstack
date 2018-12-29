mongoose = require("mongoose")
Project = mongoose.model("Project")
Agency = mongoose.model("Agency")
_ = require("underscore")

exports.create = (req, res) ->
	project = new Project(req.body)
	project.save (err) ->
		if err
			return res.send "Could not create project"
		else
			res.jsonp project

exports.all = (req, res) ->
	agency = req.user.agency
	if agency
		Project.find(agency: agency).exec (err, projects) ->
			if err
				res.render "error",
					status: 500
			else
				res.jsonp projects
	else
		Project.find(owner: req.user._id).exec (err, projects) ->
			if err
				res.render "error",
					status: 500
			else
				res.jsonp projects

exports.show = (req, res) ->
	project = req.project
	res.jsonp project

exports.update = (req, res) ->
	project = req.project
	project = _.extend(project, req.body)
	project.save (err) ->
		if err
			res.send "Could not update project"
		else
			res.jsonp project

exports.remove = (req, res) ->
	project = req.project
	Project.findOne(_id: project._id).remove (err, project) ->
		if err
			res.send "Could not delete project"
		else
			res.send "OK"

exports.project = (req, res, next, id) ->
	Project.findOne(_id: id).exec (err, project) ->
		return next(err) if err
		return next(new Error("Failed to load Project " + id)) unless project
		req.project = project

		if req.user.agency
			Agency.findOne(_id: req.user.agency).exec (err, agency) ->
				return next(err) if err
				return next(new Error("Failed to load Agency " + id)) unless agency
				req.agency = agency
				next()
		else
			next()