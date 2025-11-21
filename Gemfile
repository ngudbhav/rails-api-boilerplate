source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# Use trilogy as the database for Active Record
gem "trilogy"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JWT for authentication
gem "jwt"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Use Active record session store to store sessions in the database
gem "activerecord-session_store", "~> 2.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sidekiq for background processing
gem "sidekiq"

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

# Use Redis for caching [https://redis.io/]
gem "redis"

# Use rubocop for static analysis
gem "rubocop", require: false

# Use discard for soft deletes
gem "discard"

# Use phonelib for phone number validation
gem "phonelib"

# Use Sentry for error tracking
gem "sentry-ruby"
gem "sentry-rails"

# Use strong_migrations to prevent dangerous migrations
gem "strong_migrations", "~> 2.5"

# Use ransack for advanced search functionality
gem "ransack"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Use Annotate to add schema information to models
  gem "annotaterb"

  # Use yard for generating documentation
  gem "yard"
end

group :test do
  # Use RSpec for testing
  gem "rspec-rails"

  # Use Factory Bot for testing
  gem "factory_bot_rails"

  # Use Faker for generating fake data in tests
  gem "faker"

  # Use SimpleCov for code coverage analysis
  gem "simplecov"

  # Use SimpleCov JSON formatter for generating JSON coverage reports
  gem "simplecov-json"

  # Use RSpec Sidekiq for testing Sidekiq jobs
  gem "rspec-sidekiq"
end

gem "aws-sdk-s3", "~> 1.205"
