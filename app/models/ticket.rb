class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_tech, class_name: 'User', foreign_key: 'assigned_tech_id', optional: true
  belongs_to :category
  belongs_to :location
  belongs_to :group
  belongs_to :status

  validates :title :description :is_open :user_id :category_id :group_id :location_id :status_id, presence: true
  validates :assigned_tech_must_be_tech

  private

  def assigned_tech_must_be_tech
    if assigned_tech_id.present? && !User.find(assigned_tech_id).is_tech
      errors.add(:assigned_tech_id, 'must be a technician')
    end
  end
end
