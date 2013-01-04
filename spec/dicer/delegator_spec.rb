require 'spec_helper'

describe Dicer::Delegator do
  let(:delegator) { Dicer::Delegator.make(Entity, [Cleaner]) }
  let(:entity) { Entity.new(:test => 1) }

  subject(:delegated) { delegator.new(entity) }

  it { should == entity }

  describe '#__id__' do
    subject { delegated.__id__ }

    it { should_not == entity.__id__ }
  end

  describe '#test' do
    subject { delegated.test }

    it { should == 1 }
  end

  describe '#id' do
    subject { delegated.id }

    it { should == entity.id }
  end

  describe '#clean' do
    subject { delegated.clean }

    it { should be_true }
  end
end
