class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_tech, class_name: 'User', foreign_key: 'assigned_tech_id', optional: true
  belongs_to :category
  belongs_to :location
  belongs_to :group
  belongs_to :status
end
