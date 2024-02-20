class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
  before_action :set_user, only: [:show, :update, :destroy, :user_tickets, :assigned_tickets]

  def create
    new_user = User.new(user_params)

    if new_user.save
      render json: new_user, status: 201
    else
      render json: new_user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: users, status: 200
  end

  def show
    render json: @user, status:200
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: {message: "User deleted"}, status: 200
  end

  def user_tickets
    render json: @user.tickets
  end

  def assigned_tickets
    render json: @user.assigned_tickets
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:f_name, :l_name, :email, :password, :password_confirmation)
  end
end
