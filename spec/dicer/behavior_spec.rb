require 'spec_helper'

describe Dicer::Behavior do
  subject(:behavior) do
    Module.new do
      include Dicer::Behavior

      def foo; 2; end
    end
  end

  describe '.behavior_methods' do
    subject { behavior.behavior_methods }

    it { should have(1).item }
    it { should include(:foo) }
  end
end
