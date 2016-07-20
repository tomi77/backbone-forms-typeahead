# Backbone-Forms Bootstrap TypeAhead editor

[![Code Climate](https://codeclimate.com/github/tomi77/backbone-forms-typeahead/badges/gpa.svg)](https://codeclimate.com/github/tomi77/backbone-forms-typeahead)
[![devDependency Status](https://david-dm.org/tomi77/backbone-forms-typeahead/dev-status.svg)](https://david-dm.org/tomi77/backbone-forms-typeahead#info=devDependencies)

## Installation

~~~bash
bower install backbone-forms-typeahead#^1.0.0
~~~

## Usage

~~~js
var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
    'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
    'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
    'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
    'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
    'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
    'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
];

var Model = Backbone.Model.extend({
    schema: {
        name: {
            type: 'TypeAhead',
            title: 'Name',
            options: states
        }
    }
});
var model = new Model();
var form = new Backbone.Form({
    model: model
});
$('#form').html(form.render().$el);
~~~
