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
#
class ShippingInformation < ApplicationRecord
  include DestroyRecord

  has_one :shipping_detail, dependent: :destroy

  validates :address_line1, presence: true
end
