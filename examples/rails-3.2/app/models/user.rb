class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :book_purchases
  has_many :books, :through => :book_purchases
end
