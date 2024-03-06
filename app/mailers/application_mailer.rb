# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@translantics.com'
  layout 'mailer'
end
