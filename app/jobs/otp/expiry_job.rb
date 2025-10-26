module Otp
  class ExpiryJob < AbstractJob
    queue_as "default"

    def perform(verification_id)
      verification = UserVerification.find_by(id: verification_id)

      verification&.discard!
    end
  end
end
