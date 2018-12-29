express = require("express")
path = require("path")
passport = require("passport")
mongoStore = require("connect-mongo")(express)
config = require("./config")

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
		app.use express.cookieParser()
		app.use express.bodyParser()
		app.use express.methodOverride()
		app.use express.session(
			secret: "MYSECRET"
			store: new mongoStore(
				url: config.db
				collection: "sessions"
			)
			cookie:
				expires: new Date(Date.now() + 15552000)
				maxAge: 15552000 #3 months
				httpOnly: true
		)
		app.use passport.initialize()
		app.use passport.session()

		# Router needs to be last
		app.use app.router

		# ensure environment variable is available throughout the app
		app.locals
			env: process.env.NODE_ENV
		app.use (err, req, res, next) ->
			return next() if ~err.message.indexOf("not found")
			console.error err.stack
			res.status(500).render "500",
				error: err.stack
		app.use (req, res, next) ->
			res.status(404).render "404",
				url: req.originalUrl
				error: "Not found"