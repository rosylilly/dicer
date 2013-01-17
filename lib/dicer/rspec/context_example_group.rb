require 'action_controller/test_case'

module Dicer
  module RSpec
    module ContextExampleGroup
      extend ActiveSupport::Concern

      included do
        metadata[:type] = :context

        controller

        let(:controller) do
          (
            example.metadata[:controller] ||
            ::ApplicationController
          ).new
        end

        before do
          controller.request =
            example.metadata[:request] ||
            ::ActionController::TestRequest.new

          Dicer::Context.current_controller = controller
        end

        subject(:context) { described_class.new }
      end

      module ClassMethods
        def controller(base_class = ::ApplicationController, &block)
          metadata[:controller] = Class.new(base_class) do
            def self.name; 'AnonymouseController'; end
          end
          metadata[:controller].class_eval(&block) if block
        end

        def request(env = nil, &block)
          test_request = ::ActionController::TestRequest.new(env)
          test_request.instance_eval(&block) if block

          metadata[:request] = test_request
        end
      end

      def request; controller.request; end
    end
  end

  ::RSpec.configure do |config|
    config.include(
      RSpec::ContextExampleGroup,
      :example_group => { :file_path => %r{spec/contexts} },
      :type => :context
    )
  end
end
