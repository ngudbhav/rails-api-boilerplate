# Rails 8 and Ruby 3.4 API Boilerplate application

[![Documentation](https://github.com/ngudbhav/rails-api-boilerplate/actions/workflows/deploy-docs.yml/badge.svg)](https://ngudbhav.github.io/rails-api-boilerplate/)
[![Test](https://github.com/ngudbhav/rails-api-boilerplate/actions/workflows/ci.yml/badge.svg)](https://github.com/ngudbhav/rails-api-boilerplate/actions/workflows/ci.yml)

## Setup
Ensure that Ruby 3.4 is installed and active in the environment. You can use a version manager like `rbenv` or `rvm` to manage Ruby versions.
This application is built with Rails 8 and uses MySQL as the database. The code is tested with MySQL 9.3 but should work with MySQL 8.0 as well.

```bash
git clone https://github.com/ngudbhav/rails-api-boilerplate.git
cd rails-api-boilerplate
bin/setup
```

## Features
- API-only Rails application
- Mobile-first authentication with [OTP](lib/otp) and design with [JWT](lib/jwt_authenticate.rb)
- Global credentials loader with fail-safe ([lib/credentials.rb](lib/credentials.rb))
- [YJIT](https://shopify.engineering/ruby-yjit-is-production-ready) enabled for performance ([lib/enable_yjit.rb](config/initializers/enable_yjit.rb))
- Common utilities for API responses ([controllers/concerns/api_response.rb](app/controllers/concerns/response.rb))
- Uses [Trilogy](https://github.com/trilogy-libraries/trilogy) as the MySQL adapter for better performance
- Integration with [Sentry](https://sentry.io/welcome/) for error tracking
- Integration with [Discard](https://github.com/jhawthorn/discard) (successor of [Paranoia](https://github.com/rubysherpas/paranoia)) for soft deletion
- Integration with Sidekiq for background job processing
- Preconfigured with [Rubocop](https://github.com/rubocop/rubocop)
- Preconfigured with [GitHub Actions](.github/workflows/ci.yml) and [Dependabot](.github/dependabot.yml) for CI/CD
- Unit testing with [RSpec](https://rspec.info/)

## Running the Application
To start the Rails server, run:

```bash
rails server
```

## CAUTION
Issue the below command and remove master.key file from the repository.
```bash
git rm config/master.key
```
Rotate the master key immediately and store it securely. The application will not work without it.

It is also recommended to rotate the `secret_key_base` in the `config/credentials.yml.enc` file.

## Setting up Sentry
To set up Sentry, you need to create a Sentry account and obtain a DSN (Data Source Name). Once you have the DSN, add it the application.
You can do this by setting the `sentry.dsn` in the `config/credentials.yml.enc` file:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```
