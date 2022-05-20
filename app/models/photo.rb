class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  validates :photo, attached: true, content_type: %i[img png jpg jpeg]

  scope :persisted, -> { where "id IS NOT NULL" }
end
