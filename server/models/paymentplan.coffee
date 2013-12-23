mongoose = require("mongoose")
Schema = mongoose.Schema

PaymentPlanSchema = new Schema(
	name: String
	monthlycost: Number
)

# Ensure name is present
PaymentPlanSchema.path("name").validate ((name) ->
	name.length
), "Name cannot be blank"

# return a random paymentplan, for testing
PaymentPlanSchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "PaymentPlan", PaymentPlanSchema