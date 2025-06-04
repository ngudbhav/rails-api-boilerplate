module Otp
  # This class provides functionality to generate a One-Time Password (OTP).
  # It generates a random numeric string of a specified length, which defaults to 6 digits.
  class Generate
    OTP_LENGTH = 6

    # Generates a random OTP of the specified length.
    # @return [String] A string representing the generated OTP, padded with leading zeros if necessary.
    def self.call
      SecureRandom.random_number(10**OTP_LENGTH).to_s.rjust(OTP_LENGTH, "0")
    end
  end
end
