module Otp
  # This module provides functionality to verify the One-Time Password (OTP).
  # It initializes with a resource (which should respond to `verifications`) and an OTP.
  # It raises errors if the resource is invalid or the OTP is not present.
  # It provides an `authenticate` method to verify the OTP against the stored verification record.
  # It checks if the verification record exists, if it is not expired, and if the OTP matches.
  # If the OTP is valid, it marks the verification as verified and returns true; otherwise, it returns false.
  class Verify
    def initialize(resource, otp)
      @resource = resource
      @otp = otp

      raise Otp::Errors::InvalidResourceError unless @resource.respond_to?(:verifications)
      raise Otp::Errors::InvalidOtpError unless @otp.present?
    end

    # This method attempts to authenticate the user by verifying the provided OTP.
    # It checks if the verification record exists, if it is not expired, and if the OTP matches.
    # If the OTP is valid, it marks the verification as verified and returns true; otherwise, it returns false.
    # @return [Boolean] Returns true if the OTP is valid and the verification is successful, otherwise returns false.
    def authenticate
      @verification = @resource.verifications.first
      verify_code ? verify! : false
    end

    private

    def verify_code
      return false unless @verification.present?
      return false unless @verification.created_at > UserVerification::DEFAULT_EXPIRY_LENGTH.ago

      @verification.verification_code == @otp
    end

    def verify!
      @verification.verified!

      true
    end
  end
end
