class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  def home
    @user = User.new
  end
  
  
  private
  
  def current_user
    return nil unless cookies[:persistence_token]
    @current_user ||= User.find_by_persistence_token(cookies[:persistence_token])
  end
end
