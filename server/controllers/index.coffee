"use strict"
path = require("path")

exports.partials = (req, res) ->
	stripped = req.url.split(".")[0]
	requestedView = path.join("./", stripped)
	res.render requestedView, (err, html) ->
		if err
			res.render "404"
		else
			res.send html

exports.index = (req, res) ->
	res.render "index"

exports.styleguide = (req, res) ->
	url = req.url
	if url.slice(-1) == "/"
		url += "index.html"
	if url.slice(-1) == "e"
		url += "/index.html"
	# url = url.substring(1)
	url = path.join("./", url)
	res.sendfile url