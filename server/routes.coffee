# Controllers
api = require("./controllers/api")
controllers = require("./controllers")

module.exports = (app, passport) ->

	# Server Routes
	app.get "/api/awesomeThings", api.awesomeThings
	
	# Angular Routes
	app.get "/partials/*", controllers.partials
	
	# Styleguide
	app.get "/styleguide*", controllers.styleguide
	
	app.get "/*", controllers.index