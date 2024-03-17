# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  association :groups
  view :normal do
    fields :f_name, :l_name, :email, :is_tech, :is_admin, :active
    association :groups
  end
end
