require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  describe '#in_context' do
    it { should respond_to(:in_context) }
  end

  describe '#books' do
    subject { user.books }

    it { should be_empty }
  end
end
