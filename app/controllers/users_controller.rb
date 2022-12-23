class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @user = current_user
    @users = User.all
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(current_user), notice: 'You have updated user successfully.'
    else
      @user = User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to homes_path(current_user.id), notice: 'Welcome! You have signed up successfully'
    else
      flash.now[:danger] = "失敗"
      render :new_user_registration_path
    end

    @user = login(params[:name], params[:password])
    if @user
      redirect_back_or_to homes_path(current_user.id), notice: 'Signed in successfully'
    else
      flash.now[:danger] = "Signed out successfully"
      render :user_session_path
    end
  end

  private

  def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user)
    end
  end

end
