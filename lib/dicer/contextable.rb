module Dicer
  module Contextable
    def with_context(context)
      context.supply(self)
    end
  end
end
