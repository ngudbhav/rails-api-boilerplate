# Rails 8 and Ruby 3.4 API only Boilerplate application

## Setup
Ensure that Ruby 3.4 is installed and active in the environment. You can use a version manager like `rbenv` or `rvm` to manage Ruby versions.
This application is built with Rails 8 and uses MySQL as the database. The code is tested with MySQL 9.3 but should work with MySQL 8.0 as well.

```bash
git clone https://github.com/ngudbhav/rails-api-boilerplate.git
cd rails-api-boilerplate
bundle install
rails db:create
rails db:migrate
```

## Features
- API-only Rails application
- JWT authentication
- YJIT enabled for performance
- Lib for OTP (One Time Password) generation and verification
- Common utilities for API responses in concerns
- Profile controller for user profile management
- Image upload functionality using Active Storage
- Integration with Sentry for error tracking
- Integration with Discard gem for soft deletion
- Integration with Sidekiq for background job processing
- Optional Password authentication

## Running the Application
To start the Rails server, run:

```bash
rails server
```
