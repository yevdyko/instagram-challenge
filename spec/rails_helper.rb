require 'coveralls'
Coveralls.wear!('rails')

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'selenium-webdriver'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include AuthHelpers,     type: :feature
  config.include PostsHelpers,    type: :feature
  config.include CommentsHelpers, type: :feature
  config.include LikesHelpers,    type: :feature
  config.include ProfilesHelpers, type: :feature

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
