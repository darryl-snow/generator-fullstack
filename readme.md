#Organisr.io
_who knows what it should be called? :p_
&copy; Profero 2014

[Open the app](http://proferotech.heroku.com)

# Current features

* Login/Authentication
* Living styleguide at `/styleguide`
* Timesheet Tracker (_in progress_)

# Developers

###Prerequisites:
* Node + NPM
* Angular-Fullstack Yeoman Generator: `npm install -g generator-angular-fullstack`
* Live Reload browser plugin

###Scaffolding
The angular-fullstack yeoman generator has the following sub-generators for scaffolding out the application. The documentation for these can be found [here](https://github.com/DaftMonk/generator-angular-fullstack).

* [angular-fullstack:controller](https://github.com/DaftMonk/generator-angular-fullstack#controller)
* [angular-fullstack:directive](https://github.com/DaftMonk/generator-angular-fullstack#directive)
* [angular-fullstack:filter](https://github.com/DaftMonk/generator-angular-fullstack#filter)
* [angular-fullstack:route](https://github.com/DaftMonk/generator-angular-fullstack#route)
* [angular-fullstack:service](https://github.com/DaftMonk/generator-angular-fullstack#service)
* [angular-fullstack:provider](https://github.com/DaftMonk/generator-angular-fullstack#service)
* [angular-fullstack:factory](https://github.com/DaftMonk/generator-angular-fullstack#service)
* [angular-fullstack:value](https://github.com/DaftMonk/generator-angular-fullstack#service)
* [angular-fullstack:constant](https://github.com/DaftMonk/generator-angular-fullstack#service)
* [angular-fullstack:decorator](https://github.com/DaftMonk/generator-angular-fullstack#decorator)
* [angular-fullstack:view](https://github.com/DaftMonk/generator-angular-fullstack#view)
* [angular-fullstack:deploy](https://github.com/DaftMonk/generator-angular-fullstack#deploy)

**Note: Generators are to be run from the root directory of your app.**

### Running the app:
Clone the repo and `cd` into the directory then run `npm install`

* Run for development with `grunt serve`
* Run the app in production mode with `grunt serve:dist`
* Run tests with `grunt test`
* Build public folder for deployment with `grunt dist`

### Deploying to Heroku:

If you don't already have a [heroku.com](http://heroku.com/) app run `yo angular-fullstack:deploy heroku`. This will create a production ready folder and an app on Heroku. Then run `cd heroku && git push heroku master` and then `heroku addons:add mongohq` to add a database. Running `heroku open` will open the live app in your browser.

If you do already have a heroku app, build a deployment folder for heroku with `grunt heroku`. Inside the heroku folder set up a git repo for your heroku app and push the files.

# Timesheet tracker features:

* Numerical input for hours
	- 8 by default
	- 0 minimum
	- 24 maximum
	- increments of 0.25 
	- numerical input only
* Date Range picker
	- "Today" by default
	- Menu options: Today, Yesterday, Past 5 Days, Individual days so far this week (e.g. Monday, Tuesday etc.) if it's Later than Wednesday
	- Can manually type dates ("2013/12/25", "25-12-2013", "1/1/2014") or ranges of dates (must contain two dates separated by " - ")
	- If you select "Yesterday", your preference will be saved for next time
* Projects List
	- fuzzy search
	- automatic reformatting of dates, based on a variable
* Comments
	- optional
	- alphanumeric input only
* Inline validation
	- you can't submit a timesheet without having a time, date, and project selected (button will be disabled) 
* Keyboard shortcuts
	- hit escape to reset the form
	- hit enter to submit