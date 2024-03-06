class EnquiryMailer < ApplicationMailer
  default from: 'admin@translantics.com'

  def admin_email
    mail(to: rams[:email], subject: 'A potential customer sent an email')
  end
end
