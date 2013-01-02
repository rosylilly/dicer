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
    end
  end
end
