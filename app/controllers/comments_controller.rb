class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:edit, :create, :update, :destroy]

  def index
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new(content: params[:content], user: current_user, gossip_id: params[:gossip_id])
  end

  def create
    @comment = Comment.new(content: params[:content], user: current_user, gossip_id: params[:gossip_id])
    if @comment.save
      flash[:success] = "Bravo! Ton commentaire a été enregistré."
      redirect_to gossip_path(@comment.gossip.id)
    else
      messages = []
      if @comment.errors.any?
        @comment.errors.full_messages.each do |message|
          messages << message
        end
        flash[:danger] = "Impossible de créer le commentaire: #{messages.join(" ")}"
      end
      redirect_to gossip_path(params[:gossip_id])
    end    
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update(content: params[:content])
      flash[:success] = "Bravo! Ta modification a été enregistrée."
      redirect_to gossip_path(@comment.gossip.id)
    else
      messages = []
      if @comment.errors.any?
        @comment.errors.full_messages.each do |message|
          messages << message
        end
        flash[:danger] = "Impossible de modifier le commentaire: #{messages.join(" ")}"
      end
      render 'edit'
    end    
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(@comment.gossip.id)
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end