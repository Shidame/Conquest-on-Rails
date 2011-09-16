class Ownership < ActiveRecord::Base
  belongs_to :territory
  belongs_to :participation
  belongs_to :game
  
  
  def deploy_units!(count)
    Ownership.transaction do
      increment!               :units_count, count
      participation.decrement! :units_count, count
    end
  end
end
