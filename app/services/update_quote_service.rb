# frozen_string_literal: true

class UpdateQuoteService < BaseService
  attr_reader :quote, :errors

  def initialize(quote:, params:)
    @quote_params = params
    @quoter_params = params[:quoter_attributes]
    @departure_params = params[:departure_attributes]
    @destination_params = params[:destination_attributes]
    @errors = []
    @quote = quote
  end

  def perform
    @quote.departure = departure
    @quote.destination = destination
    @quote.quoter = quoter

    @quote.assign_attributes(@quote_params.except(:departure_attributes, :destination_attributes, :quoter_attributes))

    @quote.save!
  rescue StandardError => e
    @errors << e.message
    @quote&.errors&.add(:base, message: e.message)
    {}
  end
end
