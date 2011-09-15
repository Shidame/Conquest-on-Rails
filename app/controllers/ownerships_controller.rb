class OwnershipsController < ApplicationController
  def deploy
    ownership = current_participation.ownerships.find(params[:id])
    ownership.deploy_units!(1)
    
    render :nothing => true
  end
end
