RSpec.describe Otp::Send do
  let(:user) { FactoryBot.create(:user, phone_number: '919000000000') }
  let(:phone_number) { user.phone_number }
  let(:send_service) { described_class.new(user, phone_number) }

  describe '#initialize' do
    it 'raises InvalidResourceError if resource does not respond to verifications' do
      expect { described_class.new(Object.new, phone_number) }.to raise_error(Otp::Errors::InvalidResourceError)
    end

    it 'raises InvalidPhoneNumberError if phone number is invalid' do
      expect { described_class.new(user, 'invalid_phone') }.to raise_error(Otp::Errors::InvalidPhoneNumberError)
    end
  end

  describe '#call' do
    it 'creates a user verification record with the correct phone number' do
      expect { send_service.call }.to change { UserVerification.count }.by(1)
      verification = UserVerification.last
      expect(verification).to be_present
      expect(verification.phone_number).to eq(phone_number)
      expect(verification.user).to eq(user)
    end
  end
end
