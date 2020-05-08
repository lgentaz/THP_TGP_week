class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
  
  def index
  end

  def show
    @user = User.find(params[:id])  
  end

  def new
    @user = User.new(last_name: params[:last_name], first_name: params[:first_name], email: params[:email], age: params[:age], password: params[:password], description: params[:description])
  end

  def create
    @city = City.create(name: params[:city], zip_code: rand(10000..99999))
    @user = User.new(last_name: params[:last_name], first_name: params[:first_name], email: params[:email], age: params[:age], password: params[:password], description: params[:description], city_id: @city.id, image_url:Faker::Avatar.image)
    if @user.save
      log_in(@user)
      flash[:success] = "Tu es enregistré"
      puts @user.id
      redirect_to user_path(@user.id)
    else
      messages = []
      if @user.errors.any?
        @user.errors.full_messages.each do |message|
          messages << message
        end
        flash[:danger] = "Impossible de créer le profil: #{messages.join(" ")}"
      end
    end    

  end

  def edit
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:danger] = "Hé hé c'est pas ton potin ça!!!"
      redirect_to gossips_path
    end

  end

  def update
    @user = User.find(params[:id])
    @city = City.create(name: params[:city], zip_code: rand(10000..99999))
    if !current_user?(@user)
      flash[:danger] = "Hé hé c'est pas ton profil ça!!!"
      redirect_to gossips_path
    else
      if @user.update(last_name: params[:last_name], first_name: params[:first_name], email: params[:email], age: params[:age], password: params[:password], description: params[:description], city_id: @city.id, image_url: params[:image_url])
        flash[:success] = "Bravo! Ta modification a été enregistrée."
        redirect_to user_path(@user.id)
      else
        messages = []
        if @user.errors.any?
          @user.errors.full_messages.each do |message|
            messages << message
          end
          flash[:danger] = "Impossible de modifier le profil: #{messages.join(" ")}"
        end
        redirect_to edit_user_path
      end
    end    
  end

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end


end
