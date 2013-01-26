require 'dicer/delegator'

module Dicer
  class Context
    class Description
      def initialize(described_class, &block)
        @described_class = described_class
        @behaviors = {}
        @behaviors.default = []
        @delegators = {}

        instance_eval(&block) if block_given?
      end
      attr_reader :described_class, :behaviors

      def it_behaves_like(behavior)
        @behaviors[@role] << behavior
      end

      def role(name, &block)
        @role = name.to_s.to_sym
        @behaviors[@role] = [] unless @behaviors.has_key?(@role)
        instance_eval(&block) if block_given?
        @role = nil
      end

      def merge!(other)
        other.behaviors.each_pair do |role, behaviors|
          if @behaviors.has_key?(role)
            @behaviors[role] = @behaviors[role] | behaviors
          else
            @behaviors[role] = behaviors
          end
        end

        @behaviors.default = @behaviors.default | other.behaviors.default
      end

      def delegator
        @delegators.default ||= Dicer::Delegator.make(
          @described_class,
          @behaviors.default
        )
      end

      def delegator_for(role)
        role = role.to_s.to_sym

        @delegators[role] ||= Dicer::Delegator.make(
          @described_class,
          @behaviors[role]
        )
      end
    end
  end
end
