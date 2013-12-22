"use strict"

# Module dependencies.
express = require("express")
path = require("path")
fs = require("fs")
app = express()

# Connect to database
db = require("./server/db/mongo")

# Bootstrap models
modelsPath = path.join(__dirname, "server/models")
fs.readdirSync(modelsPath).forEach (file) ->
	require modelsPath + "/" + file

# Populate empty DB with dummy data
require "./server/db/dummydata"

# Express Configuration
app.configure "development", ->
	app.use require("connect-livereload")()
	app.use express.static(path.join(__dirname, ".tmp"))
	app.use express.static(path.join(__dirname, "app"))
	app.use express.errorHandler()
	app.set "views", __dirname + "/app/views"

app.configure "production", ->
	app.use express.favicon(path.join(__dirname, "public", "favicon.ico"))
	app.use express.static(path.join(__dirname, "public"))
	app.set "views", __dirname + "/views"

app.configure ->
	app.set "view engine", "jade"
	app.use express.logger("dev")
	app.use express.bodyParser()
	app.use express.methodOverride()

	# Router needs to be last
	app.use app.router

# Controllers
api = require("./server/controllers/api")
controllers = require("./server/controllers")

# Server Routes
app.get "/api/awesomeThings", api.awesomeThings

# Angular Routes
app.get "/partials/*", controllers.partials
app.get "/*", controllers.index

# Start server
port = process.env.PORT or 3000
app.listen port, ->
	console.log "Express server listening on port %d in %s mode", port, app.get("env")