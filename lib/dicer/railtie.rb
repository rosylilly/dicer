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

      # Auto #in_context
      def self.new_with_dicer(*args, &block)
        instance = new_without_dicer(*args, &block)
        Dicer::Context.current.present? ? instance.in_context : instance
      end

      class << self
        alias_method_chain :new, :dicer
      end

      def init_with_with_dicer(*args)
        instance = init_with_without_dicer(*args)
        Dicer::Context.current.present? ? instance.in_context : instance
      end
      alias_method_chain :init_with, :dicer
    end
  end

  def self.setup_mongoid(orm)
    orm.module_eval(<<-EOF)
      include Dicer::Contextable

      module ClassMethods
        def new(*args, &block)
          instance = allocate
          instance.send(:initialize, *args, &block)
          Dicer::Context.current.present? ? instance.in_context : instance
        end

        def instantiate_with_dicer(*args, &block)
          instance = instantiate_without_dicer(*args, &block)
          Dicer::Context.current.present? ? instance.in_context : instance
        end
        alias_method_chain :instantiate, :dicer
      end
    EOF
  end
end
