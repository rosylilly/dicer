require 'dicer/middleware'
require 'dicer/railtie/context'
require 'dicer/railtie/contextable'

module Dicer
  class Railtie < ::Rails::Railtie
    initializer 'dicer' do |app|
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
      prepend_before_filter do
        Dicer::Context.current_controller = self
      end

      private
      def context(context = nil)
        context.present? ?
          Dicer::Context.current = context :
          Dicer::Context.current
      end

      def in_context(context, &block)
        current_context = Dicer::Context.current
        Dicer::Context.current = context
      ensure
        Dicer::Context.current = current_context
      end
    end
  end

  def self.setup_active_record(orm)
    orm.class_eval do
      include Dicer::Contextable
    end
  end

  def self.setup_mongoid(orm)
    orm.module_eval do
      include Dicer::Contextable
    end
  end
end
