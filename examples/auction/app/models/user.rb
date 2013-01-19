class User < ActiveRecord::Base
  attr_accessible :assets, :name

  def password
    @password ||= BCrypt::Password.new(read_attribute(:password))
  end

  def password=(password)
    password = BCrypt::Password.create(password)
    write_attribute(:password, password)
    @password = password
  end
end
