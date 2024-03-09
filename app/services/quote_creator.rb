# frozen_string_literal: true

class QuoteCreator < ApplicationService
  attr_reader :quote, :errors

  def initialize(quote_params:, quoter_params:)
    @quote_params = quote_params
    @quoter_params = quoter_params
    @quote = Quote.new(@quote_params.except(:dimension, :destination, :departure))
  end

  def perform
    dimension = @quote_params[:dimension].split(',').map(&:to_i)
    @quote_params.merge(length: dimension[0], width: dimension[1], height: dimension[2])
    create_quoter
    create_locations
    @quote
  end

  private

  def create_quoter
    @quote.quoter = Quoter.find_or_create_by(name: @quoter_params[:name], email: @quoter_params[:email],
                                             phone: @quoter_params[:phone])
  end

  def create_locations
    @quote.departure = Location.find_or_create_by(city: @quote_params[:departure])
    @quote.destination = Location.find_or_create_by(city: @quote_params[:destination])
  end
end
