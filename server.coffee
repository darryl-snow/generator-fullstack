"use strict"

# Module dependencies.
express = require("express")
path = require("path")
fs = require("fs")
passport = require("passport")
nodemailer = require("nodemailer")
schedule = require("node-schedule")
app = express()

# Configuration
env = process.env.NODE_ENV = process.env.NODE_ENV or "development"
config = require("./server/config")
require("./server/express") app
require("./server/db")

# Authentication
require("./server/authentication") passport

# Emails
require("./server/emails")

# Routes
routes = require("./server/routes") app, passport

# Start server
port = process.env.PORT or 3000
app.listen port, ->
	console.log "Express server listening on port %d in %s mode", port, app.get("env")

exports = module.exports = app