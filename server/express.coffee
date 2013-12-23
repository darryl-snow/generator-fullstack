express = require("express")
path = require("path")

# Express Configuration
module.exports = (app) ->
	app.configure "development", ->
		app.use require("connect-livereload")()
		app.use express.static(path.join(__dirname, "../.tmp"))
		app.use express.static(path.join(__dirname, "../app"))
		app.use express.errorHandler()
		app.set "views", __dirname + "/../app/views"
	
	app.configure "production", ->
		app.use express.favicon(path.join(__dirname, "../public", "favicon.ico"))
		app.use express.static(path.join(__dirname, "../public"))
		app.set "views", __dirname + "/../views"
	
	app.configure ->
		app.set "view engine", "jade"
		app.use express.logger("dev")
		app.use express.bodyParser()
		app.use express.methodOverride()
	
		# Router needs to be last
		app.use app.router