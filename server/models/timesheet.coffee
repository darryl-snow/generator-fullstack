mongoose = require("mongoose")
Schema = mongoose.Schema

TimesheetSchema = new Schema(
	date: Date
	duration: Number
	project: String
	activity: String
	user: String
	comment: String
	agency: String
)

# Ensure date is present
TimesheetSchema.path("date").validate ((date) ->
	date.length
), "Date cannot be blank"

# Ensure duration is present
TimesheetSchema.path("duration").validate ((duration) ->
	duration
), "Duration cannot be zero"

# Ensure user is present
TimesheetSchema.path("user").validate ((user) ->
	user.length
), "User cannot be blank"

# Ensure project is present
TimesheetSchema.path("project").validate ((project) ->
	project.length
), "Project cannot be blank"

# return a random timesheet, for testing
TimesheetSchema.statics.random = (callback) ->
	@count (err, count) =>
		return callback(err)  if err
		rand = Math.floor(Math.random() * count)
		@findOne().skip(rand).exec callback
	.bind(this)

mongoose.model "Timesheet", TimesheetSchema