class TicketsController < ApplicationController
  before_action :authenticate_request, except: [:index]

  # Get all tickets
  def index
    tickets = Ticket.all
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end
  
  def create
    # Prepare the attributes hash for updating
    attributes_to_update = {}
    
    # Add attributes to the hash if they are present in the params
    attributes_to_update[:title] = ticket_params[:title] if ticket_params[:title].present?
    attributes_to_update[:description] = ticket_params[:description] if ticket_params[:description].present?
    attributes_to_update[:assigned_tech_id] = ticket_params[:assigned_tech_id] if ticket_params[:assigned_tech_id].present?
    attributes_to_update[:is_open] = ticket_params[:is_open] if ticket_params[:is_open].present?
    attributes_to_update[:category_id] = ticket_params[:category_id] if ticket_params[:category_id].present?
    attributes_to_update[:location_id] = ticket_params[:location_id] if ticket_params[:location_id].present?
    attributes_to_update[:group_id] = ticket_params[:group_id] if ticket_params[:group_id].present?
    attributes_to_update[:status_id] = ticket_params[:status_id] if ticket_params[:status_id].present?

    @ticket = Ticket.new(attributes_to_update)
    @ticket.is_open = true
    @ticket.user_id = @current_user.id
    @ticket.add_comment(ticket_params[:comment_content], @current_user) if ticket_params[:comment_content].present?

    if @ticket.save
      render json: TicketBlueprint.render(@ticket, view: :normal), status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def show
    ticket = Ticket.find(params[:id])
    render json: TicketBlueprint.render(ticket, view: :normal), status: :ok
  end

  def update
    @ticket = Ticket.find(params[:id])

    # Prepare the attributes hash for updating
    attributes_to_update = {}

    # Add attributes to the hash if they are present in the params
    attributes_to_update[:title] = ticket_params[:title] if ticket_params[:title].present?
    attributes_to_update[:description] = ticket_params[:description] if ticket_params[:description].present?
    attributes_to_update[:assigned_tech_id] = ticket_params[:assigned_tech_id] if ticket_params[:assigned_tech_id].present?
    attributes_to_update[:is_open] = ticket_params[:is_open] if ticket_params[:is_open].present?
    attributes_to_update[:category_id] = ticket_params[:category_id] if ticket_params[:category_id].present?
    attributes_to_update[:location_id] = ticket_params[:location_id] if ticket_params[:location_id].present?
    attributes_to_update[:group_id] = ticket_params[:group_id] if ticket_params[:group_id].present?
    attributes_to_update[:status_id] = ticket_params[:status_id] if ticket_params[:status_id].present?

    # add the comment if it is present
    if @ticket && ticket_params[:comment_content].present?
      @ticket.add_comment(ticket_params[:comment_content], @current_user)
    end

    # do the update with the attributes hash (having removed the comment_content from the hash)
    if @ticket.update(attributes_to_update)
      render json: TicketBlueprint.render(@ticket, view: :normal), status: :ok
    else
      render json: @ticket.errors, status: :unprocessable_entity 
    end
  end

  def open 
    tickets = Ticket.where(is_open: true)
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    render json: TicketBlueprint.render(@ticket, view: :normal), status: :ok
  end

  def tickets_by_status
    tickets = Ticket.where(status_id: params[:id])
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def tickets_by_location
    tickets = Ticket.where(location_id: params[:id])
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def tickets_by_group
    tickets = Ticket.where(group_id: @current_user.groups)
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def tickets_by_category
    tickets = Ticket.where(category_id: params[:id])
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def users_tickets
    tickets = Ticket.where(user_id: @current_user.id)
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def assigned_tickets
    tickets = Ticket.where(assigned_tech_id: @current_user.id)
    render json: TicketBlueprint.render(tickets, view: :normal), status: :ok
  end

  def claim_ticket
    ticket = Ticket.find(params[:id])
    ticket.assigned_tech_id = @current_user.id
    if ticket.save 
      render json: TicketBlueprint.render(ticket, view: :normal), status: :ok
    else 
      render json: ticket.errors, status: :unprocessable_entity
    end
    
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :user_id, :assigned_tech_id, :is_open, :category_id, :location_id, :group_id, :status_id, :comment_content)
    # params.select { |_, v| v.present? }.permit(:title, :description, :user_id, :assigned_tech_id, :is_open, :category_id, :location_id, :group_id, :status_id, :comment_content)
  end

  
end
