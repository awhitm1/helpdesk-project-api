# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :f_name, :l_name, :email, :is_tech, :is_admin, :active
    association :groups, blueprint: GroupsBlueprint
  end
end
