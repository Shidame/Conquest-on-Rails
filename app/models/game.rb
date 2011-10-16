class Game < ActiveRecord::Base
  MAXIMUM_PARTICIPATIONS_COUNT = 5
  UNITS_COUNT_AT_BEGINNING     = 25
  PLAYER_COLORS                = %w( blue green orange purple yellow )
  DEPLOYMENT_DURATION          = 24.hours
  
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
    where { participations.game_id.not_in(user.game_ids) })
    where { participations.game_id.not_in(user.game_ids) }
  end
  
  
  # Assign territories and set the limit time.
  def start_deployment!
    territories = Territory.all
    date        = Game::DEPLOYMENT_DURATION.from_now
    
    update_attributes!    state: Game::DEPLOYMENT, deployment_finish_at: date
    dispatch_territories! territories.shuffle, participations.shuffle
    Resque.enqueue_at     deployment_finish_at, FinishDeploymentJob, id
  end
  
  
  # 
  def start!
    update_attribute :state, Game::RUNNING
    dispatch_remaining_units!
  end
  
  
  # Dispatch units randomly.
  def dispatch_remaining_units!
    participations.each do |participation|
      participation.dispatch_remaining_units!
    end
  end
  
  
  # Is deployment finished?
  def deployment_finished?
    deployment_finish_at.past?
  end
  
  
  # Dispatch the given territories to the given participations with 1 unit.
  # Both territories and participations should be shuffled.
  def dispatch_territories!(territories, participations)
    territories.each_with_index do |territory, index|
      real_index    = index % participations.size
      participation = participations[real_index]
      
      participation.units_count -= 1
      Ownership.create game_id:          id,
                       territory_id:     territory.id,
                       participation_id: participation.id,
                       units_count:      1
    end
    
    participations.each_with_index do |participation, index|
      participation.color = Game::PLAYER_COLORS[index]
      participation.save!
    end
  end
  

  # Number of free slots.
  def missing_participations_count
    MAXIMUM_PARTICIPATIONS_COUNT - participations_count
  end
end
