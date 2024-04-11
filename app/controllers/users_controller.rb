class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create, :default]
  before_action :set_user, only: [:show, :update, :destroy, :upload_image]

  def default
    render json: { message: 'Welcome to the Help Desk API' }, status: 200
  end
  
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
    
    # Prepare the attributes hash for updating
    attributes_to_update = {}

    # Add attributes to the hash if they are present in the params
    attributes_to_update[:is_tech] = edit_user_params[:is_tech] if edit_user_params[:is_tech].present?
    attributes_to_update[:is_admin] = edit_user_params[:is_admin] if edit_user_params[:is_admin].present?
    attributes_to_update[:active] = edit_user_params[:active] if edit_user_params[:active].present?
    attributes_to_update[:f_name] = edit_user_params[:f_name] if edit_user_params[:f_name].present?
    attributes_to_update[:l_name] = edit_user_params[:l_name] if edit_user_params[:l_name].present?
    attributes_to_update[:email] = edit_user_params[:email] if edit_user_params[:email].present?
    attributes_to_update[:groups] = Group.where(id: group_ids)
    puts "Attributes to update: #{attributes_to_update}"

    # do the update with the attributes hash
    if @user.update(attributes_to_update)
      render json: UserBlueprint.render(@user, view: :normal), status: 200
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
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
    user_current = User.find(@current_user.id)
    render json: UserBlueprint.render(user_current, view: :normal), status: 200
  end

  def upload_image
    if @user.profile_image.attach(params[:profile_image])
      render json: UserBlueprint.render(@user, view: :normal), status: 200
    else
      render json: { error: 'Image not uploaded' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:f_name, :l_name, :email, :password, :password_confirmation, :profile_image)
  end

  # only permit the params that are present - remove nil values
  def edit_user_params
    params.select { |_, v| v.present? }.permit(:f_name, :l_name, :email, :is_tech, :is_admin, :active, :profile_image, groups: [])
  end
end
