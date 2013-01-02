module Dicer
  class Context
    def self.descriptions
      @descriptions ||= []
    end

    def self.describe(klass, &block)
      self.descriptions << Description.new(klass, &block)
    end
  end
end
