class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.references :user, null: false, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.text :data
      t.datetime :discarded_at

      t.timestamps
      t.index :session_id, unique: true
      t.index :discarded_at
    end
  end
end
