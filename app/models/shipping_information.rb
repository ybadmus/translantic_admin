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
#  location_id   :bigint           not null
#  receiver_id   :bigint           not null
#
# Indexes
#
#  index_shipping_informations_on_location_id  (location_id)
#  index_shipping_informations_on_receiver_id  (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => customers.id)
#
class ShippingInformation < ApplicationRecord
  include DestroyRecord

  validates :receiver_id, :address_line1, :location_id, presence: true

  belongs_to :location
  belongs_to :receiver, class_name: 'Customer', optional: false
end
