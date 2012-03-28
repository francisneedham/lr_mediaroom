class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email])
    if user
      session[:user] = user.email
      redirect_to root_path, :notice => 'Autenticazione completata con successo!'
    else
      flash.now.alert = 'Indirizzo email non riconosciuto.'
      render :new
    end
  end

  def destroy
    session[:user] = nil
    redirect_to root_path, :notice => 'Sei uscito correttamente'
  end
end
