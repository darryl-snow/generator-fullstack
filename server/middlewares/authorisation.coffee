# Authorisation middlewares

# check the user is logged in
exports.requiresLogin = (req, res, next) ->
	return res.send(401, "User is not authorised") unless req.isAuthenticated()
	next()

exports.user = 

	# check the user is either admin role or that they are acting on their own profile
	hasAuthorisation: (req, res, next) ->
		return res.send(401, "User is not authorised") unless (req.profile._id is req.user._id or req.user._id in req.agency.admins or req.user.role is "superuser" or req.user._id is req.project.owner)
		next()

	canSeeProfile: (req, res, next) ->
		return res.send(401, "User is not authorised") unless (req.profile._id is req.user._id or req.user._id in req.agency.admins or req.user.role is "superuser")
		next()

	canSeeProject: (req, res, next) ->
		return res.send(401, "User is not authorised") unless (req.user._id is req.project.owner or req.user._id in req.agency.admins or req.user.role is "superuser")
		next()

	# check the user is agency admin
	isAgencyAdmin: (req, res, next) ->
		return res.send(401, "User is not authorised") unless (req.user._id in req.agency.admins or req.user.role is "superuser")
		next()

	# check the user is agency member
	isInAgency: (req, res, next) ->
		return res.send(401, "User is not authorised") unless (req.user.agency is req.agency._id or req.user.role is "superuser")
		next()

exports.project =

	hasAuthorisation: (req, res, next) ->
		return res.send(401, "User is not authorised") unless (req.user._id in req.agency.admins or req.user.role is "superuser" or req.user._id is req.project.owner)
		next()