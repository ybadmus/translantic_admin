# frozen_string_literal: true

class BaseShipmentService
  def self.perform(...)
    service = new(...)
    service.perform
    # Always return service to allow for method chaining
    service
  end

  private

  def departure
    departure = Location.find_or_create_by!(city: @shipment_params[:departure_attributes][:city])
    departure.update!({ country: @shipment_params[:departure_attributes][:country] }) unless @shipment_params[:departure_attributes][:country].blank?
    departure
  end

  def destination
    destination = Location.find_or_create_by!(city: @shipment_params[:destination_attributes][:city])
    destination.update!({ country: @shipment_params[:destination_attributes][:country] }) unless @shipment_params[:destination_attributes][:country].blank?
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
end
