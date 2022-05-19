class Event < ApplicationRecord
  belongs_to :user

  validates :address, presence: true
  validates :datetime, presence: true
  validates :title, presence: true, length: { maximum: 255 }
end
