# frozen_string_literal: true

class TicketBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :title, :description, :is_open, :user, :assigned_tech, :category, :status, :group, :location, :created_at, :updated_at
    association :comments, blueprint: CommentBlueprint
  end
  
end
