require 'spec_helper'

describe AuthenticationController do
  describe 'GET sign_up' do
    subject(:sign_up) { get :sign_up }

    it { should be_success }

    it 'assigned @user' do
      sign_up
      assigns(:user).should be_kind_of(User)
    end
  end
end
