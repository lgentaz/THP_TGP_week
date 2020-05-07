class LikesController < ApplicationController

  before_action :authenticate_user, only: [:create, :destroy]

  def create
    @like = Like.new(gossip: params[:gossip_id], user: current_user)
    if @gossip.save
      flash[:success] = "Bravo! Ton potin a été enregistré."
      redirect_to gossips_path
    else
      messages = []
      if @gossip.errors.any?
        @gossip.errors.full_messages.each do |message|
          messages << message
        end
        flash[:danger] = "Impossible de créer le potin: #{messages.join(" ")}"
      end
      redirect_to new_gossip_path
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
