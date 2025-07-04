require 'simplecov'
require 'simplecov-json'
require 'simplecov_json_formatter'

module Support
  class SimpleCovHelper
    # configure provides reuse to spec_helper and the rake task that aggregates coverage reports
    # Note: in CI, coverage is generated from parallelized rspec runs, with each run getting a portion of spec tests.
    # At that time, overall minimum coverage logically cannot be enforced, so must not be configured.
    # However, callers can pass a block to do additional arbitrary configuration.
    def self.configure
      SimpleCov.configure do
        formatter SimpleCov::Formatter::MultiFormatter.new(
          [
            SimpleCov::Formatter::SimpleFormatter,
            SimpleCov::Formatter::HTMLFormatter,
            SimpleCov::Formatter::JSONFormatter
          ]
        )

        load_profile 'rails'

        add_filter '/lib/tasks'

        enable_coverage :branch
        # minimum_coverage line: 85, branch: 80 # Can't do these here
        # minimum_coverage_by_file line: 90, branch: 80

        yield if block_given?
      end
    end
  end
end
