require 'rubygems'
require 'bundler'
if ENV['WITH_RAILS']
  require 'rails'
  require 'action_controller'
  require 'action_controller/test_case'
end
Bundler.require(:default, :test)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  unless ENV['WITH_RAILS']
    config.filter_run_excluding(:example_group => {
      :file_path => %r(#{Regexp.quote('spec/dicer/railtie')})
    })
  end

  config.before(:all) do
    Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |lib|
      require lib
    end
  end
end
