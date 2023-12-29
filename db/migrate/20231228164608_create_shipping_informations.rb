class CreateShippingInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_informations do |t|
      t.references(:customer, null: false)
      t.string(:company_name)
      t.string(:address_line1, null: false)
      t.string(:address_line2)
      t.references(:location, null: false)

      t.timestamps
    end
  end
end
