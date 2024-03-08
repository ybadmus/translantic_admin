# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def set_locations
    @departure_id = Location.find_or_create_by(city: quote_params[:departure_city]).id
    @destination_id = Location.find_or_create_by(city: quote_params[:destination_city]).id
  end
end
