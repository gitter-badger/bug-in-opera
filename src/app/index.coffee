app = module.exports = require('derby').createApp('bug', __filename)
app.loadViews __dirname + "/../../views/app"
app.loadStyles __dirname + "/../../styles/app"
require("../../ui")(app)

app.get "/", (page) ->
  page.render "home"

app.get "/page1", (page) ->
  page.render "page1"

app.get "/page2", (page) ->
  page.render "page2"
