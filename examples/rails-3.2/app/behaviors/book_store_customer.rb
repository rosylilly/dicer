module BookStoreCustomer
  include Dicer::Behavior

  def purchase(book)
    books << book
  end
end
