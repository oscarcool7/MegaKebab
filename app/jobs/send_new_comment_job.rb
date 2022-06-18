class SendNewCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    event = comment.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [comment.user&.email]).uniq

    all_emails.each do |email|
      EventMailer.comment(comment, email).deliver_later
    end
  end
end
