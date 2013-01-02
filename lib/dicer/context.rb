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
  end
end
