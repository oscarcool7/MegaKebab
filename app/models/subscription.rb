class Subscription < ApplicationRecord
  VALID_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, presence: true, format: { with: VALID_EMAIL }, unless: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  validates :user_name, presence: true, unless: -> { user.present? }

  validate :unregistered_user_cannot_sign_registered_users, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def unregistered_user_cannot_sign_registered_users
    errors.add(:user_email, :already_in_use) unless User.find_by(email: user_email).nil?
  end
end
