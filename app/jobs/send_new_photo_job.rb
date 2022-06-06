class SendNewPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo, email)
    EventMailer.photo(photo, email).deliver_later
  end
end
