# frozen_string_literal: true

class UpdateShipmentService < BaseService
  attr_reader :errors, :shipment

  def initialize(shipment:, params:)
    @shipment = shipment
    @shipment_params = params
    @departure_params = params[:departure_attributes]
    @destination_params = params[:destination_attributes]
    @errors = []
  end

  def perform
    @shipment.departure = departure
    @shipment.shipper = shipper
    @shipment.receiver = receiver
    @shipment.destination = destination
    @shipment.location = location
    @shipment.shipping_information = shipping_information

    @shipment.assign_attributes(@shipment_params.except(:departure_attributes, :destination_attributes, :shipper_attributes, :receiver_attributes, :shipping_information_attributes, :location_attributes))

    @shipment.location_id_will_change! if @shipment.status_changed?
    @shipment.status_will_change! if @shipment.location_id_changed?

    @shipment.save!
  rescue StandardError => e
    @errors << e.message
    @shipment&.errors&.add(:base, message: e.message)
    false
  end
end
