# == Schema Information
#
# Table name: shipping_details
#
#  id                      :bigint           not null, primary key
#  declared_value          :decimal(9, 2)    default(0.0), not null
#  description             :string(500)      not null
#  dutiable                :boolean          default(NULL)
#  frieght_type            :integer          default("air")
#  height                  :decimal(5, 2)    default(0.0), not null
#  is_deleted              :boolean          default(FALSE), not null
#  length                  :decimal(5, 2)    default(0.0), not null
#  quantity                :integer          default(0)
#  status                  :integer          default("submitted")
#  tracking_number         :string(14)       not null
#  weight                  :decimal(5, 2)    default(0.0), not null
#  width                   :decimal(5, 2)    default(0.0), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  departure_id            :bigint           not null
#  destination_id          :bigint           not null
#  incoterm_id             :bigint           not null
#  location_id             :bigint
#  receiver_id             :bigint           not null
#  shipper_id              :bigint           not null
#  shipping_information_id :bigint           not null
#
# Indexes
#
#  index_shipping_details_on_departure_id             (departure_id)
#  index_shipping_details_on_destination_id           (destination_id)
#  index_shipping_details_on_incoterm_id              (incoterm_id)
#  index_shipping_details_on_location_id              (location_id)
#  index_shipping_details_on_receiver_id              (receiver_id)
#  index_shipping_details_on_shipper_id               (shipper_id)
#  index_shipping_details_on_shipping_information_id  (shipping_information_id)
#
# Foreign Keys
#
#  fk_rails_...  (departure_id => locations.id)
#  fk_rails_...  (destination_id => locations.id)
#  fk_rails_...  (receiver_id => customers.id)
#  fk_rails_...  (shipper_id => customers.id)
#
class ShippingDetail < ApplicationRecord
  include DestroyRecord
  attr_accessor :location_city, :destination_city, :destination_country

  audited only: %i[status location_id]

  before_create -> { self.tracking_number = generate_tracking_number! }

  enum frieght_type: { air: 1, land: 2, sea: 3, rails: 4 }
  enum status: { submitted: 1, awaiting_customs_bond_letter: 2, segregated_storage: 3, awaiting_customs_clearance_document: 4,
  complete: 5, arrived_at_our_facility: 6, pending_payment: 7, origin_scan: 8, cleared: 9, delivered: 10, delayed_due_to_payment_not_received: 11,
  delayed_due_to_weather: 12, quickpak_express_shipping_origin: 13, awaiting_clearance_by_customs: 14, at_quickpack_express_shipping_source: 15,
  processing_for_delivery: 16, not_cleared: 17, in_transit: 18, awaiting_shipment_payment: 19, departure_scan: 20, arrival_scan: 21 }
  enum dutiable: { yes: 1, no: 2 }

  belongs_to :shipper, optional: false
  accepts_nested_attributes_for :shipper
  belongs_to :location, optional: false
  belongs_to :incoterm, optional: false
  belongs_to :departure, class_name: 'Location', optional: false
  accepts_nested_attributes_for :departure
  belongs_to :shipping_information, optional: false
  accepts_nested_attributes_for :shipping_information
  belongs_to :destination, class_name: 'Location', optional: false
  belongs_to :receiver, optional: false
  accepts_nested_attributes_for :receiver

  validates :length, :height, :width, :description, :weight, :quantity, :declared_value, presence: true
  validate :same_departure_destination?

  def location_city
    location&.city
  end

  def destination_city
    destination&.city
  end

  def destination_country
    destination&.country
  end

  private

  def same_departure_destination?
    errors.add(:base, :destination_and_departure_cities_must_different, message: "Departure and destination cities cannot must be different") if departure == destination
  end

  def generate_tracking_number!
    return if tracking_number.present?

    loop do
      tracking_number = SecureRandom.random_number(10**12).to_s
      return tracking_number.scan(/.{1,4}/).join('-') unless ShippingDetail.exists?(tracking_number:)
    end
  end
end
