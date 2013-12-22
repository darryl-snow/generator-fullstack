'use strict';

// Module dependencies.
var express = require('express'),
	path = require('path'),
	fs = require('fs');

var app = express();

// Connect to database
var db = require('./server/db/mongo');

// Bootstrap models
var modelsPath = path.join(__dirname, 'server/models');
fs.readdirSync(modelsPath).forEach(function (file) {
	require(modelsPath + '/' + file);
});

// Populate empty DB with dummy data
require('./server/db/dummydata');


// Express Configuration
app.configure('development', function(){
	app.use(require('connect-livereload')());
	app.use(express.static(path.join(__dirname, '.tmp')));
	app.use(express.static(path.join(__dirname, 'app')));
	app.use(express.errorHandler());
	app.set('views', __dirname + '/app/views');
});

app.configure('production', function(){
	app.use(express.favicon(path.join(__dirname, 'public', 'favicon.ico')));
	app.use(express.static(path.join(__dirname, 'public')));
	app.set('views', __dirname + '/views');
});

app.configure(function(){
	app.set('view engine', 'jade');
	app.use(express.logger('dev'));
	app.use(express.bodyParser());
	app.use(express.methodOverride());

	// Router needs to be last
	app.use(app.router);
});

// Controllers
var api = require('./server/controllers/api'),
	controllers = require('./server/controllers');

// Server Routes
app.get('/api/awesomeThings', api.awesomeThings);

// Angular Routes
app.get('/partials/*', controllers.partials);
app.get('/*', controllers.index);

// Start server
var port = process.env.PORT || 3000;
app.listen(port, function () {
	console.log('Express server listening on port %d in %s mode', port, app.get('env'));
});