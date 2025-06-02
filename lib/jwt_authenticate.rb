# frozen_string_literal: true

class JwtAuthenticate
  SECRET_KEY= Rails.application.secret_key_base
  # This will logout the user from app after 24 hours.
  # Change this value to keep the user logged in for more time.
  DEFAULT_EXPIRATION = 24.hours

  class << self
    def encode(payload, exp = DEFAULT_EXPIRATION.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      body = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new body
    rescue
      HashWithIndifferentAccess.new
    end
  end
end
