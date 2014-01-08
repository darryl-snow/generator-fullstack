mongoose = require("mongoose")
Schema = mongoose.Schema

ActivitySchema = new Schema(
	name: String
	parent: String
	children: [String]
	agency: String
)

# Ensure name is present
ActivitySchema.path("name").validate ((name) ->
	name.length
), "Name cannot be blank"

# return a random activity, for testing
ActivitySchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "Activity", ActivitySchema