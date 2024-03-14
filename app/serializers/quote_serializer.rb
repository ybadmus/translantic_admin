# frozen_string_literal: true

# == Schema Information
#
# Table name: quotes
#
#  id                 :bigint           not null, primary key
#  frieght_type       :integer          default(NULL), not null
#  height             :decimal(5, 2)    not null
#  is_deleted         :boolean          default(FALSE), not null
#  length             :decimal(5, 2)    not null
#  message            :text(65535)      not null
#  status             :integer          default(NULL)
#  total_gross_weight :decimal(5, 2)    not null
#  width              :decimal(5, 2)    not null
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
class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :frieght_type, :length, :height, :width, :message, :total_gross_weight,
             :incoterm_id, :destination, :departure, :name, :email, :phone

  def name
    object.quoter.name
  end

  def email
    object.quoter.email
  end

  def phone
    object.quoter.phone
  end

  def destination
    object.destination.city
  end

  def departure
    object.departure.city
  end
end
