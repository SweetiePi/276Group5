require 'simplecov'
SimpleCov.minimum_coverage_by_file 80
SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
  add_filter "/vendor/"
  add_filter "/db/"

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Mailers', 'app/mailers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Jobs', 'app/jobs'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::HtmlReporter.new]
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
end
