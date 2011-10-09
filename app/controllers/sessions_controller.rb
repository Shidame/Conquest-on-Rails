class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email])
    
    if debug? && user
      cookies[:persistence_token] = user.persistence_token
      redirect_to dashboard_path
    elsif user && user.authenticate(params[:session][:password])
      cookies.permanent[:persistence_token] = user.persistence_token
      redirect_to dashboard_path
    else
      flash[:email] = params[:session][:email]
      flash[:error] = true
      redirect_to root_path
    end
  end
  
  
  def destroy
    cookies[:persistence_token] = nil
    redirect_to root_path
  end
end
