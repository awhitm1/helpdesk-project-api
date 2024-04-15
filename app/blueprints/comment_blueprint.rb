# frozen_string_literal: true

class CommentBlueprint < Blueprinter::Base
  identifier :id

  fields :content, :created_at
  association :user, blueprint: UserBlueprint, view: :with_comment
end
