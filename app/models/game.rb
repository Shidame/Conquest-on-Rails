class Game < ActiveRecord::Base
  MAXIMUM_PARTICIPATIONS_COUNT = 5
  UNITS_COUNT_AT_BEGINNING     = 25
  PLAYER_COLORS                = %w( blue green orange purple yellow )
  TURN_DURATION                = 24.hours
  
  # States.
  WAITING_FOR_PLAYERS = "WAITING_FOR_PLAYERS"
  RUNNING             = "RUNNING"
  FINISHED            = "FINISHED"
  
  default_value_for :state, Game::WAITING_FOR_PLAYERS
  
  has_many :ownerships,     dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :users,          through: :participations
  
  belongs_to :active_participation, :class_name => "Participation"
  
  
  # Keep games with free slots.
  def self.not_full
    where { participations_count < Game::MAXIMUM_PARTICIPATIONS_COUNT }
  end
  
  
  # Exclude the games in which the user is.
  def self.without(user)
    joins { participations }.
    where { participations.game_id.not_in(user.game_ids) }
  end
  
  
  def next_color
    Game::PLAYER_COLORS[participations.count]
  end
  
  
  def next_position
    participations.count + 1
  end
  
  
  # Return the next participation.
  def next_participation
    alive_participations = participations.alive.order(:position)
    index                = alive_participations.index(active_participation)
    new_index            = (index + 1) % alive_participations.size
    
    alive_participations[new_index]
  end
  
  
  # Add the user to the game.
  def add!(user)
    participation = participations.create!(color: next_color, user: user, position: next_position)
    delay_game_start if participations.count == Game::MAXIMUM_PARTICIPATIONS_COUNT
    participation
  end
  
  
  # Enqueue the deployment process.
  def delay_game_start
    Resque.enqueue(StartGameJob, id)
  end
  
  
  # Dispatch the territories to the participants and deploy few units on them.
  def start!(territories)
    Game.transaction do
      territories.each_with_index do |territory, index|
        # Implement a round-robin through participations.
        participation_index = index % participations.size
        participation       = participations[participation_index]
        
        ownerships.create!(territory: territory, participation: participation, units_count: 1)
      end
      
      participations.map(&:dispatch_remaining_units!)
      
      self.turn                 = 1
      self.state                = Game::RUNNING
      self.turn_finish_at       = TURN_DURATION.from_now
      self.active_participation = participations.find_by_position(1)
      save!
    end
    
    self
  end
  
  
  # Change the turn of the game.
  def next_turn!
    self.turn                 += 1
    self.active_participation  = next_participation
    save!
  end
  
  
  # Number of free slots.
  def missing_participations_count
    MAXIMUM_PARTICIPATIONS_COUNT - participations_count
  end
end
