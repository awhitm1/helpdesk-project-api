class Location < ApplicationRecord
  has_many :tickets
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
