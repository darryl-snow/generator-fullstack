path = require('path')
rootPath = path.normalize(__dirname + '/../..')

# general settings
module.exports =
	root: rootPath,
	port: process.env.PORT || 9000
	db: process.env.MONGOHQ_URL
	apiversion: 1