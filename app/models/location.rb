# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  city       :string(255)      not null
#  code       :string(5)        default("")
#  country    :string(255)      not null
#  is_deleted :boolean          default(FALSE), not null
#  state      :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  include DestroyRecord

  validates :city, :country, length: { minimum: 3 }
  validates :city, uniqueness: true
  validates :city, :country, presence: true
end
