require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  describe '#in_context' do
    it { should respond_to(:in_context) }
  end
end
