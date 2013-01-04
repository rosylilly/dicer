module Dicer
  module Contextable
    def in_context(context = Dicer::Context.current)
      context.supply(self)
    end
  end
end
