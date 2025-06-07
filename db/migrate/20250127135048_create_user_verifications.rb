class CreateUserVerifications < ActiveRecord::Migration[8.0]
  def change
    create_table :user_verifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :phone_number, null: false
      t.string :verification_code, null: false
      t.integer :status, null: false, default: UserVerification.statuses[:unverified]
      t.datetime :discarded_at

      t.timestamps
      t.index :discarded_at
    end
  end
end
