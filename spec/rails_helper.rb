require 'coveralls'
Coveralls.wear!('rails')

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'

require 'rspec/rails'
require 'capybara/rails'
require 'selenium-webdriver'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

module Features
  include AuthHelpers
  include PostsHelpers
  include CommentsHelpers
  include LikesHelpers
  include ProfilesHelpers
  include NotificationsHelpers
  include OmniAuthHelpers
end

module Controllers
  include OmniAuthHelpers
end

RSpec.configure do |config|
  config.include Features, type: :feature
  config.include Controllers, type: :controller
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 5
