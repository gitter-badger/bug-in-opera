module.exports = class ConnectionAlert
  view: __dirname
  reconnect: ->
    model = @model
    model.set "hideReconnect", true
    setTimeout ->
      model.set "hideReconnect", false
    , 1000
    model.reconnect()

  reload: ->
    window.location.reload()