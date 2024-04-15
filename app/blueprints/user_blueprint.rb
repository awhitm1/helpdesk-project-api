# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :f_name, :l_name, :email, :is_tech, :is_admin, :active, :profile_image_url
    association :groups, blueprint: GroupsBlueprint
  end

  view :with_comment do
    fields :f_name, :l_name, :email, :profile_image_url
  end
end
