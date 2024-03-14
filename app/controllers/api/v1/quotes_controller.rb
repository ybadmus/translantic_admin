# frozen_string_literal: true

module Api
  module V1
    class QuotesController < ApiController
      # POST : /api/v1/{quotes}
      def create
        service = CreateQuoteService.new(params: quote_params)
        service.perform
        @quote = service.quote

        if @quote.save
          QuoteMailer.with(quote: @quote).new_quote.deliver_later
          render_success('success', @quote, QuoteSerializer)
        else
          render_error(@quote.errors.full_messages)
        end
      end

      private

      def quote_params
        params.require(:quote).permit(:frieght_type, :height, :length, :width, :message, :status, :total_gross_weight, :incoterm_id, departure_attributes: %i[city country], destination_attributes: %i[city country], quoter_attributes: %i[name email phone])
      end
    end
  end
end
