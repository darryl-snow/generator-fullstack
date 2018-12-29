'use strict'

angular.module('iproferoApp')
	.directive 'timetracker', [() ->
		template:
			'<div on-escape="cleartime()" data-ng-controller="TimetrackerCtrl" class="timetracker" flipper>' +
			'	<div class="panel front flip" data-ng-class="{\'flip-side-1\':!loading, \'flip-side-2\':loading}">' +
			'		<div class="icon input one half">' +
			'			<input type="text" autofocus="autofocus" min="0" max="24" step="0.25" placeholder="8" data-ng-model="newtimesheet.time" friendly-time on-enter="logtime()" select-all class="field" tabindex="1"/><i class="clock icon"></i>' +
			'		</div>' +
			'		<div class="icon input one half">' +
			'			<input type="text" placeholder="DD/MM/YYYY" data-ng-model="date" date-range-picker="date-range-picker" format="dateformat" ranges="dateranges" change="changedate" on-enter="logtime()" class="field" tabindex="2"/><i class="calendar icon"></i>' +
			'		</div>' +
			'		<div class="input one whole">' +
			'			<select data-ng-model="newtimesheet.project" data-placeholder="Project" ui-select2="ui-select2" on-enter="logtime()" class="field" tabindex="3">' +
			'				<option></option>' +
			'				<option value="{{project._id}}" data-ng-repeat="project in projects">{{project.name}}</option>' +
			'			</select>' +
			'		</div>' +
			'		<div data-ng-if="currentUser.agency" class="input one whole">' +
			'			<select data-ng-model="newtimesheet.activity" data-placeholder="Activity" ui-select2="ui-select2" on-enter="logtime()" class="field" tabindex="4">' +
			'				<option></option>' +
			'				<option value="{{activity._id}}" data-ng-repeat="activity in activities">{{activity.name}}</option>' +
			'			</select>' +
			'		</div>' +
			'		<div class="input one whole">' +
			'			<textarea type="text" placeholder="comments..." data-ng-model="newtimesheet.comment" alphanumeric-input timesheet-comment class="field" on-tab tabindex="6"></textarea>' +
			'		</div>' +
			'		<div class="input one whole centre aligned">' +
			'			<button data-ng-if="!editing" data-ng-click="logtime()" data-ng-class="{\'disabled\': !valid}" class="field" tabindex="5">log time</button>' +
			'			<button class="green" data-ng-if="editing" data-ng-click="logtime()" data-ng-class="{\'disabled\': !valid}" class="field" tabindex="5">update timesheet</button>' +
			'		</div>' +
			'	</div>' +
			'	<div class="panel back flip centre aligned" data-ng-class="{\'flip-side-1\':loading, \'flip-side-2\':!loading}">' +
			'		<div class="loader">' +
			'			<div class="loader-segment-1"></div>' +
			'			<div class="loader-segment-2"></div>' +
			'			<div class="loader-segment-3"></div>' +
			'			<div class="loader-segment-4"></div>' +
			'			<div class="loader-segment-5"></div>' +
			'			<div class="loader-segment-6"></div>' +
			'			<div class="loader-segment-7"></div>' +
			'			<div class="loader-segment-8"></div>' +
			'		</div>' +
			'		<p class="small">saving</p>' +
			'	</div>' +
			'</div>'
		restrict: 'E'
		replace: true
		link: (scope, element, attrs) ->
			element.find("button.field").on "click", ->
				element.find("input[type='number']").focus()
			
	]