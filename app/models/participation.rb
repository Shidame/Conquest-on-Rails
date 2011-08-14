class Participation < ActiveRecord::Base
  default_value_for :units_count, Game::UNITS_COUNT_AT_BEGINNING
  
  belongs_to :game, :counter_cache => true
  belongs_to :user
  has_many :ownerships
  
  after_create :try_to_start_deployment
  
  
  private
  
  def try_to_start_deployment
    # Reload the game since the in memory version is still the old one.
    if game.reload.participations_count == Game::MAXIMUM_PARTICIPATIONS_COUNT
      game.start_deployment!
    end
  end
end
