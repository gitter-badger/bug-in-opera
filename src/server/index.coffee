express = require "express"
derby = require "derby"
session = require "express-session"
app = require "../app"

racerBrowserChannel = require "racer-browserchannel"
liveDbMongo = require "livedb-mongo"
coffeeify = require "coffeeify"

derby.use require "racer-bundle"
expressApp = module.exports = express();


mongoUrl = process.env.MONGO_URL or process.env.MONGOHQ_URL or "mongodb://localhost:27017/fancylucy"
store = derby.createStore
  db: liveDbMongo "#{mongoUrl}?auto_reconnect", safe: true


store.on "bundle", (browserify) ->
  browserify.transform coffeeify

# Express setup
expressApp
  .use express.static(__dirname + "/../../public")
  .use require("static-favicon")()
  .use require("compression")()
  .use app.scripts(store, extensions: ['.coffee'])
  .use racerBrowserChannel store
  .use store.modelMiddleware()
  .use require("cookie-parser")()
  .use session
    secret: process.env.SESSION_SECRET or "YOUR SECRET HERE"
  .use require("body-parser")()
  .use(app.router())

expressApp.all "*", (req, res, next) ->
  next "404: #{req.url}"

