class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string(:city, null: false)
      t.string(:state, default: '')
      t.string(:zip_code, default: '', limit: 5)
      t.string(:country, null: false)
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
