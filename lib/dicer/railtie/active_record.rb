module Dicer
  module ActiveRecord
    extend ActiveSupport::Concern
    include Dicer::Contextable

    included do
      def self.new_with_dicer(*args, &block)
        if Dicer.config.auto_supply && Dicer::Context.current.present?
          new_without_dicer(*args, &block).in_context
        else
          new_without_dicer(*args, &block)
        end
      end

      def self.instantiate_with_dicer(*args)
        if Dicer.config.auto_supply && Dicer::Context.current.present?
          instantiate_without_dicer(*args).in_context
        else
          instantiate_without_dicer(*args)
        end
      end

      class << self
        alias_method_chain :new, :dicer
        alias_method_chain :instantiate, :dicer
      end
    end
  end
end
