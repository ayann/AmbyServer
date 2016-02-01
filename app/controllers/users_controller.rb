class UsersController < ApplicationController
  before_action :resource, except: [:index, :create]

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
      error @user.errors.full_messages
    end
  end

  def room
    render json: @user.room
  end

  def leave_room
    if @user.unjoin @user.room
      render json: { succes: true }
    else
      error "Error perfomed pending room leave action"
    end
  end

  def room_users
    @user = User.find(params[:id])

    render json: @user.room.users
  end

  private

  def resource
    @user = User.find(params[:id])
  end

  def user_params
    params.permit :name
  end

  def error message
    render json: { error: message }, status: :unprocessable_entity
  end
end
