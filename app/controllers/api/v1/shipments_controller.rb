# frozen_string_literal: true

module Api
  module V1
    class ShipmentsController < ApiController
      before_action :set_shipment, only: %i[verify send_pdf]
      before_action :authorize_verify!, only: [:verify]

      # GET : /api/v1/shipments
      def show
        shipment = ShippingDetail.find_by!(params[:id])
        render_success('success', shipment, ShipmentSerializer)
      end

      # GET : /api/v1/shipments/verify
      def verify
        render_success('success', @shipment, ShipmentSerializer)
      end

      def send_pdf_email
        missing_params!(:email, :order_number)

      end

      private

      def set_shipment
        @shipment = ShippingDetail.find_by!(tracking_number: params[:order_number])
      end

      def same_email_associate?
        params[:email].strip == @shipment.shipper.email.strip || params[:email].strip == @shipment.receiver.email.strip
      end

      def authorize_verify!
        return if same_email_associate?

        render_unauthorized('The email you submitted does not match the emails associated with the order')
      end
    end
  end
end
