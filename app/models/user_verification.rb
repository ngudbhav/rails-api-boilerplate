class UserVerification < ApplicationRecord
  DEFAULT_EXPIRY_LENGTH = 5.minutes

  belongs_to :user

  before_create :set_verification_params
  after_create_commit { Otp::ExpiryJob.set(wait: DEFAULT_EXPIRY_LENGTH).perform_async(id) }

  enum "status", { unverified: 0, verified: 1 }
  default_scope { order(created_at: :desc).where(status: :unverified) }

  private

  def set_verification_params
    self.verification_code ||= Otp::Generate.call
    self.status = self.class.statuses[:unverified]
  end
end
