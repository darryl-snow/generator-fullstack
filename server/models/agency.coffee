mongoose = require("mongoose")
Schema = mongoose.Schema

AgencySchema = new Schema(
	name: String
	admins: [String]
	paymentplan: String
	currency: String
	paymentdate: Date
	leavetypes: [String]
)

# Ensure name is present
AgencySchema.path("name").validate ((name) ->
	name.length
), "Name cannot be blank"

# return a random agency, for testing
AgencySchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "Agency", AgencySchema