class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_address
      t.string :password_digest
      t.string :phone_number, null: false
      t.datetime :discarded_at

      t.timestamps
      t.index :email_address, unique: true
      t.index :phone_number, unique: true
      t.index :discarded_at
    end
  end
end
