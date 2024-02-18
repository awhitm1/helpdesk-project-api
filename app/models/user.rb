class User < ApplicationRecord
  has_and_belongs_to_many :groups
  has_many :tickets
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'assigned_tech_id'
end
