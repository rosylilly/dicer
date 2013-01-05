class BookPurchase
  include Mongoid::Document

  belongs_to :user
  belongs_to :book
end
