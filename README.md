# Dicer

useful DCI for Ruby.

for example:

```ruby
class User < ActiveRecord::Base
  has_many :purchases
end

module Customer
  include Dicer::Behavior

  def purchase(book)
    self.purchases.create(book: book)
  end
end

class PurchaseContext < Dicer::Context
  describe User do
    it_behaves_like Customer
  end
end

--

purchase_context = PurchaseContext.new
user = User.where(id: session[:user_id]).first
book = Book.where(id: params[:id]).first
customer = user.with_context(purchase_context)

customer.purchase(book)
```

Dicer is faster than `#extend` and `SimpleDelegator`

```
$ ruby bench/method_call.rb
Calculating -------------------------------------
     instance method     31886 i/100ms
       with Delegate     19376 i/100ms
    with Forwardable     23570 i/100ms
        with #extend     12369 i/100ms
          with Dicer     21556 i/100ms
-------------------------------------------------
     instance method   941815.2 (±9.3%) i/s -    4687242 in   5.023422s
       with Delegate   354000.7 (±8.1%) i/s -    1763216 in   5.014210s
    with Forwardable   448410.6 (±15.3%) i/s -   2192010 in   5.046309s
        with #extend   201646.2 (±18.6%) i/s -    977151 in   5.013186s
          with Dicer   414821.6 (±10.0%) i/s -   2069376 in   5.041378s
```

see: [bench/method\_call.rb](https://github.com/rosylilly/dicer/blob/master/bench/method_call.rb)

## Installation

Add this line to your application's Gemfile:

    gem 'dicer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dicer

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
