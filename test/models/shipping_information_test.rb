# == Schema Information
#
# Table name: shipping_informations
#
#  id            :bigint           not null, primary key
#  address_line1 :string(255)      not null
#  address_line2 :string(255)
#  company_name  :string(255)
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
require "test_helper"

class ShippingInformationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
