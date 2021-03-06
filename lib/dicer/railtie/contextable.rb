require 'dicer/contextable'

module Dicer
  module Contextable
    def in_context_with_dicer(context = Dicer::Context.current, &block)
      in_context_without_dicer(context, &block)
    end
    alias_method_chain :in_context, :dicer

    def as_with_dicer(role, context = Dicer::Context.current, &block)
      as_without_dicer(role, context, &block)
    end
    alias_method_chain :as, :dicer
  end
end
