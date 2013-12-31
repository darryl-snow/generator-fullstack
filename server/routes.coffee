# Controllers
main = require("./controllers/index")
users = require("./controllers/users")
projects = require("./controllers/projects")
agencies = require("./controllers/agencies")
activities = require("./controllers/activities")
clients = require("./controllers/clients")
timesheets = require("./controllers/timesheets")
holidays = require("./controllers/holidays")
session = require('./controllers/session')
global = require("./controllers/global")
config = require("./config")
auth = require("./middlewares/authorisation")

module.exports = (app, passport) ->

	#############################
	#
	# API Routes
	# 
	#############################

	# Users
	# app.get "/api/" + config.apiversion + "/users", users.all
	app.post "/api/" + config.apiversion + "/users", users.create
	app.get "/api/" + config.apiversion + "/users", auth.requiresLogin, users.all
	app.get "/api/" + config.apiversion + "/users/all", auth.requiresLogin, users.everyone
	app.get "/api/" + config.apiversion + "/users/:userId", auth.requiresLogin, users.show
	app.put "/api/" + config.apiversion + "/users/:userId", auth.requiresLogin, auth.user.hasAuthorisation, users.update
	app.del "/api/" + config.apiversion + "/users/:userId", auth.requiresLogin, auth.user.hasAuthorisation, users.remove
	app.param "userId", users.user

	# Projects Routes
	app.post "/api/" + config.apiversion + "/projects", auth.requiresLogin, projects.create
	app.get "/api/" + config.apiversion + "/projects", auth.requiresLogin, projects.all
	app.get "/api/" + config.apiversion + "/projects/:projectId", auth.requiresLogin, projects.show
	app.put "/api/" + config.apiversion + "/projects/:projectId", auth.requiresLogin, auth.project.hasAuthorisation, projects.update
	app.del "/api/" + config.apiversion + "/projects/:projectId", auth.requiresLogin, auth.project.hasAuthorisation, projects.remove
	app.param "projectId", projects.project

	# Agencies Routes
	app.post "/api/" + config.apiversion + "/agencies", auth.requiresLogin, agencies.create
	app.get "/api/" + config.apiversion + "/agencies/:agencyId", auth.requiresLogin, agencies.show
	app.put "/api/" + config.apiversion + "/agencies/:agencyId", auth.requiresLogin, auth.user.isAgencyAdmin, agencies.update
	app.del "/api/" + config.apiversion + "/agencies/:agencyId", auth.requiresLogin, auth.user.isAgencyAdmin, agencies.remove
	app.param "agencyId", agencies.agency
	
	# Activity Routes
	app.post "/api/" + config.apiversion + "/agencies/:agencyId/activities", auth.requiresLogin, auth.user.isAgencyAdmin, activities.create
	app.get "/api/" + config.apiversion + "/agencies/:agencyId/activities", auth.requiresLogin, auth.user.isInAgency, activities.all
	app.put "/api/" + config.apiversion + "/agencies/:agencyId/activities/:activityId", auth.requiresLogin, auth.user.isAgencyAdmin, activities.update
	app.del "/api/" + config.apiversion + "/agencies/:agencyId/activities/:activityId", auth.requiresLogin, auth.user.isAgencyAdmin, activities.remove
	app.param "activityId", activities.activity

	# Client Routes
	app.post "/api/" + config.apiversion + "/clients", auth.requiresLogin, clients.create
	app.get "/api/" + config.apiversion + "/clients", auth.requiresLogin, clients.all
	app.get "/api/" + config.apiversion + "/clients/:clientId", auth.requiresLogin, clients.show
	app.put "/api/" + config.apiversion + "/clients/:clientId", auth.requiresLogin, auth.user.hasAuthorisation, clients.update
	app.del "/api/" + config.apiversion + "/clients/:clientId", auth.requiresLogin, auth.user.hasAuthorisation, clients.remove
	app.param "clientId", clients.client

	# Timesheet Routes
	app.post "/api/" + config.apiversion + "/timesheets", auth.requiresLogin, timesheets.create
	app.get "/api/" + config.apiversion + "/users/:userId/timesheets", auth.requiresLogin, auth.user.hasAuthorisation, timesheets.forUser
	app.get "/api/" + config.apiversion + "/projects/:projectId/timesheets", auth.requiresLogin, auth.user.canSeeProject, timesheets.forProject
	app.get "/api/" + config.apiversion + "/agencies/:agencyId/timesheets", auth.requiresLogin, auth.user.isAgencyAdmin, timesheets.forAgency
	app.put "/api/" + config.apiversion + "/timesheets/:timesheetId", auth.requiresLogin, auth.user.hasAuthorisation, timesheets.update
	app.del "/api/" + config.apiversion + "/timesheets/:timesheetId", auth.requiresLogin, auth.user.hasAuthorisation, timesheets.remove
	app.param "timesheetId", timesheets.timesheet

	# Holiday Routes
	app.post "/api/" + config.apiversion + "/holidays", auth.requiresLogin, holidays.create
	app.get "/api/" + config.apiversion + "/users/:userId/holidays", auth.requiresLogin, auth.user.isInAgency, holidays.forUser
	app.get "/api/" + config.apiversion + "/agencies/:agencyId/holidays", auth.requiresLogin, auth.user.isInAgency, holidays.forAgency
	app.put "/api/" + config.apiversion + "/holidays/:holidayId", auth.requiresLogin, auth.user.hasAuthorisation, holidays.update
	app.del "/api/" + config.apiversion + "/holidays/:holidayId", auth.requiresLogin, auth.user.hasAuthorisation, holidays.remove
	app.param "holidayId", holidays.holiday

	# Miscellaneous Routes
	app.get "/api/" + config.apiversion + "/paymentplans", global.paymentplans

	#############################
	#
	# Authentication Routes
	# 
	#############################

	app.get '/auth/session', auth.requiresLogin, session.session
	app.post '/auth/session', session.login
	app.del '/auth/session', session.logout
	app.get '/logout', session.logout
	app.get '/auth/check_email/:email', users.exists

	#############################
	#
	# Angular Routes (for loading views)
	# 
	#############################

	app.get "/partials/*", main.partials

	## Styleguide
	app.get "/styleguide/*", main.styleguide

	app.get "/*", main.index