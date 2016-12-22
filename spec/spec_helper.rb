require 'simplecov'
SimpleCov.start

require 'capybara/webkit'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end
