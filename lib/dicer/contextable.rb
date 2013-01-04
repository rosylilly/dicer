module Dicer
  module Contextable
    def in_context(context, &block)
      if block.nil?
        context.supply(self)
      else
        block.call(context.supply(self))
      end
    end
  end
end
