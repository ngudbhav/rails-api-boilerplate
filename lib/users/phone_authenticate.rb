module Users
  module PhoneAuthenticate
    def send_otp(phone_number)
      Otp::Send.new(self, phone_number).call
    end

    def authenticate_by_phone(otp)
      if Otp::Verify.new(self, otp).authenticate
        self
      else
        false
      end
    end
  end
end
