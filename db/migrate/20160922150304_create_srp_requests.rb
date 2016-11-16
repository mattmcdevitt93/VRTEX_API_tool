class CreateSrpRequests < ActiveRecord::Migration
  def change
    create_table :srp_requests do |t|
      t.string :link, null: false
      t.integer :user_id, null: false
      t.string :user_name, null: false
      t.string :ship, null: false
      t.string :user_notes
      t.boolean :insured?
      t.integer :status
      t.integer :payment_id
      t.integer :SRP_amount
      t.string :admin_notes

      t.timestamps null: false
    end
  end
end
