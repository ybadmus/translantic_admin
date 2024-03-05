# frozen_string_literal: true

module Api
  module V1
    class EnquiriesController < ApiController
      # POST : /api/v1/{enquiries}
      def create
        enquiry = Enquiry.new(enquiry_params)
        if enquiry.save
          # Send email to admin about new enquiry received
          # EnquiryMailer
          render_success('success', enquiry, EnquirySerializer)
        else
          render_error(enquiry.errors.full_messages)
        end
      end

      private

      def enquiry_params
        params.require(:enquiry).permit(:name, :email, :subject, :message)

      end
    end
  end
end
