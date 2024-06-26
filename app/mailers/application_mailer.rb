# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@allseasconsortium.com'
  layout 'mailer'
end
