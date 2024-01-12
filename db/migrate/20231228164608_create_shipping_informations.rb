class CreateShippingInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_informations do |t|
      t.references(:receiver, null: false, foreign_key: { to_table: 'customers' })
      t.string(:company_name)
      t.string(:address_line1, null: false)
      t.string(:address_line2)
      t.references(:destination, null: false, foreign_key: { to_table: 'locations' })
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
