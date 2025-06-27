# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  email_address   :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  phone_number    :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_discarded_at   (discarded_at)
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_phone_number   (phone_number) UNIQUE
#
class User < ApplicationRecord
  include Users::PhoneAuthenticate
  has_secure_password
  has_many_attached :images
  has_many :sessions, dependent: :destroy
  has_many :verifications, class_name: "UserVerification", dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :phone_number, phone: true

  # Remove the password presence validation from the default implementation
  def errors
    super.tap { |errors| errors.delete(:password, :blank) }
  end
end
