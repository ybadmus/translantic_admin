# frozen_string_literal: true

class CreateShipmentService < BaseShipmentService
  attr_reader :shipment, :errors

  def initialize(params:)
    @shipment_params = params
    @errors = []
    @shipment = {}
  end

  def perform
    @shipment = ShippingDetail.new(@shipment_params)
    @shipment.departure = departure
    @shipment.shipper = shipper
    @shipment.receiver = receiver
    @shipment.destination = destination
    @shipment.location = location
    @shipment.shipping_information = shipping_information

    @shipment.save!
  rescue StandardError => e
    @errors << e.message
    @shipment&.errors&.add(:base, message: e.message)
    {}
  end
end
