# frozen_string_literal: true

class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :email, :phone
end
