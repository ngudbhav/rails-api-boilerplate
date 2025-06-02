module Otp
  class Generate
    OTP_LENGTH = 6

    def self.call
      SecureRandom.random_number(10**OTP_LENGTH).to_s.rjust(OTP_LENGTH, "0")
    end
  end
end
