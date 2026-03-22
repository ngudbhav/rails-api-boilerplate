# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Setup
bin/setup                    # Install deps, prepare DB, start server
bin/setup --reset            # Setup with DB reset
bin/setup --skip-server      # Setup without starting server

# Development
bin/dev                      # Start development server

# Testing
bundle exec rspec            # Run all tests
bundle exec rspec spec/path/to/file_spec.rb  # Run single spec file
bundle exec rspec spec/path/to/file_spec.rb:42  # Run single example

# Linting & Security
bin/rubocop                  # Lint with RuboCop (Omakase Rails style)
bin/brakeman --no-pager      # Security vulnerability scan

# CI (runs lint + security + tests + seeds locally)
bin/ci

# Database
bin/rails db:prepare         # Create and migrate
bin/rails db:reset           # Reset database
RAILS_ENV=test bin/rails db:seed:replant  # Reseed test DB

# Documentation
bundle exec yard doc         # Generate YARD docs
```

## Architecture

**Stack**: Rails 8.1 API-only, Ruby 4.0, MySQL (Trilogy adapter), Redis, Sidekiq, Puma + Thruster

### Authentication Flow
JWT + OTP phone-based authentication:
1. Client POSTs phone number → OTP created in `UserVerification`, `Otp::ExpiryJob` scheduled for cleanup after 5 min
2. Client POSTs phone + OTP → `Session` created, JWT token returned (24h expiry)
3. Subsequent requests: `Authorization: Bearer <token>` header → decoded by `Authentication` concern

Key files: `lib/jwt_authenticate.rb`, `lib/otp/`, `lib/users/phone_authenticate.rb`, `app/controllers/concerns/authentication.rb`

Use `allow_unauthenticated_access` in controllers to skip auth for specific actions.

### Request/Response Pattern
- `app/controllers/concerns/response.rb` provides `ok`, `bad_request`, `unauthorized` helpers
- Global rescue handlers in `ApplicationController` for `RecordNotFound`, `RecordInvalid`, `ParameterMissing`
- `Current` (ActiveSupport::CurrentAttributes) holds thread-safe request context (current session/user)

### Custom Libraries (`lib/`)
- `lib/jwt_authenticate.rb` — JWT encode/decode
- `lib/otp/` — OTP generation, sending, verification
- `lib/users/phone_authenticate.rb` — Mixed into User model

### Background Jobs
Sidekiq with Redis. Base class: `AbstractJob` (retry: 5). Queues: `default`, `mailers`. Sidekiq Web UI mounted at `/sidekiq`.

### Database
Multi-database configuration: primary, cache, queue, cable — each a separate MySQL database in production. Uses Trilogy adapter (high-performance MySQL driver). Strong Migrations enforces safe migration practices (10s lock timeout).

### Models
- `User` — phone auth, `has_secure_password`, `has_many_attached :images`, soft-deletable via Discard
- `Session` — tracks user_agent + IP, soft-deletable
- `UserVerification` — OTP records with 5-minute expiry

### Storage
Active Storage for file uploads. Local disk in development, S3 in production. Image variants processed with libvips.

### Rate Limiting
Sessions and user creation endpoints: 10 requests per 3 minutes (returns 429).

## Testing

- RSpec with FactoryBot + Faker
- SimpleCov enforces: 85% suite coverage, 50% per-file minimum
- `rspec-sidekiq` for job testing
- Transactional fixtures enabled

## CI/CD

GitHub Actions runs on PRs and pushes to main:
1. Brakeman security scan
2. RuboCop lint
3. RSpec tests (with MySQL + Redis services)

YARD docs auto-deployed to GitHub Pages on main branch pushes.
