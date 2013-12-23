"use strict"

# Module dependencies.
express = require("express")
path = require("path")
fs = require("fs")
passport = require("passport")
app = express()

# Configuration
env = process.env.NODE_ENV = process.env.NODE_ENV or "development"
config = require("./server/config")
require("./server/express") app

# Connect to database
db = require("./server/db/mongo")

# Bootstrap models
modelsPath = path.join(__dirname, "server/models")
fs.readdirSync(modelsPath).forEach (file) ->
	require modelsPath + "/" + file

# Populate empty DB with dummy data
require "./server/dummydata"

# Routes
routes = require("./server/routes") app, passport

# Start server
port = process.env.PORT or 3000
app.listen port, ->
	console.log "Express server listening on port %d in %s mode", port, app.get("env")

exports = module.exports = app