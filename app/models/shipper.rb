# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  email      :string(255)      default(""), not null
#  is_deleted :boolean          default(FALSE), not null
#  name       :string(255)      not null
#  phone      :string(255)
#  type       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Shipper < Customer
  has_many :shipping_details, dependent: :nullify
end
