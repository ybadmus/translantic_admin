# frozen_string_literal: true

class EnquiryMailer < ApplicationMailer
  default from: 'admin@translantics.com'

  def admin_email
    @enquiry = params[:enquiry]
    mail(to: params[:email], subject: 'A potential customer sent an email')
  end
end
