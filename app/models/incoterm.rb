# frozen_string_literal: true

# == Schema Information
#
# Table name: incoterms
#
#  id          :bigint           not null, primary key
#  abbr        :string(3)        not null
#  description :string(255)      not null
#  is_deleted  :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Incoterm < ApplicationRecord
  include DestroyRecord

  validates :abbr, :description, presence: true
end
