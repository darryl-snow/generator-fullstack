"use strict"
mongoose = require("mongoose")
Thing = mongoose.model("Thing")
async = require("async")
exports.awesomeThings = (req, res) ->
	Thing.find (err, things) ->
		unless err
			res.json things
		else
			res.send err