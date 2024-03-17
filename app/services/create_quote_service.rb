# frozen_string_literal: true

class CreateQuoteService < BaseService
  attr_reader :quote, :errors

  def initialize(params:)
    binding
    @quote_params = params
    @quoter_params = params[:quoter_attributes].presence || { name: params[:name], email: params[:email] }
    @departure_params = params[:departure_attributes].presence || { city: params[:departure] }
    @destination_params = params[:destination_attributes].presence || { city: params[:destination] }
    @errors = []
    @quote = {}
  end

  def perform
    @quote = Quote.new(@quote_params.except(:departure, :destination, :name, :phone, :email))
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
