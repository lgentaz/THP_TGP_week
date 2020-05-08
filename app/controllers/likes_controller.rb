class LikesController < ApplicationController

  before_action :authenticate_user, only: [:create, :destroy]

  def create
    @like = Like.new(liked: true, gossip_id: params[:gossip_id], user_id: current_user.id)
    if @like.save
      flash[:success] = "Merci d'avoir liké!"
    else
      flash[:error] = @like.errors.full_messages.join(', ')
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if current_user?(@like.user)
      @like.destroy
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Vous devez vous connecter pour acceder au contenu."
      redirect_to new_session_path
    end
  end

end
