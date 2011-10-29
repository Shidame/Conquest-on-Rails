class Attack
  attr_reader :rounds, :winner
  
  
  def initialize(attacker, target, attackers_count)
    @attacker        = attacker
    @target          = target
    @attackers_count = attackers_count
    @rounds          = {}
    
    raise TooDeadToAttack unless @attacker.alive?
    raise TooDeadToDefend unless @target.alive?
    raise NotActivePlayer unless @attacker.active?
    raise NotEnoughUnits  unless @attackers_count <= @attacker.maximum_attackers_count
    raise TargetIsTooFar  unless @attacker.neighbours_include?(@target)
  end
  
  
  # If A attacks B with X units, the system will attack until
  # all the attackers or all the defenders are dead.
  def resolve!
    attackers_count = @attackers_count
    defenders_count = @target.units_count
    round_count     = 1
    
    begin
      # The round hash will be used to store what happened in each round.
      round = {
        attackers_count: attackers_count,
        defenders_count: defenders_count,
        
        attackers_subset: attackers_subset(attackers_count),
        defenders_subset: defenders_subset(defenders_count),
        
        attacker_losses: 0,
        defender_losses: 0
      }
      
      round[:attackers_rolls] = roll_dices_sorted(round[:attackers_subset])
      round[:defenders_rolls] = roll_dices_sorted(round[:defenders_subset])
      
      # Compare the best dice of each side, then the second best if there is one.
      comparisons_count = [ round[:attackers_subset], round[:defenders_subset] ].min
      comparisons_count.times do |i|
        if round[:defenders_rolls][i] < round[:attackers_rolls][i]
          round[:defender_losses] += 1
          defenders_count         -= 1
        else
          round[:attacker_losses] += 1
          attackers_count         -= 1
        end
      end
      
      @rounds[round_count]  = round
      round_count          += 1
    end until attackers_count == 0 || defenders_count == 0
    
    
    @remaining_attackers_count = attackers_count
    @remaining_defenders_count = defenders_count
    
    @attacker_losses = @attackers_count - @remaining_attackers_count
    @defender_losses = @target.units_count - @remaining_defenders_count
    
    @winner = @remaining_attackers_count == 0 ? @target : @attacker
    
    self
  end
  
  
  def attackers_subset(count)
    [ 3, count ].min
  end
  
  
  def defenders_subset(count)
    [ 2, count ].min
  end
  
  
  def roll_dices_sorted(count)
    count.times.map do
      Dice.new(6).roll
    end.sort.reverse
  end
  
  
  class TooDeadToAttack < StandardError; end
  class TooDeadToDefend < StandardError; end
  class NotActivePlayer < StandardError; end
  class NotEnoughUnits  < StandardError; end
  class TargetIsTooFar  < StandardError; end
end
