class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.integer(:frieght_type, null: false, limit: 1, default: 0)
      t.integer(:status, null: false, limit: 1, default: 0)
      t.references(:departure, null: false, foreign_key: { to_table: 'locations' })
      t.references(:destination, null: false, foreign_key: { to_table: 'locations' })
      t.references(:incoterm, null: false)
      t.references(:quoter, null: false, foreign_key: { to_table: 'customers' })
      t.decimal(:total_gross_weight, null: false, precision: 5, scale: 2, default: 0.0)
      t.decimal(:length, null: false, precision: 5, scale: 2, default: 0.0)
      t.decimal(:width, null: false, precision: 5, scale: 2, default: 0.0)
      t.decimal(:height, null: false, precision: 5, scale: 2, default: 0.0)
      t.text(:message, null: false)
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
