# Authorisation strategies
mongoose = require('mongoose')
LocalStrategy = require('passport-local').Strategy
User = mongoose.model('User')
config = require('./config')

module.exports = (passport) ->
	
	passport.serializeUser (user, done) ->
		done null, user.id

	passport.deserializeUser (id, done) ->
		User.findOne
			_id: id
		, (err, user) ->
			done err, user

	# Local - user-provided email/password
	passport.use new LocalStrategy(
		usernameField: "email"
		passwordField: "password"
	, (email, password, done) ->
		User.findOne
			email: email
		, (err, user) ->
			return done(err) if err
			unless user
				return done(null, false,
					errors:
						email:
							type: 'Email is not registered'
				)
			unless user.authenticate(password)
				return done(null, false,
					errors:
						password:
							type: 'Password is incorrect'
				)
			done null, user
	)