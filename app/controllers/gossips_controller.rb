class GossipsController < ApplicationController
  def index

  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new(title: params[:title], content: params[:content], user_id: params[:user_id])
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user_id: rand(1..9))
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

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
  end
end
