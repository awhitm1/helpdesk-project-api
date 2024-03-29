class TicketsController < ApplicationController
  before_action :authenticate_request, except: [:index]

  def index
    tickets = Ticket.all
    render json: tickets, status: :ok
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.is_open = true
    @ticket.user_id = @current_user.id
    
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def show
    ticket = Ticket.find(params[:id])
    render json: ticket, status: :ok
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket && @ticket.update(ticket_params)
      render json: @ticket, status: :ok
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def open 
    tickets = Ticket.where(is_open: true)
    render json: tickets, status: :ok
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    render json: @ticket, status: :ok
  end

  def tickets_by_status
    tickets = Ticket.where(status_id: params[:id])
    render json: tickets, status: :ok
  end

  def tickets_by_location
    tickets = Ticket.where(location_id: params[:id])
    render json: tickets, status: :ok
  end

  def tickets_by_group
    tickets = Ticket.where(group_id: @current_user.groups)
    render json: tickets, status: :ok
  end

  def tickets_by_category
    tickets = Ticket.where(category_id: params[:id])
    render json: tickets, status: :ok
  end

  def users_tickets
    tickets = Ticket.where(user_id: @current_user.id)
    render json: tickets, status: :ok
  end

  def assigned_tickets
    tickets = Ticket.where(assigned_tech_id: @current_user.id)
    render json: tickets, status: :ok
  end

  def claim_ticket
    ticket = Ticket.find(params[:id])
    ticket.assigned_tech_id = @current_user.id
    if ticket.save 
      render json: ticket, status: :ok
    else 
      render json: ticket.errors, status: :unprocessable_entity
    end
    
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :user_id, :assigned_tech_id, :is_open, :category_id, :location_id, :group_id, :status_id)
  end

  
end
