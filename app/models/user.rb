class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_secure_password
  has_and_belongs_to_many :groups
  has_many :tickets
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'assigned_tech_id'

  attribute :is_tech, :boolean, default: false
  attribute :is_admin, :boolean, default: false
  attribute :active, :boolean, default: true

  # validates :f_name, :l_name, :email, :password, :password_confirmation, presence: true, on: :create
  # validates :email, uniqueness: true, if: :do_validation?

  has_one_attached :profile_image

  def profile_image_url
    rails_blob_url(self.profile_image, only_path: true) if self.profile_image.attached?
  end

  # def do_validation?
  #   new_record? || email_changed?
  # end
end
