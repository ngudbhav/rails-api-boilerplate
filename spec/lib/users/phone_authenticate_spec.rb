RSpec.describe Users::PhoneAuthenticate do
  let!(:user) { FactoryBot.create(:user, phone_number: '919000000000') }
  describe '#send_otp' do
    it 'should call Otp::Send with the user and phone number' do
      expect_any_instance_of(Otp::Send).to receive(:call)
      user.send_otp(user.phone_number)
    end
  end
  describe '#authenticate_by_phone' do
    let!(:user_verification) { FactoryBot.create(:user_verification, user: user, phone_number: user.phone_number) }

    it 'should call Otp::Verify with the user and otp' do
      expect_any_instance_of(Otp::Verify).to receive(:authenticate).and_return(true)
      expect(user.authenticate_by_phone(user_verification.verification_code)).to eq(user)
    end

    it 'should return false if authentication fails' do
      expect_any_instance_of(Otp::Verify).to receive(:authenticate).and_return(false)
      expect(user.authenticate_by_phone('invalid_otp')).to be_falsey
    end
  end
end
