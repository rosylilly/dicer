require 'dicer/context/description'

module Dicer
  class Context
    def self.descriptions
      @descriptions ||= {}
    end

    def self.describe(klass, &block)
      description = Description.new(klass, &block)

      descriptions[description.described_class] = description
    end

    def supply(object)
      description = self.class.descriptions[object.class]
      delegator = description ? description.delegator : nil

      delegator ? delegator.new(object) : object
    end
  end
end
