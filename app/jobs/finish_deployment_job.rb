class FinishDeploymentJob
  @queue = :deployment
  
  # Start the game only if needed.
  def self.perform(game_id)
    game = Game.find(game_id)
    game.start! if game.state == Game::DEPLOYMENT
  end
end
