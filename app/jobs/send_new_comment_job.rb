class SendNewCommentJob < ApplicationJob
  queue_as :default

  def perform(comment, email)
    EventMailer.comment(comment, email).deliver_later
  end
end
