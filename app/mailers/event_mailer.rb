class EventMailer < ApplicationMailer
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  def subscription(event, subscription)
    @email = subscription.user_email
    @event = event
    @name = subscription.user_name

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end
end
