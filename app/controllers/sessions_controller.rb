class SessionsController < ApplicationController
  def create
    remember_me = params[:session][:remember_me] == '1' ? true : false
    user        = User.find_by_email(params[:session][:email])
    
    if debug? && user
      cookies[:persistence_token] = user.persistence_token
      redirect_to dashboard_path
    elsif user && user.authenticate(params[:session][:password])
      if remember_me
        cookies.permanent[:persistence_token] = user.persistence_token
      else
        cookies[:persistence_token] = user.persistence_token
      end
        redirect_to dashboard_path
    else
      flash[:email]       = params[:session][:email]
      flash[:remember_me] = remember_me
      flash[:error]       = true
      redirect_to root_path
    end
  end
  
  
  def destroy
    cookies[:persistence_token] = nil
    redirect_to root_path
  end
end
