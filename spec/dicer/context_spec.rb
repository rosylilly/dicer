require 'spec_helper'

describe Dicer::Context do
  let(:context_class) do
    Class.new(Dicer::Context) do
      describe Entity do
      end
    end
  end

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
end
