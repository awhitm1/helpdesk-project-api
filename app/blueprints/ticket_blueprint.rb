# frozen_string_literal: true

class TicketBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :title, :description, :is_open, :user_id, :assigned_tech_id, :category_id, :status_id, :group_id, :location_id, :created_at, :updated_at
    association :comments, blueprint: CommentBlueprint
  end
  
end
