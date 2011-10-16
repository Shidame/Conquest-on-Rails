class Participation < ActiveRecord::Base
  default_value_for :units_count, Game::UNITS_COUNT_AT_BEGINNING
  
  belongs_to :game, :counter_cache => true
  belongs_to :user
  has_many :ownerships
  
  
  # Dispatch remaining units in owned territories.
  # Used when the user didn't do it himself during deployment.
  def dispatch_remaining_units!
    Participation.transaction do
      shuffled_ownerships = ownerships.shuffle
      1.upto(units_count) do
        ownerships.sample.deploy_units!(1)
      end
    end
  end
end
