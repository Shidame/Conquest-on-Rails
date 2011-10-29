class Ownership < ActiveRecord::Base
  belongs_to :territory
  belongs_to :participation
  belongs_to :game
  
  delegate :alive?, :active?, to: :participation
  
  
  def attack!(target_ownership, attackers_count)
    attack = Attack.new(self, target_ownership, attackers_count)
    attack.resolve!
    
    attack
  end
  
  
  def deploy_units!(count)
    Ownership.transaction do
      increment!               :units_count, count
      participation.decrement! :units_count, count
    end
  end
  
  
  def neighbours_include?(other_ownership)
    Neighbourhood.exists? territory_id:       territory_id,
                          other_territory_id: other_ownership.territory_id
  end
  
  
  def maximum_attackers_count
    units_count - 1
  end
end
