# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  city       :string(255)      not null
#  country    :string(255)      not null
#  state      :string(255)      default("")
#  zip_code   :string(5)        default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
