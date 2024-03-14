# frozen_string_literal: true

class CreateQuoteService < BaseService
  attr_reader :quote, :errors

  def initialize(params:)
    @quote_params = params
    @quoter_params = params[:quoter_attributes]
    @departure_params = params[:departure_attributes]
    @destination_params = params[:destination_attributes]
    @errors = []
    @quote = {}
  end

  def perform
    @quote = Quote.new(@quote_params)
    @quote.departure = departure
    @quote.destination = destination
    @quote.quoter = quoter

    @quote.save!
  rescue StandardError => e
    @errors << e.message
    @quote&.errors&.add(:base, message: e.message)
    {}
  end
end
