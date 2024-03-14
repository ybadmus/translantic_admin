# frozen_string_literal: true

class BaseService
  def self.perform(...)
    service = new(...)
    service.perform
    # Always return service to allow for method chaining
    service
  end

  private

  def departure
    departure = Location.find_or_create_by!(city: @departure_params[:city])
    departure.update!({ country: @departure_params[:country] }) unless @departure_params[:country].blank?
    departure
  end

  def destination
    destination = Location.find_or_create_by!(city: @destination_params[:city])
    destination.update!({ country: @destination_params[:country] }) unless @destination_params[:country].blank?
    destination
  end

  def location
    location = Location.find_or_create_by!(city: @shipment_params[:location_attributes][:city])
    location.update!({ country: @shipment_params[:location_country] }) unless @shipment_params[:location_attributes][:country].blank?
    location
  end

  def shipper
    shipper = Shipper.find_or_create_by!(name: @shipment_params[:shipper_attributes][:name], email: @shipment_params[:shipper_attributes][:email])
    shipper.update!({ phone: @shipment_params[:shipper_attributes][:phone] }) unless @shipment_params[:shipper_attributes][:phone].blank?
    shipper
  end

  def receiver
    receiver = Receiver.find_or_create_by!(name: @shipment_params[:receiver_attributes][:name], email: @shipment_params[:receiver_attributes][:email])
    receiver.update!({ phone: @shipment_params[:receiver_attributes][:phone] }) unless @shipment_params[:receiver_attributes][:phone].blank?
    receiver
  end

  def shipping_information
    shipping_information = ShippingInformation.find_or_create_by!(address_line1: @shipment_params[:shipping_information_attributes][:address_line1])
    shipping_information.update!({ company_name: @shipment_params[:shipping_information_attributes][:company_name] }) unless @shipment_params[:shipping_information_attributes][:company_name].blank?
    shipping_information
  end

  def quoter
    quoter = Quoter.find_or_create_by(name: @quoter_params[:name], email: @quoter_params[:email])
    quoter.update!({ phone: @quoter_params[:phone] }) unless @quoter_params[:phone].blank?
    quoter
  end
end
