# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = Credentials.get("SENTRY_DSN")
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]
end
