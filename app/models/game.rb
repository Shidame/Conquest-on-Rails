class Game < ActiveRecord::Base
  MAXIMUM_PARTICIPATIONS_COUNT = 5
  
  # States.
  WAITING_FOR_PLAYERS = "WAITING_FOR_PLAYERS"
  DEPLOYMENT          = "DEPLOYMENT"
  RUNNING             = "RUNNING"
  FINISHED            = "FINISHED"
  
  default_value_for :state, Game::WAITING_FOR_PLAYERS
  
  has_many :ownerships
  has_many :participations
  has_many :users, through: :participations
  
  
  # Keep games with free slots.
  def self.not_full
    where { participations_count < Game::MAXIMUM_PARTICIPATIONS_COUNT }
  end
  
  
  # Exclude the games in which the user is.
  def self.without(user)
    joins { participations }.
    where { participations.user_id != user.id }
  end
  
  
  # Assign territories and set the limit time.
  def start_deployment!
    self.state                = Game::DEPLOYMENT
    self.deployment_finish_at = 24.hours.from_now
    save!
    dispatch_territories!
  end
  
  
  # Dispatch the given territories to the given participations.
  # Both territories and participations should be shuffled.
  def dispatch_territories!(territories, participations)    
    territories.each_with_index do |territory, index|
      realIndex     = index % participations.size
      participation = participations[realIndex]
      
      Ownership.create game_id:          id,
                       territory_id:     territory.id,
                       participation_id: participation.id
    end
  end
end
