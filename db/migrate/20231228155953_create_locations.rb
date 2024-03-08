# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string(:city, null: false)
      t.string(:state, default: '')
      t.string(:code, default: '', limit: 5)
      t.string(:country, null: true, default: '')
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end

    add_index(:locations, :city, unique: true)
  end
end
