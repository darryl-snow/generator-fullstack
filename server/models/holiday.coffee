mongoose = require("mongoose")
Schema = mongoose.Schema

HolidaySchema = new Schema(
	agency: String
	request: String
	type: String
	duration:
		start: Date
		end: Date
	approved: Boolean
	user: String
)

# Ensure user is present
HolidaySchema.path("user").validate ((user) ->
	user.length
), "User cannot be blank"

# return a random holiday, for testing
HolidaySchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "Holiday", HolidaySchema