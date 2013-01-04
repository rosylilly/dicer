require 'dicer/middleware'

module Dicer
  class Railtie < ::Rails::Railtie
    initializer 'dicer' do |app|
      # Paths
      app.config.paths.add('app/contexts', :eager_laod => true)
      app.config.paths.add('app/behaviors', :eager_laod => true)

      # Middleware
      app.config.middleware.use Dicer::Middleware

      # Dicer::Context for Rails
      require 'dicer/railtie/context'

      # ActionController
      ActiveSupport.on_load :action_controller do |controller|
        Dicer.setup_controller(controller)
      end

      # ActiveRecord
      ActiveSupport.on_load :active_record do |orm|
        Dicer.setup_orm(orm)
      end
    end
  end

  def self.setup_controller(controller)
    controller.class_eval do
      prepend_before_filter do
        Dicer::Context.current_controller = self
      end

      def current_context=(context)
        Dicer::Context.current = context
      end

      def current_context
        Dicer::Context.current
      end
    end
  end

  def self.setup_orm(orm)
    orm.class_eval do
      include Dicer::Contextable

      # Auto Context
      def self.new_with_dicer(*args, &block)
        if Dicer::Context.current.present?
          new_without_dicer.in_context(Dicer::Context.current)
        else
          new_without_dicer(*args, &block)
        end
      end

      class << self
        alias_method_chain :new, :dicer
      end
    end
  end
end