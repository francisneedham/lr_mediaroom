class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    @current_user ||= User.new(:email => session[:user]) if session[:user]
  end
end
