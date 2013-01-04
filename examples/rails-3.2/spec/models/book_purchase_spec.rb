require 'spec_helper'

describe BookPurchase do
  subject(:book_purchase) { FactoryGirl.create(:book_purchase) }

  describe '#user' do
    subject { book_purchase.user }

    it { should be_kind_of(User) }
  end

  describe '#book' do
    subject { book_purchase.book }

    it { should be_kind_of(Book) }
  end
end
