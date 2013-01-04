# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book_purchase do
    user { create(:user) }
    book { create(:book) }
  end
end
