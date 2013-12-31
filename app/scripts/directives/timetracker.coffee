'use strict'

angular.module('iproferoApp')
	.directive 'timetracker', [() ->
		template:
			'<div on-escape="cleartime()" data-ng-controller="TimetrackerCtrl" class="panel timetracker">' +
			'	<div class="icon input one half">' +
			'		<input type="number" autofocus="autofocus" min="0" max="24" step="0.25" placeholder="8" data-ng-model="newtimesheet.time" friendly-time on-enter="logtime()" select-all class="field"/><i class="clock icon"></i>' +
			'	</div>' +
			'	<div class="icon input one half">' +
			'		<input type="text" placeholder="DD/MM/YYYY" data-ng-model="date" date-range-picker="date-range-picker" format="dateformat" ranges="dateranges" change="changedate" on-enter="logtime()" class="field"/><i class="calendar icon"></i>' +
			'	</div>' +
			'	<div class="input one whole">' +
			'		<select data-ng-model="newtimesheet.project" data-placeholder="Project" ui-select2="ui-select2" on-enter="logtime()" class="field">' +
			'			<option></option>' +
			'			<option value="{{project._id}}" data-ng-repeat="project in projects">{{project.name}}</option>' +
			'		</select>' +
			'	</div>' +
			'	<div data-ng-if="currentUser.agency" class="input one whole">' +
			'		<select data-ng-model="newtimesheet.activity" data-placeholder="Activity" ui-select2="ui-select2" on-enter="logtime()" class="field">' +
			'			<option></option>' +
			'			<option value="{{activity._id}}" data-ng-repeat="activity in activities">{{activity.name}}</option>' +
			'		</select>' +
			'	</div>' +
			'	<div class="input one whole">' +
			'		<textarea type="text" placeholder="comments..." data-ng-model="newtimesheet.comment" alphanumeric-input on-enter="logtime()" expand-on-focus class="field"></textarea>' +
			'	</div>' +
			'	<div class="input one whole centre aligned">' +
			'		<button data-ng-click="logtime()" data-ng-class="{\'disabled\': !valid}" class="field">log time</button>' +
			'	</div>' +
			'	<notifications>' +
			'</div>'
		restrict: 'E'
		replace: true
		link: (scope, element, attrs) ->
			element.find("button.field").on "click", ->
				element.find("input[type='number']").focus()
			
	]