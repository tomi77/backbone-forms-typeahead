wrapper = (root, factory) ->
  switch
    when typeof define is 'function' and define.amd
      define ['underscore', 'backbone', 'backbone-forms', 'bootstrap-typeahead'], factory
    when typeof exports is 'object'
      require('backbone-forms')
      require('bootstrap-typeahead')
      factory require('underscore'), require('backbone')
    else
      factory root._, root.Backbone
  return

wrapper @, (_, Backbone) ->
  Form = Backbone.Form
  Base = Form.editors.Base
  Text = Form.editors.Text

  ###
  Additional editors that depend on Bootstrap Typeahead
  ###
  Form.editors['bootstrap.typeahead'] = Text.extend
    initialize: (options) ->
      Base::initialize.call @, options

      _.bindAll @, 'renderOptions'

      @$el.attr
        type: 'text'
        'data-provide': 'typeahead'

      if not @schema or not @schema.options then throw "Missing required 'schema.options'"
      return

    ###
    Adds the editor to the DOM
    ###
    render: () ->
      @setValue @value
      @setOptions @schema.options
      @

    ###
    Sets the options that populate the data-source attribute

    @param {Mixed} options
    ###
    setOptions: (options) ->
      switch
        # If a collection was passed, check if it needs fetching
        when options instanceof Backbone.Collection
          # Don't do the fetch if it's already populated
          if options.length > 0
            @renderOptions options
          else
            options.fetch success: @renderOptions

        # If a function was passed, run it to get the options
        when _.isFunction options
          options @renderOptions

        # Otherwise, ready to go straight to renderOptions
        else
          @renderOptions options

      return

    ###
    Adds the data-source attribute to the input element
    @param {Mixed}   Options as a simple array e.g. ['option1', 'option2']
                         or as a Backbone collection
    ###
    renderOptions: (options) ->
      source = switch
        # Accept array
        when _.isArray options
          options

        # Or Backbone collection
        when options instanceof Backbone.Collection
          options.reduce (memo, row) ->
            memo.push row.toString()
            memo
          , []

      # Insert options
      @$el.data
        items: source.length
        source: "[#{ source.map((row) -> '"' + row + '"').toString() }]"

      # Select correct option
      @setValue @value
      return
