require 'spec_helper'

describe Book do
  subject(:book) { FactoryGirl.create(:book) }

  describe '#in_context' do
    it { should respond_to(:in_context) }
  end

  describe '#users' do
    subject { book.users }

    it { should be_empty }
  end
end
