$ ->
  window.juggernaut    ||= new Juggernaut()
  window.subscriptions ||= {}
  
  $('body').delegate '#new_participation a', 'ajax:success', (event, data)->
    channel = "games/#{data.game.id}/joins"
    
    unless subscriptions[channel]
      subscriptions[channel] = true
      juggernaut.subscribe channel, (data)->
        console.log("Data received...", data)
