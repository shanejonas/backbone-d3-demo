#requires
path = require 'path'
domino = require 'domino'
browserify = require 'browserify'
fileify = require 'fileify'
express = require 'express'
fs = require 'fs'

#get default index page
index = fs.readFileSync './public/index.html'

#get options from package.json
OPTIONS = require('./package.json').template
#set up browserify
bundle = browserify(OPTIONS)

#set up express server
app = module.exports = express.createServer()
app.configure ->
  app.use bundle
  app.use express.static __dirname + '/public', maxAge: 31536000000
  app.use app.router

#on every request, boot the app
app.all '*', (req, res, next) ->
  global.window = domino.createWindow index
  global.document = window.document
  global.navigator = window.navigator
  bootstrap = require OPTIONS.entry
  res.send(document.innerHTML)

app.listen 3000
