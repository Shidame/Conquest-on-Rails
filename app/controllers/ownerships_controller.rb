class OwnershipsController < ApplicationController
  def deploy
    game = current_participation.game
    
    if game.deployment_finished? || current_participation.units_count == 0
      render :json => false
    else
      ownership = current_participation.ownerships.find(params[:id])
      ownership.deploy_units!(1)
      
      render :json => true
    end
  end
end
