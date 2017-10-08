# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
# Add additional requires below this line. Rails is not loaded until this point!

if ENV['USE_REMOTE_SELENIUM'].present?
  Capybara.register_driver :selenium do |app|
    selenium_url = "http://#{ENV['SELENIUM_SERVER']}:4444/wd/hub"
    driver = Capybara::Selenium::Driver.new(app,
                                            browser: :remote,
                                            url: selenium_url,
                                            desired_capabilities: :chrome)
    # http://qiita.com/gongo/items/ab81aaa9329d745fb39f
    driver.browser.file_detector = ->(args) do
      str = args.first.to_s
      str if File.exist? str
    end
    driver
  end
  Capybara.server_host = '0.0.0.0'
  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium
end



# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include LoginHelper
  config.include Capybara::DSL
  config.before(:each) do
    # Based on https://gist.github.com/rchampourlier/4038197
    next if ENV['USE_REMOTE_SELENIUM'].blank?
    server = Capybara.current_session.server
    Capybara.app_host = "http://#{ENV['SELENIUM_APP_HOST']}:#{server.port}" if server
  end
  config.after(:each) do
    next if ENV['USE_REMOTE_SELENIUM'].blank?
    Capybara.app_host = nil
  end
end
