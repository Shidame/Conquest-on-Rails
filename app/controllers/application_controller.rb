class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :debug?
  
  def home
    @user = User.new
  end
  
  
  private
  
  def current_user
    return nil unless cookies[:persistence_token]
    @current_user ||= User.find_by_persistence_token(cookies[:persistence_token])
  end
  
  
  def current_participation
    @current_participation ||= (
      game_id = params[:game_id] || params[:id]
      current_user.participations.find_by_game_id(game_id)
    )
  end
  
  
  def debug?
    Rails.env == 'development'
  end
end
