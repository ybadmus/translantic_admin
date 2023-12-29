# == Schema Information
#
# Table name: shipping_informations
#
#  id            :bigint           not null, primary key
#  address_line1 :string(255)      not null
#  address_line2 :string(255)
#  company_name  :string(255)
#  is_deleted    :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  customer_id   :bigint           not null
#  location_id   :bigint           not null
#
# Indexes
#
#  index_shipping_informations_on_customer_id  (customer_id)
#  index_shipping_informations_on_location_id  (location_id)
#
class ShippingInformation < ApplicationRecord
  include DestroyRecord

  validates :customer_id, :address_line1, :location, presence: true

  belongs_to :customer
  belongs_to :location
end
