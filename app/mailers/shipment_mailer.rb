# frozen_string_literal: true

class ShipmentMailer < ApplicationMailer
  default to: [@shipment.receiver.email, @shipment.shipper.email], from: 'collection@translantics.com'

  def new_shipment
    @shipment = params[:shipment]
    attachments["Order_#{@shipment.tracking_number}.pdf"] = shipment_pdf
    mail(subject: 'Your order has been received!')
  end

  private

  def shipment_pdf
    render_to_string(
      template: 'shipments/pdf',
      pdf: 'invoice',
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
