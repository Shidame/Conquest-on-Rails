class FinishDeploymentJob
  attr_reader :game_id
  
  
  def initialize(game_id)
    @game_id = game_id
  end
  
  
  def perform
    game = Game.find(game_id)
    game.start!
  end
end
