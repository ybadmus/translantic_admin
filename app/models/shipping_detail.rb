# == Schema Information
#
# Table name: shipping_details
#
#  id                      :bigint           not null, primary key
#  declared_value          :decimal(9, 2)    default(0.0), not null
#  description             :text(65535)      not null
#  dutiable                :boolean          default(FALSE)
#  frieght_type            :integer          default(NULL), not null
#  height                  :decimal(5, 2)    default(0.0), not null
#  is_deleted              :boolean          default(FALSE), not null
#  length                  :decimal(5, 2)    default(0.0), not null
#  quantity                :integer          default(0)
#  status                  :integer          default(NULL), not null
#  tracking_number         :string(14)       default("0000-0000-0000")
#  weight                  :decimal(5, 2)    default(0.0), not null
#  width                   :decimal(5, 2)    default(0.0), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_location_id     :bigint           not null
#  departure_id            :bigint           not null
#  incoterm_id             :bigint           not null
#  shipper_id              :bigint           not null
#  shipping_information_id :bigint           not null
#
# Indexes
#
#  index_shipping_details_on_current_location_id      (current_location_id)
#  index_shipping_details_on_departure_id             (departure_id)
#  index_shipping_details_on_incoterm_id              (incoterm_id)
#  index_shipping_details_on_shipper_id               (shipper_id)
#  index_shipping_details_on_shipping_information_id  (shipping_information_id)
#
# Foreign Keys
#
#  fk_rails_...  (current_location_id => locations.id)
#  fk_rails_...  (departure_id => locations.id)
#  fk_rails_...  (shipper_id => customers.id)
#
class ShippingDetail < ApplicationRecord
  include DestroyRecord

  before_create -> { self.tracking_number = generate_tracking_number }

  enum frieght_type: { air: 1, land: 2, sea: 3, rails: 4 }
  enum status: { submitted: 1, picked_up: 2, no_pick_up: 3, in_transit: 4, delivered: 5, returned: 6 }

  belongs_to :shipper, optional: false
  belongs_to :current_location, class_name: 'Location', optional: false
  belongs_to :incoterm, optional: false
  belongs_to :departure, class_name: 'Location', optional: false
  belongs_to :shipping_information, optional: false

  validates :length, :height, :width, :description, :weight, :quantity, :declared_value, presence: true

  private

  def generate_tracking_number
    loop do
      tracking_number = SecureRandom.random_number(10**12).to_s
      return tracking_number.scan(/.{1,4}/).join('-') unless ShippingDetail.exists?(tracking_number:)
    end
  end
end
