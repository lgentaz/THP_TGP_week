class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])  
  end

  def new
    @user = User.new(last_name: params[:last_name], first_name: params[:first_name], email: params[:email], password: params[:password])
  end

  def create
    @user = User.new(last_name: params[:last_name], first_name: params[:first_name], email: params[:email], password: params[:password], city: City.find(params[:city_id]))
    if @user.save
      flash[:success] = "Tu es enregistré"
      redirect_to gossips_path
    else
      messages = []
      if @user.errors.any?
        @user.errors.full_messages.each do |message|
          messages << message
        end
        flash[:danger] = "Impossible de créer le profil: #{messages.join(" ")}"
      end
      render 'new'
    end    

  end

  def edit
  end

  def update
  end

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end

end
