nodemailer = require("nodemailer")
schedule = require("node-schedule")

smtpTransport = nodemailer.createTransport "SMTP",
	service: "Gmail"
	auth:
		user: "iprofero@gmail.com"
		pass: "mugwuffin"

mailOptions =
	from: "Organisr.io <no-reply@organisr.io>"
	to: "darryl.snow@profero.com"
	subject: "This is a test"
	html: "<body style='background:#ffffff;color:#333333;padding:30px;text-align:center;'><h1>Busy?</h1><h3>It looks like you haven't submitted any timesheets yet this week</h3><p>To log in to organisr.io, click the button below:</p><a style='background-color:#314559; color:#ffffff; margin: 20px auto; display:block; padding: 10px 20px; font-size: 13px; font-weight: bold; text-decoration: none; cursor: pointer;'>submit timesheets</a></body>"

rule = new schedule.RecurrenceRule()
rule.dayOfWeek = 5
rule.hour = 3

scheduledjob = schedule.scheduleJob rule, ->

	smtpTransport.sendMail mailOptions, (err, response) ->
		if err
			console.log err
		else
			console.log "Message sent:"
			console.log response.message
			smtpTransport.close()