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
    it { should include(Cleaner) }
  end

  describe '#delegator' do
    subject { description.delegator }

    it { should be_a(Class) }

    describe 'decorated entity' do
      subject(:entity) { description.delegator.new(Entity.new({})) }

      it { should respond_to(:clean) }
      it { should be_kind_of(Entity) }

      describe '#class' do
        subject { entity.class }

        it { should == Entity }
      end
    end
  end
end
