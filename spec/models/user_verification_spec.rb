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
RSpec.describe UserVerification, type: :model do
  describe '#set_verification_params' do
    context "While creating a user verification" do
      let(:user_verification) { FactoryBot.build(:user_verification) }
      it 'sets the verification code' do
        user_verification.save!

        expect(user_verification.verification_code).to be_present
        expect(user_verification.status).to eq('unverified')
        expect(Otp::ExpiryJob).to have_enqueued_sidekiq_job(user_verification.id)
      end
    end
  end
end
