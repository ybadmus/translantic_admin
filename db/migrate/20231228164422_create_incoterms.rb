class CreateIncoterms < ActiveRecord::Migration[7.0]
  def change
    create_table :incoterms do |t|
      t.string(:abbr, null: false, limit: 3)
      t.string(:description, null: false)
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
