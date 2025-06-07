RSpec.describe Otp::ExpiryJob, type: :job do
  let(:user_verification) { FactoryBot.create(:user_verification, status: 'unverified') }

  describe '#perform' do
    it 'updates the user verification status to expired' do
      Otp::ExpiryJob.perform_sync(user_verification.id)

      expect(user_verification.reload.discarded?).to be true
    end

    context 'when the user verification is already verified' do
      before do
        user_verification.update!(status: 'verified')
      end

      it 'does not expire if the verification is already verified' do
        expect {
          Otp::ExpiryJob.perform_sync(user_verification.id)
        }.not_to change { user_verification.reload.status }
      end
    end

    it 'raises an error if the user verification does not exist' do
      expect {
        Otp::ExpiryJob.perform_sync(9999)
      }.not_to change { user_verification.reload.status }
    end
  end
end
