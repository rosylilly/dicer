require 'rubygems'
require 'bundler'
require 'rails'
require 'action_controller'
require 'action_controller/test_case'
require 'active_record'

require 'simplecov'
SimpleCov.add_filter('spec')
SimpleCov.start

Bundler.require(:default, :test)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |lib|
      require lib
    end
  end

  config.before(:all) do
    Dicer::Middleware.clear!
  end
end
