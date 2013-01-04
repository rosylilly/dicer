require 'spec_helper'

describe BookStoreController do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET show' do
    subject { get :show, :id => book.id }

    it { should be_ok }
  end

  describe 'POST purchase' do
    before do
      session[:user_id] = user.id
    end

    subject { post :purchase, :id => book.id }

    context 'when not purchased' do
      it { should be_created }

      it 'should added books' do
        post :purchase, :id => book.id
        user.reload.books.should include(book)
      end
    end

    context 'when purchased' do
      before do
        user.books << book
      end

      it { should be_forbidden }
    end
  end
end
