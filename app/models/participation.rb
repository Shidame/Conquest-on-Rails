class Participation < ActiveRecord::Base
  default_value_for :units_count, Game::UNITS_COUNT_AT_BEGINNING
  
  belongs_to :game, :counter_cache => true
  belongs_to :user
  has_many :ownerships
  
  default_value_for :alive, true
  
  
  def self.alive
    where { alive == true }
  end
  
  
  # Dispatch remaining units in owned territories.
  def dispatch_remaining_units!
    units_count.times do
      ownerships.sample.deploy_units!(1)
    end
    
    update_attribute(:units_count, 0)
  end
end
