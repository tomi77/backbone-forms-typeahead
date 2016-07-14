(function(root, factory) {
  switch (false) {
    case !(typeof define === 'function' && define.amd):
      define(['underscore', 'backbone', 'backbone-forms', 'bootstrap-typeahead'], factory);
      break;
    case typeof exports !== 'object':
      require('backbone-forms');
      require('bootstrap-typeahead');
      factory(require('underscore'), require('backbone'));
      break;
    default:
      factory(root._, root.Backbone);
  }
})(this, function(_, Backbone) {
  var Base, Form, Text;
  Form = Backbone.Form;
  Base = Form.editors.Base;
  Text = Form.editors.Text;

  /*
  Additional editors that depend on Bootstrap Typeahead
   */
  Form.editors['bootstrap.typeahead'] = Text.extend({
    initialize: function(options) {
      Base.prototype.initialize.call(this, options);
      _.bindAll(this, 'renderOptions');
      this.$el.attr({
        type: 'text',
        'data-provide': 'typeahead'
      });
      if (!this.schema || !this.schema.options) {
        throw "Missing required 'schema.options'";
      }
    },

    /*
    Adds the editor to the DOM
     */
    render: function() {
      this.setValue(this.value);
      this.setOptions(this.schema.options);
      return this;
    },

    /*
    Sets the options that populate the data-source attribute

    @param {Mixed} options
     */
    setOptions: function(options) {
      switch (false) {
        case !(options instanceof Backbone.Collection):
          if (options.length > 0) {
            this.renderOptions(options);
          } else {
            options.fetch({
              success: this.renderOptions
            });
          }
          break;
        case !_.isFunction(options):
          options(this.renderOptions, this);
          break;
        default:
          this.renderOptions(options);
      }
    },

    /*
    Adds the data-source attribute to the input element
    @param {Mixed}   Options as a simple array e.g. ['option1', 'option2']
                         or as a Backbone collection
     */
    renderOptions: function(options) {
      var source;
      source = (function() {
        switch (false) {
          case !_.isArray(options):
            return options;
          case !(options instanceof Backbone.Collection):
            return options.map(function(row) {
              return row.toString();
            });
        }
      })();
      this.$el.data({
        items: source.length,
        source: source
      });
      this.setValue(this.value);
    }
  });
});
