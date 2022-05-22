class EventMailer < ApplicationMailer
  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: default_i18n_subject(event: @event.title)
  end

  def photo(photo, email)
    @photo = photo
    @event = photo.event

    mail to: email, subject: default_i18n_subject(event: @event.title)
  end

  def subscription(subscription)
    @email = subscription.user_email
    @event = subscription.event
    @name = subscription.user_name

    mail to: @event.user.email, subject: default_i18n_subject(event: @event.title)
  end
end
