(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define(["underscore", "backbone", "backbone-forms", "bootstrap-typeahead"], factory);
    } else if (typeof exports === 'object') {
        module.exports = factory(require('underscore'), require('backbone'), require('backbone-forms'), require('bootstrap-typeahead'));
    } else {
        root.bbf_typeahead = factory(root._, root.Backbone);
    }
}(this, function (_, Backbone) {
