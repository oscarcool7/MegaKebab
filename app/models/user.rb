class User < ApplicationRecord
  VALID_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  has_many :events

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL }
  validates :name, presence: true, length: { maximum: 35 }
end
