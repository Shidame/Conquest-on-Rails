class Participation < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  after_create :try_to_start_deployment
  
  
  private
  
  def try_to_start_deployment
    if game.participations_count == Game::MAXIMUM_PARTICIPATIONS_COUNT
      game.start_deployment!
    end
  end
end
