# frozen_string_literal: true

# Responsible for sending emails in the application.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
