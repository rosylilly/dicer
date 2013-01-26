# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    title { Forgery::Basic.text }
    description { Forgery::Basic.text }
    bottom_price 0
    period_at { 1.day.since }
    seller { create(:user) }
  end
end
