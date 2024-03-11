class ListsController < ApplicationController
  before_action :authenticate_request

  def index
    groups = Group.all
    statuses = Status.all
    locations = Location.all
    categories = Category.all
    
    lists = {
      Groups: groups,
      Statuses: statuses,
      Locations: locations,
      Categories: categories
    }
    render json: lists, status: :ok
  end

  def add_group
    group = Group.new(config_params)
    if group.save
      render json: group, status: :created
    else
      render json: group.errors, status: :unprocessable_entity
    end
  end

  def add_status
    status = Status.new(config_params)
    if status.save
      render json: status, status: :created
    else
      render json: status.errors, status: :unprocessable_entity
    end
  end

  def add_location
    location = Location.new(config_params)
    if location.save
      render json: location, status: :created
    else
      render json: location.errors, status: :unprocessable_entity
    end
  end

  def add_category
    category = Category.new(config_params)
    if category.save
      render json: category, status: :created
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def del_group
    group = Group.find(params[:id])
    group.destroy
    render json: {message: "Group deleted"}, status: 200
  end

  def del_status
    status = Status.find(params[:id])
    status.destroy
    render json: {message: "Status deleted"}, status: 200
  end

  def del_location
    location = Location.find(params[:id])
    location.destroy
    render json: {message: "Location deleted"}, status: 200
  end

  def del_category
    category = Category.find(params[:id])
    category.destroy
    render json: {message: "Category deleted"}, status: 200
  end

  private

  def config_params
    params.permit(:name)
  end

end
