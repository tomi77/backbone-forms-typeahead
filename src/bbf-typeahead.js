var Form = Backbone.Form,
    Base = Form.editors.Base,
    Text = Form.editors.Text,
    exports = {};

/**
 * Additional editors that depend on Bootstrap Typeahead
 */
exports['bootstrap.typeahead'] = Text.extend({

    initialize: function (options) {
        Base.prototype.initialize.call(this, options);

        this.$el.attr('type', 'text');
        this.$el.attr('data-provide', 'typeahead');

        if (!this.schema || !this.schema.options) throw "Missing required 'schema.options'";
    },

    /**
     * Adds the editor to the DOM
     */
    render: function () {
        this.setValue(this.value);
        this.setOptions(this.schema.options);

        return this;
    },

    /**
     * Sets the options that populate the data-source attribute
     *
     * @param {Mixed} options
     */
    setOptions: function (options) {
        var self = this;

        // If a collection was passed, check if it needs fetching
        if (options instanceof Backbone.Collection) {
            var collection = options;

            // Don't do the fetch if it's already populated
            if (collection.length > 0) {
                this.renderOptions(options);
            } else {
                collection.fetch({
                    success: function (collection) {
                        self.renderOptions(options);
                    }
                });
            }
        }

        // If a function was passed, run it to get the options
        else if (_.isFunction(options)) {
            options(function (result) {
                self.renderOptions(result);
            }, self);
        }

        // Otherwise, ready to go straight to renderOptions
        else {
            this.renderOptions(options);
        }
    },

    /**
     * Adds the data-source attribute to the input element
     * @param {Mixed}   Options as a simple array e.g. ['option1', 'option2']
     *                      or as a Backbone collection
     */
    renderOptions: function (options) {
        var $input = this.$el,
            source;

        // Accept array
        if (_.isArray(options)) {
            source = options;
        }

        // Or Backbone collection
        else if (options instanceof Backbone.Collection) {
            source = options.reduce(function (memo, row) {
                memo.push(row.toString());
                return memo;
            }, []);
        }

        // Insert options
        $input.attr('data-items', source.length);
        $input.attr('data-source', '[' + _.map(source, function (row) {
            return '"' + row + '"';
        }).toString() + ']');

        // Select correct option
        this.setValue(this.value);
    }
});

// Exports
_.extend(Form.editors, exports);