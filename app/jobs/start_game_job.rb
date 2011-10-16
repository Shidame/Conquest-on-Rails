class StartGameJob
  @queue = :game
  
  # Start the game only if needed.
  def self.perform(game_id)
    game        = Game.find(game_id)
    territories = Territory.all.shuffle
    
    game.start!(territories)
    
    Juggernaut.publish("games/#{game.id}", {
      eventType: "START",
      gameId:    game.id
    })
  end
end
