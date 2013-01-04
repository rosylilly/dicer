# Dicer

![](https://raw.github.com/rosylilly/dicer/master/resource/dicer_logo.png) useful DCI for Ruby.

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

context(PurchaseContext.new)
user = User.where(id: session[:user_id]).first
book = Book.where(id: params[:id]).first

user.purchase(book)
```

Dicer is faster than `#extend` and `SimpleDelegator`

```
$ ruby bench/method_call.rb
Calculating -------------------------------------
     instance method     32012 i/100ms
       with Delegate     18413 i/100ms
    with Forwardable     21709 i/100ms
        with #extend     11696 i/100ms
with specific method     11706 i/100ms
          with Dicer     20267 i/100ms
-------------------------------------------------
     instance method   890341.4 (±11.2%) i/s -   4417656 in   5.026077s
       with Delegate   342923.5 (±6.8%) i/s -    1712409 in   5.017309s
    with Forwardable   448447.5 (±6.5%) i/s -    2236027 in   5.009544s
        with #extend   210582.5 (±14.2%) i/s -   1040944 in   5.044065s
with specific method   183500.3 (±15.2%) i/s -    901362 in   4.999332s
          with Dicer   397806.9 (±5.4%) i/s -    1986166 in   5.008770s
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
