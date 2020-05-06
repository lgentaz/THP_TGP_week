class CommentsController < ApplicationController
  def index
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new(content: params[:content], user_id: 1, gossip_id: params[:gossip_id])
  end

  def create
    @comment = Comment.new(content: params[:content], user_id: 1, gossip_id: params[:gossip_id])
    if @comment.save
      flash[:success] = "Bravo! Ton commentaire a été enregistré."
      redirect_to gossip_path
    else
      redirect_to gossip_path
    end    
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update(comment_params)
      flash[:success] = "Bravo! Ta modification a été enregistrée."
      redirect_to gossip_path(gossip_id)
    else
      messages = []
      if @comment.errors.any?
        @comment.errors.full_messages.each do |message|
          messages << message
        end
        flash[:danger] = "Impossible de modifier le potin: #{messages.join(" ")}"
      end
      redirect_to edit_comment_path
    end    
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(gossip_id)
  end

  private 

  def comment_params
    params.require(:comment).permit(:content)
  end


end
comment_path(comment.id)