class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    @user.persistence_token = SecureRandom.hex
    
    if @user.save
      cookies[:persistence_token] = @user.persistence_token
      redirect_to dashboard_path
    else
      render 'application/home'
    end
  end
  
  
  def dashboard
    @participations = current_user.participations.all
  end
end
