# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bid do
    user { create(:user) }
    item { create(:item) }
    price 100
  end
end
