require 'spec_helper'

describe Dicer::Context::Description do
  subject(:description) do
    Dicer::Context::Description.new(Entity) do
      it_behaves_like Cleaner
    end
  end

  describe '#described_class' do
    subject { description.described_class }

    it { should == Entity }
  end

  describe '#behaviors' do
    subject { description.behaviors }

    it { should have(1).behavior }
  end
end
