class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
  before_action :set_user, only: [:show, :update, :destroy,]

  def create
    new_user = User.new(user_params)

    if new_user.save
      render json: UserBlueprint.render(new_user, view: :normal), status: 201
    else
      render json: new_user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: UserBlueprint.render(users, view: :normal), status: 200
  end

  def show
    render json: UserBlueprint.render(@user, view: :normal), status:200
  end

  def update
    user = User.find(params[:id])

    if @current_user.is_admin
      user.active = edit_user_params[:active]
      puts "is_tech: #{edit_user_params[:is_tech]}"
      puts "is_admin: #{edit_user_params[:is_admin]}"
      puts "groups: #{edit_user_params[:groups]}"
      puts "active: #{edit_user_params[:active]}"
      
      user.is_tech = params[:is_tech]
      user.is_admin = params[:is_admin]
      user.groups = params[:groups]
      if user.save
        render json: UserBlueprint.render(user, view: :normal), status: 200
      else 
        render json: user.errors, status: :unprocessable_entity
      end
    else
      render json: {message: "You are not authorized to perform this action"}, status: 401
    end
  end

  def destroy
    @user.destroy
    render json: {message: "User deleted"}, status: 200
  end

  def is_tech
    render json: @current_user.is_tech, status: 200
  end

  def current_user
    render json: UserBlueprint.render(@current_user, view: :normal), status: 200
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:f_name, :l_name, :email, :password, :password_confirmation)
  end
  def edit_user_params
    params.permit(:f_name, :l_name, :email, :password, :password_confirmation, :groups, :is_tech, :is_admin, :active)
  end
end
