class ShipmentSerializer < ActiveModel::Serializer
  attributes :id, :length, :width, :height, :declared_value, :description, :dutiable, :frieght_type, :status, :tracking_number, :shipper, :receiver, :incoterm, :destination, :departure, :location, :shipping_information, :primary_address

  def incoterm
    object.incoterm.as_json
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
end
