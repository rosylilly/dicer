module BookStoreCustomer
  include Dicer::Behavior

  def purchase(book)
    unless books.include?(book)
      books << book
      @purchased = true
    end
  end

  def purchased?
    @purchased ||= false
  end
end
