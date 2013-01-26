class Item < ActiveRecord::Base
  attr_accessible :bottom_price, :description, :period_at, :seller_id, :title

  belongs_to :seller, class_name: 'User', inverse_of: :items
  has_many :bids

  validates_presence_of :title
  validates_presence_of :seller_id

  def active?
    self.period_at >= Time.now
  end
end
