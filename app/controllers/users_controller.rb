class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :friend_list]

  def index
    @users = User.all
  end

  def show
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def friend_list
    @all_friends = @user.all_friends
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Your profile was failed to update"
      render :edit 
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
