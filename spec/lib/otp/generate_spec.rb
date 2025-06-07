RSpec.describe Otp::Generate do
  describe '.call' do
    it 'generates a valid OTP' do
      otp = Otp::Generate.call
      expect(otp).to be_a(String)
      expect(otp.length).to eq(Otp::Generate::OTP_LENGTH)
    end

    it 'generates different OTPs on subsequent calls' do
      otp1 = Otp::Generate.call
      otp2 = Otp::Generate.call
      expect(otp1).not_to eq(otp2)
    end
  end
end
