class Bid < ActiveRecord::Base
  attr_accessible :item_id, :price, :user_id

  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :user_id, scope: :item_id
end
