Form = Backbone.Form
Base = Form.editors.Base
Text = Form.editors.Text
exports = {}

###
Additional editors that depend on Bootstrap Typeahead
###
exports['bootstrap.typeahead'] = Text.extend
  initialize: (options) ->
    Base.prototype.initialize.call(@, options)

    @$el.attr 'type', 'text'
    @$el.attr 'data-provide', 'typeahead'

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
    # If a collection was passed, check if it needs fetching
    if options instanceof Backbone.Collection
      collection = options

      # Don't do the fetch if it's already populated
      if collection.length > 0
        @renderOptions options
      else
        collection.fetch
          success: () => @renderOptions options

    # If a function was passed, run it to get the options
    else if _.isFunction options
      options (result) => @renderOptions result

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
    # Accept array
    if _.isArray options
      source = options

    # Or Backbone collection
    else if options instanceof Backbone.Collection
      source = options.reduce (memo, row) ->
        memo.push row.toString()
        memo
      , []

    # Insert options
    @$el.attr 'data-items', source.length
    source = _.map source, (row) -> '"' + row + '"'
    @$el.attr('data-source', "[#{ source.toString() }]")

    # Select correct option
    @setValue @value
    return

# Exports
_.extend Form.editors, exports