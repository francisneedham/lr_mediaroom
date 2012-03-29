class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    @current_user ||= User.new(:email => session[:user]) if session[:user]
  end

  def require_authentication
    if current_user.nil?
      if params[:gallery_id].present? and params[:id].present? # voglio scaricare una foto
        session[:return_to] = gallery_photo_path(params[:gallery_id], params[:id])
      else
        session[:return_to] = request.url
      end
      redirect_to new_session_path, :alert => 'Devi loggarti per accedere al contenuto richiesto.'
    end
  end
end
