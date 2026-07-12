# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  email_address   :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  phone_number    :string(255)
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
  include Users::EmailAuthenticate

  has_secure_password validations: false
  has_many_attached :images
  has_many :sessions, dependent: :destroy
  has_many :verifications, class_name: "UserVerification", dependent: :destroy

  # generates_token_with :password_reset, expires_in: 15.minutes

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :phone_number, phone: true, allow_blank: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, allow_blank: true
  validates :password, length: { minimum: 12 }, allow_blank: true
  validates :password, presence: true, on: :create, if: :email_only_user?

  validate :phone_or_email_present

  private

  def phone_or_email_present
    errors.add(:base, "Phone number or email address is required") if phone_number.blank? && email_address.blank?
  end

  def email_only_user?
    email_address.present? && phone_number.blank?
  end
end
