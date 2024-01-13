# == Schema Information
#
# Table name: shipping_informations
#
#  id             :bigint           not null, primary key
#  address_line1  :string(255)      not null
#  address_line2  :string(255)
#  company_name   :string(255)
#  is_deleted     :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  destination_id :bigint           not null
#  receiver_id    :bigint           not null
#
# Indexes
#
#  index_shipping_informations_on_destination_id  (destination_id)
#  index_shipping_informations_on_receiver_id     (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => locations.id)
#  fk_rails_...  (receiver_id => customers.id)
#
class ShippingInformation < ApplicationRecord
  include DestroyRecord

  belongs_to :destination, class_name: 'Location', optional: false
  belongs_to :receiver, optional: false
  has_one :shipping_detail, dependent: :destroy

  validates :address_line1, :destination_id, presence: true
end
