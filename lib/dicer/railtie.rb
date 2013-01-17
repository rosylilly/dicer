require 'dicer/middleware'

require 'dicer/railtie/action_controller'
require 'dicer/railtie/active_record'

require 'dicer/railtie/context'
require 'dicer/railtie/contextable'

module Dicer
  class Railtie < ::Rails::Railtie
    def self.generator
      config.respond_to?(:app_generators) ? :app_generators : :generators
    end

    config.dicer = Dicer.config

    initializer 'dicer' do |app|
      config.after_initialize do
        if Dicer.config.auto_supply && !defined?(ActiveRecord)
          puts "Dicer's auto_supply option is supporting ActiveRecord only"
        end

        unless Rails.env.production?
          require 'dicer/rspec' if defined?(RSpec)
        end
      end

      # Paths
      app.config.paths.add('app/contexts', :eager_laod => true)
      app.config.paths.add('app/behaviors', :eager_laod => true)

      # Middleware
      app.config.middleware.use Dicer::Middleware

      # ActionController
      ActiveSupport.on_load :action_controller do |controller|
        Dicer.setup_action_controller(controller)
      end

      # ActiveRecord
      ActiveSupport.on_load :active_record do |orm|
        Dicer.setup_active_record(orm)
      end

      # Mongoid
      ActiveSupport.on_load :mongoid do |orm|
        Dicer.setup_mongoid(orm)
      end
    end
  end

  def self.setup_action_controller(controller)
    controller.class_eval do
      include Dicer::ActionController
    end
  end

  def self.setup_active_record(orm)
    orm.class_eval do
      include Dicer::ActiveRecord
    end
  end

  def self.setup_mongoid(orm)
    orm.module_eval do
      include Dicer::Contextable
    end
  end
end
