class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
    omniauth_providers: %i[facebook vkontakte]

  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

  validates :avatar, content_type: %i[img png jpg jpeg]
  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  def self.find_for_oauth(access_token)
    email = access_token.info.email.downcase
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id

    case provider
    when "facebook"
      url = "https://facebook.com/#{id}"
    when "vkontakte"
      url = access_token.info.urls[:Vkontakte]
    end

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = access_token.info.name
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def set_name
    self.name = "Пользователь №#{rand(1000)}" if self.name.blank?
  end
end
