class FinishDeploymentJob
  attr_reader :game_id
  
  
  def initialize(game_id)
    @game_id = game_id
  end
  
  
  # Start the game only if needed.
  def perform
    game = Game.find(game_id)
    game.start! if game.state == Game::DEPLOYMENT
  end
end
