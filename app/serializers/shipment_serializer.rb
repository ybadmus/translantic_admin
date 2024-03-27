# frozen_string_literal: true

class ShipmentSerializer < ActiveModel::Serializer
  attributes :id, :length, :width, :height, :declared_value, :description, :dutiable, :frieght_type, :status, :tracking_number, :shipper, :receiver, :incoterm, :destination, :departure, :location, :shipping_information, :primary_address, :weight, :quantity, :created_at, :updated_at

  def incoterm
    object.incoterm.as_json
  end

  def status
    object.status&.tr('_', ' ')&.capitalize
  end

  def declared_value
    ActionController::Base.helpers.number_to_currency(object.declared_value, precision: 2)
  end

  def frieght_type
    object.frieght_type.capitalize
  end

  def receiver
    CustomerSerializer.new(object.receiver)
  end

  def shipper
    CustomerSerializer.new(object.shipper)
  end

  def destination
    object.destination.as_json
  end

  def departure
    object.departure.as_json
  end

  def location
    object.location.as_json
  end

  def shipping_information
    object.shipping_information
  end

  def primary_address
    object.shipping_information.address_line1
  end

  def created_at
    object.created_at.strftime('%m/%d/%Y, %T')
  end
end
