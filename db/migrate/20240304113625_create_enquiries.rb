class CreateEnquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :enquiries do |t|
      t.string(:name, null: false)
      t.string(:email, null: false)
      t.string(:subject, null: false)
      t.text(:message, null: false)
      t.boolean(:is_deleted, default: false, null: false)

      t.timestamps
    end
  end
end
