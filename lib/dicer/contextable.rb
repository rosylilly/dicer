require 'dicer/delegator'

module Dicer
  module Contextable
    def in_context(context, &block)
      if block.nil?
        context.supply(self)
      else
        block.call(context.supply(self))
      end
    end

    def as(*behaviors, &block)
      delegator = Dicer::Delegator.make(self.class, behaviors)

      block.nil? ? delegator.new(self) : block.call(delegator.new(self))
    end
  end
end
