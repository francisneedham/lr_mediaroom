class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email])
    if user
      session[:user] = user.email
      redirect_path = session.delete(:return_to) || root_path
      redirect_to redirect_path, :notice => 'Logged in!'
    else
      flash.now.alert = 'The provided email address is not in our database'
      render :new
    end
  end

  def destroy
    session[:user] = nil
    redirect_to root_path, :notice => 'Logout succesfully'
  end
end
