# frozen_string_literal: true

class CreateShippingDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_details do |t|
      t.integer(:frieght_type, default: 0, limit: 1)
      t.decimal(:length, null: false, precision: 5, scale: 2)
      t.decimal(:height, null: false, precision: 5, scale: 2)
      t.decimal(:width, null: false, precision: 5, scale: 2)
      t.integer(:status, limit: 1, default: 1)
      t.string(:tracking_number, limit: 14, null: false)
      t.string(:description, limit: 500, null: false)
      t.boolean(:dutiable, default: false)
      t.decimal(:weight, null: false, precision: 5, scale: 2)
      t.integer(:quantity, default: 1)
      t.references(:location)
      t.references(:shipper, null: false, foreign_key: { to_table: 'customers' })
      t.references(:receiver, null: false, foreign_key: { to_table: 'customers' })
      t.references(:incoterm, null: false)
      t.references(:departure, null: false, foreign_key: { to_table: 'locations' })
      t.references(:destination, null: false, foreign_key: { to_table: 'locations' })
      t.references(:shipping_information, null: false)
      t.decimal(:declared_value, null: false, precision: 10, scale: 2)
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
