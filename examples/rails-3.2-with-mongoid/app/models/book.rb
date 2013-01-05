class Book
  include Mongoid::Document

  field :title, :type => String

  has_and_belongs_to_many :users
end
