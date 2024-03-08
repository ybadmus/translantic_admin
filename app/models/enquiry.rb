# frozen_string_literal: true

# == Schema Information
#
# Table name: enquiries
#
#  id         :bigint           not null, primary key
#  email      :string(255)      not null
#  is_deleted :boolean          default(FALSE), not null
#  message    :text(65535)      not null
#  name       :string(255)      not null
#  subject    :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enquiry < ApplicationRecord
  include DestroyRecord

  validates :name, :email, :message, presence: true
end
