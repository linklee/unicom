define(
    [
        'jquery',
        'underscore',
        'backbone',
        './router',
        'modules/QiwiIframe'
    ],
    function(
        $,
        _,
        Backbone,
        Router
    ) {
        'use strict';

        var router = null;
        router = new Router();
        
        Backbone.history.start({root: 'qiwi_iframe_v4'});


    });