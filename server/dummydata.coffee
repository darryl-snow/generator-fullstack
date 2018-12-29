"use strict"
mongoose = require("mongoose")
Activity = mongoose.model("Activity")
Agency = mongoose.model("Agency")
Client = mongoose.model("Client")
PaymentPlan = mongoose.model("PaymentPlan")
Holiday = mongoose.model("Holiday")
Project = mongoose.model("Project")
Timesheet = mongoose.model("Timesheet")
User = mongoose.model("User")
_ = require("underscore")

randomusers = []
User.find({}).remove ->
	User.create
		name: "Darryl Snow"
		email: "darryl.snow@profero.com"
		username: "darrylsnow"
		password: "password"
		role: "superuser"
	,
		name: "Alessandro Grena"
		email: "alessandro.grena@profero.com"
		username: "alessandrogrena"
		password: "password"
		role: "admin"
	,
		name: "Edward Hutchins"
		email: "edward.hutchins@profero.com"
		username: "edwardhutchins"
		password: "password"
		role: "manager"
	,
		name: "Pride Phiri"
		email: "pride.phiri@profero.com"
		username: "pridephiri"
		password: "password"
		role: "user"
	, (err) ->
		console.log "finished populating users"

		for num in [0..4]
			User.random (err, user) ->
				randomusers.push user._id

		small = ""
		medium = ""
		large = ""
		PaymentPlan.find({}).remove ->
			PaymentPlan.create
				name: "Small"
				monthlycost: 100
			,
				name: "Medium"
				monthlycost: 250
			,
				name: "Large"
				monthlycost: 500
			, (err) ->
				console.log "finished populating payment plans"
		
				PaymentPlan.findOne(name:"Small").exec (err, plan) ->
					small = plan._id
					PaymentPlan.findOne(name:"Medium").exec (err, plan) ->
						medium = plan._id
						PaymentPlan.findOne(name:"Large").exec (err, plan) ->
							large = plan._id
		
							randomagencies = []
							Agency.find({}).remove ->
								Agency.create
									name: "Profero Beijing"
									admins: [randomusers[0], randomusers[1]]
									paymentplan: small
									paymentdate: new Date
									currency: "CNY"
								,
									name: "Profero Shanghai"
									admins: [randomusers[2]]
									paymentplan: medium
									paymentdate: new Date
									currency: "JPY"
								,
									name: "Profero Tokyo"
									admins: [randomusers[3], randomusers[4]]
									paymentplan: large
									paymentdate: new Date
									currency: "USD"
								, (err) ->
									console.log "finished populating agencies"
							
									for num in [0..2]
										Agency.random (err, agency) ->
											randomagencies.push agency._id

									setTimeout ->
										User.find().exec (err, users) ->
											for user in users
												user.agency = randomagencies[0]
												user.save (err) ->
													if err then console.log err
									, 1000

									diageo = ""
									apple = ""
									unilever = ""
									Client.find({}).remove ->
										Client.create
											name: "Diageo"
											email: "someone@diageo.com"
											agency: randomagencies[0]
										,
											name: "Apple"
											email: "someone@apple.com"
											agency: randomagencies[1]
										,
											name: "Unilever"
											email: "someone@unilever.com"
											agency: randomagencies[2]
										, (err) ->
											console.log "finished populating clients"
									
											Client.findOne(name:"Diageo").exec (err, client) ->
												diageo = client._id
											Client.findOne(name:"Apple").exec (err, client) ->
												apple = client._id
											Client.findOne(name:"Unilever").exec (err, client) ->
												unilever = client._id

											planning = ""
											design = ""
											development = ""
											Activity.find({}).remove ->
												Activity.create
													name: "Planning"
													hourlyrate: 100
													dailyrate: 600
													agency: randomagencies[0]
												,
													name: "Design"
													hourlyrate: 200
													dailyrate: 1200
													agency: randomagencies[1]
												,
													name: "Development"
													hourlyrate: 300
													dailyrate: 1800
													agency: randomagencies[2]
												, (err) ->
													console.log "finished populating activities"

													Activity.findOne(name:"Planning").exec (err, activity) ->
														planning = activity._id
													Activity.findOne(name:"Design").exec (err, activity) ->
														design = activity._id
													Activity.findOne(name:"Development").exec (err, activity) ->
														development = activity._id

													randomprojects = []
													Project.find({}).remove ->
														Project.create
															name: "Malts"
															client: diageo
															agency:	randomagencies[0]
															owner: randomusers[0]
														,
															name: "EDMs"
															client: apple
															agency:	randomagencies[1]
															owner: randomusers[1]
														,
															name: "OMO"
															client: unilever
															agency:	randomagencies[2]
															owner: randomusers[2]
														,
															name: "Baileys"
															client: diageo
															agency:	randomagencies[0]
															owner: randomusers[3]
														,
															name: "New Product"
															client: apple
															agency:	randomagencies[1]
															owner: randomusers[4]
														, (err) ->
															console.log "finished populating projects"

															for num in [0..4]
																Project.random (err, project) ->
																	randomprojects.push project._id

															setTimeout ->
																Timesheet.find({}).remove ->
																	Timesheet.create
																		date: new Date
																		duration: 8
																		project: randomprojects[0]
																		activity: planning
																		user: randomusers[0]
																		comment: "no comment"
																		agency: randomagencies[0]
																	,
																		date: new Date
																		duration: 4
																		project: randomprojects[1]
																		activity: design
																		user: randomusers[1]
																		comment: ""
																		agency: randomagencies[1]
																	,
																		date: new Date
																		duration: 2.5
																		project: randomprojects[2]
																		activity: development
																		user: randomusers[2]
																		comment: "iuyfuighoih"
																		agency: randomagencies[2]
																	, (err) ->
																		console.log "finished populating timesheets"
															, 1000

									Holiday.find({}).remove ->
										Holiday.create
											agency: randomagencies[0]
											request: "please?"
											type: "annual leave"
											duration:
												start: new Date
												end: new Date
											approved: false
											user: randomusers[0]
										,
											agency: randomagencies[1]
											request: "pretty please?"
											type: "replacement leave"
											duration:
												start: new Date
												end: new Date
											approved: false
											user: randomusers[1]
										,
											agency: randomagencies[2]
											request: "reeeeeaally please?"
											type: "marriage leave"
											duration:
												start: new Date
												end: new Date
											approved: false
											user: randomusers[2]
										, (err) ->
											console.log "finished populating holidays"									
