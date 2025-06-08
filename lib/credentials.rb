# frozen_string_literal: true

# This class provides a way to access application credentials in a Rails application.
# It allows for nested keys and also checks environment variables if the key is not found in credentials.
# The keys are expected to be in snake_case format.
class Credentials
  # This method allows you to retrieve a credential by its key.
  # If the key is not found in the credentials, it will return the +default_value+.
  # If the key exists in the environment variables, it will return that value instead.
  #
  # @param key [String] The key to retrieve from credentials or environment variables.
  # @param default_value [String] The value to return if the key is not found in credentials or environment variables.
  # @return [ActiveSupport::EncryptedConfiguration, String] The value associated with the key, or an empty string if not found.
  def self.get(key = "", default_value = "")
    new.get(key, default_value)
  end

  # Instance method to retrieve a credential by its key.
  # If the key is not found in the credentials, it will return an empty string.
  # If the key exists in the environment variables, it will return that value instead.
  # @param key [String] The key to retrieve from credentials or environment variables.
  # @param default_value [String] The value to return if the key is not found in credentials or environment variables.
  # @return [ActiveSupport::EncryptedConfiguration, String] The value associated with the key, or the default value if not found.
  def get(key = "", default_value)
    return "" if key.blank?
    return ENV[key] if ENV.key?(key)

    keys = key.split("_").map(&:downcase)
    result = credentials
    keys.each do |inner_key|
      result = read_credentials(inner_key, result)
    end

    result.presence || default_value
  rescue NoMethodError
    default_value || ""
  end

  private

  def read_credentials(key, credentials_hash = @credentials, *args)
    credentials_hash.send(:[], key, *args)
  end

  def credentials
    @credentials ||= Rails.application.credentials
  end
end
