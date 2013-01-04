require 'spec_helper'

describe Dicer::Contextable do
  let(:entity) { Entity.new({}) }
  let(:cleaning_context) { CleaningContext.new }

  describe '#in_context' do
    context 'current context is cleaning context' do
      before do
        Dicer::Context.current = cleaning_context
      end

      subject { entity.in_context }

      it { should respond_to(:clean) }
    end
  end
end
