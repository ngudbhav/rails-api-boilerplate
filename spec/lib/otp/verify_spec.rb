RSpec.describe Otp::Verify do
  let(:user) { FactoryBot.create(:user, phone_number: '919000000000') }
  let(:verification_code) { '123456' }
  let!(:user_verification) { FactoryBot.create(:user_verification, user: user, verification_code: verification_code) }
  let(:verify_service) { described_class.new(user, verification_code) }

  describe '#initialize' do
    it 'raises InvalidResourceError if resource does not respond to verifications' do
      expect { described_class.new(Object.new, verification_code) }.to raise_error(Otp::Errors::InvalidResourceError)
    end

    it 'raises InvalidPhoneNumberError if phone number is invalid' do
      expect { described_class.new(user, nil) }.to raise_error(Otp::Errors::InvalidOtpError)
    end
  end

  describe '#authenticate' do
    it 'returns true for valid OTP' do
      expect(verify_service.authenticate).to be_truthy
    end

    it 'returns false for incorrect OTP' do
      invalid_service = described_class.new(user, 'wrong_otp')
      expect(invalid_service.authenticate).to be_falsey
    end

    it 'returns false if verification record is expired' do
      user_verification.update(created_at: UserVerification::DEFAULT_EXPIRY_LENGTH.ago - 1.minute)
      expect(verify_service.authenticate).to be_falsey
    end

    it 'returns false if the record is not present' do
      allow(user).to receive(:verifications).and_return(UserVerification.none)
      expect(verify_service.authenticate).to be_falsey
    end
  end
end
