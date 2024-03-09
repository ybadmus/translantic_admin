# frozen_string_literal: true

module Api
  module V1
    class QuotesController < ApiController
      # POST : /api/v1/{quotes}
      def create
        service = ::QuoteCreator.new(quote_params:, quoter_params:)
        quote = service.perform
        if quote.save
          QuoteMailer.with(quote:).new_quote.deliver_later
          render_success('success', quote, QuoteSerializer)
        else
          render_error(quote.errors.full_messages)
        end
      end

      private

      def quote_params
        params.require(:quote).permit(:frieght_type, :dimension, :message, :total_gross_weight,
                                      :incoterm_id, :destination, :departure)
      end

      def quoter_params
        params.require(:quote).permit(:name, :email, :phone)
      end
    end
  end
end
