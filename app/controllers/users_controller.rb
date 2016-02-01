class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def search_room
    room = Room.where(user_rooms)
  end

  private

  def user_params
    params.require(:user).permit :name
  end
end
