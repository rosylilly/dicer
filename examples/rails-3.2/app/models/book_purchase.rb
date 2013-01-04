class BookPurchase < ActiveRecord::Base
  attr_accessible :book_id, :user_id

  belongs_to :book
  belongs_to :user
end
