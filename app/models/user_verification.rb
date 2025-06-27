# == Schema Information
#
# Table name: user_verifications
#
#  id                :bigint           not null, primary key
#  discarded_at      :datetime
#  phone_number      :string(255)      not null
#  status            :integer          default("unverified"), not null
#  verification_code :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_user_verifications_on_discarded_at  (discarded_at)
#  index_user_verifications_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserVerification < ApplicationRecord
  DEFAULT_EXPIRY_LENGTH = 5.minutes

  belongs_to :user

  before_create :set_verification_params
  after_create_commit { Otp::ExpiryJob.set(wait: DEFAULT_EXPIRY_LENGTH).perform_async(id) }

  enum "status", { unverified: 0, verified: 1 }
  default_scope { order(created_at: :desc).where(status: :unverified) }

  private

  def set_verification_params
    self.status = self.class.statuses[:unverified]
    self.verification_code ||= Otp::Generate.call
  end
end
