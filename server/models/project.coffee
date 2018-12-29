mongoose = require("mongoose")
Schema = mongoose.Schema

ProjectSchema = new Schema(
	name: String
	parent: String
	children: [String]
	client: String
	agency: String
	owner: String
)

# Ensure name is present
ProjectSchema.path("name").validate ((name) ->
	name.length
), "Name cannot be blank"

# return a random project, for testing
ProjectSchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "Project", ProjectSchema