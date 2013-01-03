require 'dicer/delegator'

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
          klass = Class.new(Dicer::Delegator)
          klass.delegate_to(@described_class)
          behaviors = @behaviors
          klass.class_eval do
            behaviors.each do |behavior|
              include behavior
            end
          end

          klass
        end
      end
    end
  end
end
