module Dicer
  class Middleware
    def self.clear!
      Thread.current[:dicer] = {}
    end

    def self.store
      Thread.current[:dicer] ||= {}
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      ::Dicer::Middleware.clear!
      @app.call(env)
    end
  end
end
