class Credentials
  def self.get(key = "")
    new.get(key)
  end

  def get(key = "")
    return "" if key.blank?
    return ENV[key] if ENV.key?(key)

    keys = key.split("_").map(&:downcase!)
    result = credentials
    keys.each do |inner_key|
      result = read_credentials(inner_key, result)
    end

    result
  end

  private

  def read_credentials(key, credentials_hash = @credentials, *args)
    credentials_hash.send(:[], key, *args)
  end

  def credentials
    @credentials ||= Rails.application.credentials
  end
end
