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

      class << self
        alias_method_chain :new, :dicer
      end

      def init_with_with_dicer(coder)
        if Dicer.config.auto_supply && Dicer::Context.current.present?
          init_with_without_dicer(coder).in_context
        else
          init_with_without_dicer(coder)
        end
      end
      alias_method_chain :init_with, :dicer
    end
  end
end
