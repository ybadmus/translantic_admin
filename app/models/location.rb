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
class Location < ApplicationRecord
  include DestroyRecord

  has_many :destinations, class_name: 'ShippingDetail', foreign_key: 'destination_id', dependent: :nullify
  has_many :departures, class_name: 'ShippingDetail', foreign_key: 'departure_id', dependent: :nullify

  validates :city, :country, length: { minimum: 3 }, allow_blank: true
  validates :city, uniqueness: true
  validates :city, presence: true
end
