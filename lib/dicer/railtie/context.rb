require 'dicer/context'
require 'forwardable'

module Dicer
  class Context
    extend Forwardable

    def self.current=(context)
      Middleware.store[:context] = context
    end

    def self.current
      Middleware.store[:context]
    end

    def self.current_controller=(controller)
      Middleware.store[:current_controller] = controller
    end

    def self.current_controller
      Middleware.store[:current_controller]
    end

    def controller
      self.class.current_controller
    end

    def_delegators :controller, :request, :cookies, :session, :params
  end
end
