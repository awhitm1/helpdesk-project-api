class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def create
    user = User.new(user_params)
   
    if user.save
      render json: @user, status: 200
    else 
      render json: user.errors, status :unprocessable_entity
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

  def tech_tickets
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
