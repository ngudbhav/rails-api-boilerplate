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
