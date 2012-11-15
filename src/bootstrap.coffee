$ = require 'jqueryify'
App = require './demo/application'

$ -> $('body').html App.render().el
