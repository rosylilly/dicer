require 'delegate'

module Dicer
  class Context
    class Description
      def initialize(described_class, &block)
        @described_class = described_class
        @behaviors = []

        instance_eval(&block) if block_given?
      end
      attr_reader :described_class, :behaviors

      def it_behaves_like(behavior)
        @behaviors << behavior
      end

      def delegator
        @delegator ||= begin
          klass = Class.new(SimpleDelegator)
          behaviors = @behaviors
          klass.class_eval do
            behaviors.each do |behavior|
              include behavior
            end

            def kind_of?(klass)
              super || __getobj__.kind_of?(klass)
            end
            alias is_a? kind_of?

            def class
              __getobj__.class
            end
          end

          klass
        end
      end
    end
  end
end
