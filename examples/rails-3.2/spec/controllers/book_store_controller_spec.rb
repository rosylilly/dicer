require 'spec_helper'

describe BookStoreController do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET show' do
    subject { get :show, :id => book.id }

    it { should be_success }
  end

  describe 'POST purchase' do
    before do
      session[:user_id] = user.id
    end

    subject(:response) { post :purchase, :id => book.id }

    specify { response.status.should == 201 }

    it 'should added books' do
      response
      user.reload.books.should include(book)
    end
  end
end
