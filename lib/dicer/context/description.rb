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
        @delegator ||= Dicer::Delegator.make(@described_class, @behaviors)
      end
    end
  end
end
