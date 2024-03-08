# frozen_string_literal: true

# == Schema Information
#
# Table name: quotes
#
#  id                 :bigint           not null, primary key
#  frieght_type       :integer          default("air"), not null
#  height             :decimal(5, 2)    default(0.0), not null
#  is_deleted         :boolean          default(FALSE), not null
#  length             :decimal(5, 2)    default(0.0), not null
#  message            :text(65535)      not null
#  status             :integer          default("pending")
#  total_gross_weight :decimal(5, 2)    default(0.0), not null
#  width              :decimal(5, 2)    default(0.0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  departure_id       :bigint           not null
#  destination_id     :bigint           not null
#  incoterm_id        :bigint           not null
#  quoter_id          :bigint           not null
#
# Indexes
#
#  index_quotes_on_departure_id    (departure_id)
#  index_quotes_on_destination_id  (destination_id)
#  index_quotes_on_incoterm_id     (incoterm_id)
#  index_quotes_on_quoter_id       (quoter_id)
#
# Foreign Keys
#
#  fk_rails_...  (departure_id => locations.id)
#  fk_rails_...  (destination_id => locations.id)
#  fk_rails_...  (quoter_id => customers.id)
#
class Quote < ApplicationRecord
  include DestroyRecord
  attr_accessor :departure_city, :destination_city

  audited only: %i[status]

  enum frieght_type: { air: 1, land: 2, sea: 3, rails: 4 }
  enum status: { pending: 1, processing: 2, approved: 3, rejected: 4, expired: 5, cancelled: 6, booked: 7,
                 in_transit: 8, delivered: 9, problem: 10 }

  belongs_to :departure, class_name: 'Location', optional: false
  belongs_to :destination, class_name: 'Location', optional: false
  belongs_to :incoterm
  belongs_to :quoter, optional: false
  accepts_nested_attributes_for :quoter

  validates :frieght_type, :total_gross_weight, :height, :width, :length, :message, presence: true
  validates :total_gross_weight, numericality: { greater_than_or_equal_to: 0 }

  def departure_city
    departure&.city
  end

  def destination_city
    destination&.city
  end
end
