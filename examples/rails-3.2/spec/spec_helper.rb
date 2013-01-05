# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'generator_spec/test_case'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include ResponseCodeMatchers
  config.infer_base_class_for_anonymous_controllers = false

  config.include GeneratorSpec::TestCase, :type => :generator, :example_group => {
    :file_path => config.escaped_path(%w[spec generators])
  }

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation if defined?(Mongoid)
    DatabaseCleaner.start
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end
end
