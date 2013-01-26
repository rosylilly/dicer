require 'spec_helper'

describe UsersController do
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
