module Dicer
  module Behavior
    def self.included(submodule)
      submodule.extend(ClassMethods)
    end

    module ClassMethods
      def method_added(name)
        behavior_methods << name
      end

      def behavior_methods
        @behavior_methods ||= []
      end
    end
  end
end
