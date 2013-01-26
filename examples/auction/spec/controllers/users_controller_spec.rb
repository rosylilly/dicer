require 'spec_helper'

describe UsersController do
  describe 'GET show' do
    subject(:req) { get :show, id: id }

    context 'when found user' do
      let(:user) { create(:user) }
      let(:id) { user.id }

      it { should be_success }
      it { should render_template(:show) }

      it 'assigned user' do
        req
        assigns(:user).should == user
      end
    end

    context 'when not found user' do
      let(:id) { User.all.count + 1 }

      it { should be_not_found }
    end
  end

  describe 'POST create' do
    subject { post :create, params }

    context 'when valid params' do
      let(:password) { Forgery(:basic).password }
      let(:params) do
        {
          user: {
            name: Forgery(:name).full_name,
            email: Forgery(:internet).email_address
          },
          password: password,
          password_confirmation: password
        }
      end

      it { should redirect_to(root_path) }
      it { expect { subject }.to change { User.count }.from(0).to(1) }
    end

    context 'when invalid params' do
      let(:params) { {} }

      it { should render_template('authentication/sign_up') }
    end
  end
end
