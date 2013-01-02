require 'spec_helper'

describe Dicer::Context do
  let(:context_class) do
    Class.new(Dicer::Context) do
      describe Entity do
        it_behaves_like Cleaner
      end
    end
  end

  subject(:context) { context_class.new }

  describe '.descriptions' do
    subject { context_class.descriptions }

    it { should have(1).item }
  end

  describe '.describe' do
    subject(:describe) do
      context_class.describe(Value) {}
    end

    specify do
      expect { describe }.to change { context_class.descriptions.size }.by(1)
    end
  end

  describe '#supply' do
    context 'with described class' do
      let(:entity) { Entity.new({}) }

      subject { context.supply(entity) }

      it { should be_kind_of(Entity) }
      it { should == entity }
      it { should respond_to(:clean) }
    end

    context 'with not described class' do
      let(:value) { Value.new({}) }

      subject { context.supply(value) }

      it { should be_kind_of(Value) }
      it { should == value }
      it { should_not respond_to(:clean) }
    end
  end
end
