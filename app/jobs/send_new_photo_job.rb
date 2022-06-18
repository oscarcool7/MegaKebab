class SendNewPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo)
    event = photo.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user&.email]).uniq

    all_emails.each do |email|
      EventMailer.photo(photo, email).deliver_later
    end
  end
end
