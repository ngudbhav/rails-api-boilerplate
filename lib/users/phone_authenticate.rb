module Users
  # This module provides methods for sending and verifying OTPs (One-Time Passwords) via phone numbers.
  # It includes methods to send an OTP to a user's phone number and to authenticate the user by verifying the OTP.
  module PhoneAuthenticate
    # This method sends an OTP to the specified phone number.
    # @param phone_number [String] The phone number to which the OTP will be sent.
    # It uses the Otp::Send service to handle the OTP sending process.
    # @return [UserVerification] Returns the user verification record if the OTP is sent successfully.
    def send_otp(phone_number)
      Otp::Send.new(self, phone_number).call
    end

    # This method authenticates the user by verifying the provided OTP.
    # @param otp [String] The one-time password to verify.
    # It uses the Otp::Verify service to check if the OTP is valid.
    # @return [User, false] Returns the user if authentication is successful, otherwise returns false.
    def authenticate_by_phone(otp)
      if Otp::Verify.new(self, otp).authenticate
        # @type [User]
        self
      else
        false
      end
    end
  end
end
