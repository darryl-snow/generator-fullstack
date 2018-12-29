mongoose = require("mongoose")
Schema = mongoose.Schema

ClientSchema = new Schema(
	name: String
	email: String
	agency: String
)

# Ensure name is present
ClientSchema.path("name").validate ((name) ->
	name.length
), "Name cannot be blank"

# return a random client, for testing
ClientSchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "Client", ClientSchema