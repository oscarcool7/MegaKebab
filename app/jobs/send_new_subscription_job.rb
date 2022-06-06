class SendNewSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    EventMailer.subscription(subscription).deliver_later
  end
end
