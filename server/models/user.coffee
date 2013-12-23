mongoose = require("mongoose")
Schema = mongoose.Schema
crypto = require("crypto")
_ = require("underscore")

authTypes = [ "local", "github", "twitter", "facebook", "google", "linkedin", "weibo" ]

# User Profile fields
UserSchema = new Schema(
	name: String
	email: String
	username: String
	agency: String
	job: String
	role: String
	manager: String
	salary: Number
	provider: String
	hashed_password: String
	salt: String
	github: {}
)

# Encrypt the user's password
UserSchema.virtual("password").set((password) ->
	@_password = password
	@salt = @makeSalt()
	@hashed_password = @encryptPassword(password)
).get ->
	@_password

validatePresenceOf = (value) ->
	value and value.length

# Ensure name is present
UserSchema.path("name").validate ((name) ->
	return true if authTypes.indexOf(@provider) isnt -1
	name.length
), "Name cannot be blank"

# Ensure email is present
UserSchema.path("email").validate ((email) ->
	return true if authTypes.indexOf(@provider) isnt -1
	email.length
), "Email cannot be blank"

# Ensure no duplicate emails
# UserSchema.path("email").validate ((email, fn) ->
# 	return fn(true) if authTypes.indexOf(@provider) isnt -1
# 	UserModel = mongoose.model("User")
# 	UserModel.find
# 		email: email.toLowerCase()
# 		provider: @provider
# 	, (err, emails) ->
# 		fn err or emails.length is 0
# ), "Email is already registered"

# Ensure username is present
UserSchema.path("username").validate ((username) ->
	return true if authTypes.indexOf(@provider) isnt -1
	username.length
), "Username cannot be blank"

# Ensure Password is present
UserSchema.path("hashed_password").validate ((hashed_password) ->
	return true if authTypes.indexOf(@provider) isnt -1
	# console.log hashed_password
	hashed_password.length
), "Password cannot be blank"

UserSchema.pre "save", (next) ->
	return next() unless @isNew
	if not validatePresenceOf(@password) and authTypes.indexOf(@provider) is -1
		next new Error("Invalid password")
	else
		next()

# return a random user, for testing
UserSchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err) if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)


UserSchema.methods =
	authenticate: (plainText) ->
		@encryptPassword(plainText) is @hashed_password

	makeSalt: ->
		Math.round((new Date().valueOf() * Math.random())) + ""

	encryptPassword: (password) ->
		return "" unless password
		crypto.createHmac("sha1", @salt).update(password).digest "hex"

mongoose.model "User", UserSchema