class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tickets
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
