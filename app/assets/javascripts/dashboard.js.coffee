$ ->
  window.juggernaut ||= new Juggernaut()
  
  $('body').delegate '#new_participation a', 'ajax:success', (event, data)->
    channel = "games/#{data.game.id}/joins"
    juggernaut.singleSubscribe channel, (data)->
      console.log("Data received...", data)
