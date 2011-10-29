class OwnershipsController < ApplicationController
  def attack
    game            = current_participation.game
    attacker        = current_participation.ownerships.find(params[:id])
    target          = game.ownerships.find_by_territory_id(params[:target_id])
    attackers_count = params[:attackers_count].to_i
    
    attacker.attack!(target, attackers_count)
    
    render :nothing => true
  end
  
  
  def deploy
    render :nothing => true
  end
end
