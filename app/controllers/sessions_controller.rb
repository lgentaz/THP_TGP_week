class SessionsController < ApplicationController
  def new
    id = session[:user_id]
    @user = User.find_by(email: params[:email])
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Tu es connecté(e)."
      redirect_to gossips_path #rediriger où on veut
    else
      flash.now[:danger] = "Email ou mot de passe invalide"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to gossips_path
  end
  
end
