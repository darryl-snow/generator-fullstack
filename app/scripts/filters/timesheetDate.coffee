'use strict'

angular.module('iproferoApp')
	.filter 'timesheetDate', () ->
		(input) ->
			date = moment(input)
			if date.isValid()

				day = date.date()
				if day in [1, 21, 31] then suffix = "st"
				else if day in [2, 22] then suffix = "nd"
				else if day in [3, 23] then suffix = "rd"
				else suffix = "th"

				switch(date.day())
					when 0 then day = "Sunday"
					when 1 then day = "Monday"
					when 2 then day = "Tuesday"
					when 3 then day = "Wednesday"
					when 4 then day = "Thursday"
					when 5 then day = "Friday"
					when 6 then day = "Saturday"

				if date.isSame(moment(), 'day')
					returnval = "Today (" + day + " " + date.format("D") + suffix + " " + date.format("MMM") + ")"
				else if date.isSame(moment().subtract(1, 'days'), 'day')
					returnval = "Yesterday (" + day + " " + date.format("D") + suffix + " " + date.format("MMM") + ")"
				else if moment().diff(date, 'weeks') > 0
					returnval = date.format("D") + suffix + " " + date.format("MMM") + " " + date.format("YYYY")
				else
					returnval = day + " " + "(" + date.format("D") + suffix + " " + date.format("MMM") + ")"

				returnval