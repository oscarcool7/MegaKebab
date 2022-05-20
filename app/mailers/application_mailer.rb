class ApplicationMailer < ActionMailer::Base
  default from: "megakebab@heroku.com"
  layout "mailer"
end
