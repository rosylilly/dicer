require 'spec_helper'

describe Book do
  describe '#in_context' do
    it { should respond_to(:in_context) }
  end
end
