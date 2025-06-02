module Otp
  module Errors
    class OtpError < StandardError; end
    class InvalidOtpError < OtpError
      def initialize(msg = "OTP must be a valid")
        super
      end
    end
    class InvalidResourceError < OtpError
      def initialize(msg = "Resource must have `verifications` entity")
        super
      end
    end
    class InvalidPhoneNumberError < OtpError
      def initialize(msg = "Phone number must be a valid")
        super
      end
    end
  end
end
