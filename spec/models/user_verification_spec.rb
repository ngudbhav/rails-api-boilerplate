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
