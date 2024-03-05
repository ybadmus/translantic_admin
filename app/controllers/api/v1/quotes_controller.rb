# frozen_string_literal: true

module Api
  module V1
    class QuotesController < ApiController
      # POST : /api/v1/{quotes}
      def create
        dimension = quote_params[:dimension].split(',').map(&:to_i)
        quote_params.merge(length: dimension[0], width: dimension[1], height: dimension[2])
        quote = Quote.new(quote_params.except(:dimension, :destination, :departure))
        quote.quoter = Quoter.find_or_create_by(name: quoter_params[:name], email: quoter_params[:email],
                                                phone: quoter_params[:phone])
        quote.departure = Location.find_or_create_by(city: quote_params[:departure])
        quote.destination = Location.find_or_create_by(city: quote_params[:destination])

        if quote.save
          # Send email to admin about new quote received
          # QuoteMailer
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
