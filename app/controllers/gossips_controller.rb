class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:edit, :create, :update, :destroy]
  def index

  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new()
  end

  def new
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: current_user)
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: current_user)
    if @gossip.save
      flash[:success] = "Bravo! Ton potin a été enregistré."
      redirect_to gossip_path(@gossip.id)
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

  def edit
    @gossip = Gossip.find(params[:id])
    if !current_user?(@gossip.user)
      flash[:danger] = "Hé hé c'est pas ton potin ça!!!"
      redirect_to gossips_path
    end
  end

  def update
    @gossip = Gossip.find(params[:id])
    if !current_user?(@gossip.user)
      flash[:danger] = "Hé hé c'est pas ton potin ça!!!"
      redirect_to gossips_path
    else
      if @gossip.update(title: params[:title], content: params[:content])
        flash[:success] = "Bravo! Ta modification a été enregistrée."
        redirect_to gossip_path(@gossip.id)
      else
        messages = []
        if @gossip.errors.any?
          @gossip.errors.full_messages.each do |message|
            messages << message
          end
          flash[:danger] = "Impossible de modifier le potin: #{messages.join(" ")}"
        end
        redirect_to edit_gossip_path
      end
    end    
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if !current_user?(@gossip.user)
      flash[:danger] = "Hé hé c'est pas ton potin ça!!!"
      redirect_to gossips_path
    else
      @gossip.destroy
      flash[:success] = "Supprimé avec succès!"
      redirect_to gossips_path
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
