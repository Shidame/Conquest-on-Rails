$ ->
  window.juggernaut ||= new Juggernaut
  
  $("#dashboard #participations").each (index, participations)->
    $(participations).find(".participation").each (index, participation)->
      $participation = $(participation)
      gameId         = $participation.data("game")
      
      # Avoid the new participation.
      if gameId
        channel = "games/#{gameId}/joins"
        
        # console.log "Subscribe to #{channel}."
        juggernaut.singleSubscribe channel, (data)->
          # console.log "Data received... #{JSON.stringify(data)}"
          $participation = $("#participation_#{data.gameId}")
          $badges        = $participation.find(".badges")
          $placeholder   = $badges.find(".#{data.color}_placeholder")
          $button        = $participation.find("a")
          
          $placeholder.addClass(data.color)
          $placeholder.removeClass("nobody")
          
          # When there is no more placeholder, enable the button.
          if $badges.find(".nobody").length == 0
            $button.text($button.data("enable-with"))
            $button.removeClass("disabled")
            $button.addClass("success")