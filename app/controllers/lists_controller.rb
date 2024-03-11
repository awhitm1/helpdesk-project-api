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

end
