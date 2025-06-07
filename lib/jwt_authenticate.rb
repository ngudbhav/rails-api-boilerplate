# frozen_string_literal: true

# This class provides methods to encode and decode JWT tokens.
# It uses the Rails application's secret key base for signing the tokens.
# The tokens can be used for user authentication, allowing users to remain logged in for a specified duration.
# The default expiration time is set to 24 hours, but this can be adjusted as needed.
class JwtAuthenticate
  SECRET_KEY= Rails.application.secret_key_base
  # This will logout the user from app after 24 hours.
  # Change this value to keep the user logged in for more time.
  DEFAULT_EXPIRATION = 24.hours

  class << self
    # Encodes a payload into a JWT token with an expiration time.
    # The payload should include user-specific information, such as user_id.
    # The expiration time defaults to 24 hours from the current time.
    #
    # @param payload [Hash] The payload to encode in the JWT token.
    # @param exp [Time] The expiration time for the token. Defaults to 24 hours from now.
    # @return [String] The encoded JWT token.
    def encode(payload, exp = DEFAULT_EXPIRATION.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    # Decodes a JWT token and returns the payload as a hash.
    # If the token is invalid or cannot be decoded, it returns an empty hash.
    # @param token [String] The JWT token to decode.
    # @return [ActiveSupport::HashWithIndifferentAccess] The decoded payload as a hash with indifferent access.
    def decode(token)
      body = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new body
    rescue
      HashWithIndifferentAccess.new
    end
  end
end
