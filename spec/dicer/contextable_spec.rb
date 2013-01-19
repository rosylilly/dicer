require 'spec_helper'

describe Dicer::Contextable do
  let(:entity) { Entity.new({}) }
  let(:cleaning_context) { CleaningContext.new }

  describe '#in_context' do
    subject { entity.in_context(cleaning_context) }

    it { should respond_to(:clean) }
    it { should == entity }

    context 'with block' do
      it do
        entity.in_context(cleaning_context) do |cleaner|
          cleaner.should respond_to(:clean)
        end
      end
    end
  end

  describe '#behaves_like' do
    subject { entity.behaves_like(Cleaner) }

    it { should respond_to(:clean) }

    context 'with block' do
      it do
        entity.behaves_like(Cleaner) do |cleaner|
          cleaner.should respond_to(:clean)
        end
      end
    end
  end
end
