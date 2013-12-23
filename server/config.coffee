path = require('path')
rootPath = path.normalize(__dirname + '/../..')

# general settings
module.exports =
	root: rootPath,
	port: process.env.PORT || 9000
	db: process.env.MONGOHQ_URL || "mongodb://localhost/app-development"
	apiversion: 1
	github:
		clientID: "3a15d1fc1d1db3ea9ffb"
		clientSecret: "541db94923d7547f9702e67f31d58c668ff7a4ed"
		callbackURL: "http://localhost:9000/auth/github/callback"