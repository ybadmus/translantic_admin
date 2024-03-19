# frozen_string_literal: true

module Api
  module V1
    class ShipmentsController < ApiController
      include WickedPdf::PdfHelper

      before_action :set_shipment, only: %i[verify send_pdf preview_pdf]
      before_action :authorize_user!, only: %i[verify send_pdf]

      # GET : /api/v1/shipments
      def show
        shipment = ShippingDetail.includes(:departure, :destination, :incoterm, :location, :receiver, :shipper,
                                           :shipping_information).find(params[:id])
        render_success('success', shipment, ShipmentSerializer)
      end

      # POST : /api/v1/shipments/verify
      def verify
        render_success('success', @shipment, ShipmentSerializer)
      end

      # GET : /api/v1/shipments/send_pdf
      def send_pdf
        missing_params!(:email, :order_number)

        ShipmentMailer.with(shipment: @shipment).new_shipment.deliver_now
        render_success("Order pdf successfully sent to #{params[:email]}")
      end

      # GET : /api/v1/shipments/preview_pdf
      def preview_pdf
        render(template: 'shipments/pdf', pdf: 'shipment', page_size: 'A4', margin: { bottom: 22 }, footer: { html: { template: 'pdf_document_footer' } })
      end

      private

      def set_shipment
        return render_bad_request('The tracking number submitted is not valid, please check the number and try again') unless valid_tracking_number?

        @shipment = ShippingDetail.includes(:departure, :destination, :incoterm, :location, :receiver, :shipper,
                                            :shipping_information).find_by!(tracking_number: params[:order_number])
      end

      def either_recipient_or_sender?
        params[:email].strip.casecmp?(@shipment.shipper.email.strip) || params[:email].strip.casecmp?(@shipment.receiver.email.strip)
      end

      def authorize_user!
        return if either_recipient_or_sender?

        render_unauthorized('The email submitted does not match the email associated with this shipment')
      end

      def valid_tracking_number?
        if params[:order_number].count('-').zero? && params[:order_number].length == 12
          params[:order_number] = params[:order_number].scan(/.{1,4}/).join('-')
          return true
        end

        params[:order_number].count('-') == 2 && params[:order_number].length == 14
      end
    end
  end
end
