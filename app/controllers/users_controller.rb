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
    puts "Params received: #{edit_user_params}"

    # put the received group ids into an array - only unique, no duplicates
    group_ids = Array(edit_user_params[:groups]).map(&:to_i).uniq

    # clear the users groups
    @user.groups.clear
    
    if @user.update(groups: Group.where(id: group_ids), is_tech: edit_user_params[:is_tech], is_admin: edit_user_params[:is_admin], active: edit_user_params[:active])
      render json: UserBlueprint.render(@user, view: :normal), status: 200
    else
      render json: { errors: @user.errors.full_message }, status: :unprocessable_entity
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
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:f_name, :l_name, :email, :password, :password_confirmation)
  end

  def edit_user_params
    params.permit(:is_tech, :is_admin, :active, groups: [])
  end
end
