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
end
