class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string(:type, null: false)
      t.string(:name, null: false)
      t.string(:email, default: '', null: false)
      t.references(:location, null: false)
      t.string(:phone)
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
