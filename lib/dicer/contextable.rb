module Dicer
  module Contextable
    def in_context(context)
      context.supply(self)
    end
  end
end
