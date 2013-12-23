mongoose = require("mongoose")
PaymentPlan = mongoose.model("PaymentPlan")
_ = require("underscore")

exports.paymentplans = (req, res) ->
	PaymentPlan.find().exec (err, plans) ->
		if err
			res.render "error",
				status: 500
		else
			res.jsonp plans