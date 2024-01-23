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
require "test_helper"

class ShippingInformationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
