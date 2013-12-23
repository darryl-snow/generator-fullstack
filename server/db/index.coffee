express = require("express")
path = require("path")
fs = require("fs")
mongoose = require("mongoose")
mongoStore = require("connect-mongo")(express)
config = require("../config")

# Configure for possible deployment
uristring = process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or config.db
mongoOptions = db:
	safe: true

# Connect to Database
mongoose.connect uristring, mongoOptions, (err, res) ->
	if err
		console.log "ERROR connecting to: " + uristring + ". " + err
	else
		console.log "Successfully connected to: " + uristring

# Bootstrap models
modelsPath = path.join(__dirname, "../models")
fs.readdirSync(modelsPath).forEach (file) ->
	require modelsPath + "/" + file

# import dummy data
# require "../dummydata"