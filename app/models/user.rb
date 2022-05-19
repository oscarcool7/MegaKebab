class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
end
