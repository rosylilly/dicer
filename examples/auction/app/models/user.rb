class User < ActiveRecord::Base
  attr_accessible :assets, :name, :email

  has_many :items, foreign_key: :seller_id, inverse_of: :seller

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, if: :password_changed?
  validates_confirmation_of :password

  def password
    @password ||= BCrypt::Password.new(read_attribute(:password))
  end

  def password=(password)
    password = BCrypt::Password.create(password)
    write_attribute(:password, password)
    @password = password
  end
end
