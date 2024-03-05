class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :email, :phone
end
