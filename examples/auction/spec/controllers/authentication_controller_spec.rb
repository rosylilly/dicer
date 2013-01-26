require 'spec_helper'

describe AuthenticationController do
  describe 'GET sign_up' do
    subject(:sign_up) { get :sign_up }

    it { should be_success }
    it { should render_template(:sign_up) }

    it 'assigned @user' do
      sign_up
      assigns(:user).should be_kind_of(User)
    end
  end

  describe 'GET sign_in' do
    subject { get :sign_in }

    it { should be_success }
    it { should render_template(:sign_in) }
  end

  describe 'POST log_in' do
    subject { post :log_in, email: user.email, password: password }

    context 'when valid params' do
      let(:password) { Forgery(:basic).password }
      let(:user) { create(:user, password: password) }

      it { should redirect_to(root_path) }
    end

    context 'when invlaid params' do
      let(:password) { Forgery(:basic).password }
      let(:user) { create(:user, password: password + '_not') }

      it { should render_template('authentication/sign_in') }
    end
  end

  describe 'GET sign_out' do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
    end

    subject { get :sign_out }

    it { should redirect_to(root_path) }

    it 'should removed session' do
      get :sign_out
      session.should_not have_key(:user_id)
    end
  end
end
