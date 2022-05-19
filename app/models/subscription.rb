class Subscription < ApplicationRecord
  VALID_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  belongs_to :event
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validate :current_user_can_subscribe
    validates :user, uniqueness: { scope: :event_id }
  end

  with_options unless: -> { user.present? } do
    validate :unregistered_user_cannot_sign_registered_users
    validates :user_email, presence: true, uniqueness: { scope: :event_id }, format: { with: VALID_EMAIL }
    validates :user_name, presence: true
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def current_user_can_subscribe
    errors.add(:user, :own_event) if event.user == user
  end

  def unregistered_user_cannot_sign_registered_users
    errors.add(:user_email, :already_in_use) if User.exists?(email: user_email)
  end
end
