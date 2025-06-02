module Otp
  class Verify
    def initialize(resource, otp)
      @resource = resource
      @otp = otp

      raise InvalidResourceError unless @resource.respond_to?(:verifications)
      raise InvalidOtpError unless @otp.present?
    end

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
