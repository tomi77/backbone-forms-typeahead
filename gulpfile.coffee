gulp = require 'gulp'
uglify = require 'gulp-uglify'
coffee = require 'gulp-coffee'
rename = require 'gulp-rename'
wrap = require 'gulp-wrap-umd'

deps = [
  name: 'underscore', globalName: '_', paramName: '_'
,
  name: 'backbone', globalName: 'Backbone', paramName: 'Backbone'
,
  name: 'backbone-forms', globalName: 'Backbone.Forms', paramName: '_Form'
,
  name: 'bootstrap-typeahead', globalName: 'ta', paramName: '_ta'
]

gulp.task 'default', () ->
  gulp.src './src/bbf-typeahead.coffee'
  .pipe coffee bare: true, expand: true, flatten: true
  .pipe rename 'bbf-typeahead.js'
  .pipe gulp.dest './dist/'
  .pipe uglify()
  .pipe rename extname: '.min.js'
  .pipe gulp.dest './dist/'

  gulp.src './src/bbf-typeahead.coffee'
  .pipe coffee bare: true, expand: true, flatten: true
  .pipe wrap namespace: 'bbf_typeahead', exports: 'null', deps: deps
  .pipe rename 'bbf-typeahead.amd.js'
  .pipe gulp.dest './dist/'
  .pipe uglify()
  .pipe rename extname: '.min.js'
  .pipe gulp.dest './dist/'
