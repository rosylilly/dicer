require 'spec_helper'

describe Dicer::Contextable do
  let(:entity) { Entity.new({}) }
  let(:cleaning_context) { CleaningContext.new }

  describe '#with_context' do
    subject { entity.with_context(cleaning_context) }

    it { should respond_to(:clean) }
    it { should == entity }
  end
end
