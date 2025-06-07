# Rails 8 and Ruby 3.4 API only Boilerplate application

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
- Preconfigured with [GitHub Actions](.github/workflows/ci.yml) for CI/CD
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
