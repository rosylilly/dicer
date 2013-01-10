module Dicer
  module ActionController
    extend ActiveSupport::Concern

    included do
      prepend_before_filter do
        Dicer::Context.current_controller = self

        default_context = self.class.default_contexts[params[:action].to_sym]
        Dicer::Context.current = default_context.new if default_context.present?
      end
    end

    module ClassMethods
      def context_for(action, context_class = nil, &context_define)
        context = context_class || Class.new(Dicer::Context, &context_define)

        default_contexts[action.to_s.to_sym] = context
      end

      def default_contexts
        @default_contexts ||= {}
      end
    end

    def context(context = nil)
      context.present? ?
        Dicer::Context.current = context :
        Dicer::Context.current
    end
    private :context

    def in_context(context, &block)
      current_context = Dicer::Context.current
      Dicer::Context.current = context
    ensure
      Dicer::Context.current = current_context
    end
    private :in_context
  end
end
