# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  city       :string(255)      not null
#  code       :string(5)        default("")
#  country    :string(255)      default("")
#  is_deleted :boolean          default(FALSE), not null
#  state      :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_city  (city) UNIQUE
#
require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
