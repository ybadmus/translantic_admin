# frozen_string_literal: true

class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :frieght_type, :dimension, :message, :total_gross_weight,
        :incoterm_id, :destination_city, :departure_city, :first_name, :last_name, :email, :phone
end
