class Book < ActiveRecord::Base
  attr_accessible :title

  has_many :book_purchases
  has_many :users, :through => :book_purchases
end
