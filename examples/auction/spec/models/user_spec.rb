require 'spec_helper'

describe User do
  subject(:user) { create(:user) }

  describe '#password' do
    let(:password) { SecureRandom.hex }

    before { user.password = password }

    subject { user.password }

    it { should be_a(BCrypt::Password) }
    it { should == password }
  end
end
