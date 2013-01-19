module Dicer
  module RSpec
    module BehabiorExampleGroup
      extend ActiveSupport::Concern

      included do
        subject do
          extend_to.behaves_like(described_class)
        end
      end

      module ClassMethods
        def extend_to(&block)
          let(:extend_to, &block)
        end
      end
    end
  end

  ::RSpec.configure do |config|
    config.include(
      RSpec::BehabiorExampleGroup,
      :example_group => { :file_path => %r{spec/behaviors} },
      :type => :behavior
    )
  end
end
