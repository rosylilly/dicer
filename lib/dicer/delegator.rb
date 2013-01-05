module Dicer
  class Delegator
    def self.make(target_class, behaviors)
      delegator = Class.new(Dicer::Delegator)
      delegator.delegate_to(target_class)
      delegator.class_eval do
        behaviors.each do |behavior|
          include behavior
        end
      end

      return delegator
    end

    def self.except_methods
      @except_methods ||= [
        :__send__,
        :__id__,
        :object_id,
        :respond_to?,
        :methods,
        :public_methods,
        :private_methods,
        :protected_methods,
        :method_missing,
        # for RSpec
        :should,
        :should_not
      ]
    end

    def self.include(behavior)
      super(behavior)
      self.except_methods.concat(behavior.behavior_methods)
    end

    def self.delegate_to(klass)
      delegate_methods = klass.public_methods.map(&:to_sym) - self.except_methods
      def_delegators(klass, *delegate_methods)
    end

    def self.def_delegators(klass, *methods)
      methods.each do |method|
        class_eval <<-EOF
          def #{method}(*args, &block)
            @delegate_object.__send__(:#{method}, *args, &block)
          end
        EOF
      end
    end

    def initialize(object)
      @delegate_object = object
    end

    def respond_to?(name, private = false)
      super || @delegate_object.respond_to?(name)
    end

    def methods(*args)
      @delegate_object.mehtods(*args) | super
    end

    def public_methods(*args)
      @delegate_object.public_methods(*args) | super
    end

    def private_methods(*args)
      @delegate_object.private_mehtods(*args) | super
    end

    def protected_methods(*args)
      @delegate_object.mehtods(*args) | super
    end

    def method_missing(name, *args, &block)
      @delegate_object.send(name, *args, &block)
    end
  end
end
