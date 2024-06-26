# frozen_string_literal: true

class QuoteMailer < ApplicationMailer
  default from: 'admin@allseasconsortium.com'

  def new_quote
    @quote = params[:quote]
    attachments["Quote_#{@quote.id}.pdf"] = quote_pdf
    mail(to: @quote.quoter.email, subject: "Your quote(#{@quote.total_gross_weight} Kg) has been received")
  end

  def admin_email
    @quote = params[:quote]
    attachments["Quote_#{@quote.id}.pdf"] = quote_pdf
    mail(to: @quote.quoter.email, subject: 'A new quote has been received')
  end

  private

  def quote_pdf
    render_to_string(
      template: 'quotes/pdf',
      pdf: 'quote',
      page_size: 'A4',
      margin: { bottom: 22 },
      footer: {
        html: {
          template: 'pdf_document_footer'
        }
      }
    )
  end
end
