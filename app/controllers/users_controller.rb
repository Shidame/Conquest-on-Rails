class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    @user.persistence_token = User.generate_persistence_token
    
    if @user.save
      cookies[:persistence_token] = @user.persistence_token
      redirect_to dashboard_path
    else
      render 'application/home'
    end
  end
  
  
  def dashboard
    @active_dashboard = true
    @participations   = current_user.participations.includes { game.participations.user }.all
  end
end
