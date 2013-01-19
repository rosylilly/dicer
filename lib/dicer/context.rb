require 'dicer/context/description'

module Dicer
  class Context
    def self.descriptions
      @descriptions ||=
        self < Dicer::Context ?
          self.superclass.descriptions.dup :
          {}
    end

    def self.describe(klass, &block)
      description = Description.new(klass, &block)
      klass = description.described_class

      if descriptions.has_key?(klass)
        descriptions[klass].merge!(description)
      else
        descriptions[klass] = description
      end
    end

    def supply(object, role = nil)
      description = self.class.descriptions[object.class]
      delegator = description ?
        (role.nil? ?
          description.delegator :
          description.delegator_for(role)) :
        nil

      delegator ? delegator.new(object) : object
    end
  end
end
