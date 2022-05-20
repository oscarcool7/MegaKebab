class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  scope :persisted, -> { where "id IS NOT NULL" }
end
