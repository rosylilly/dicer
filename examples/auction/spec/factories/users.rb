# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Forgery::Name.full_name }
    email { Forgery::Internet.email_address }
    assets 0
    password { Forgery::Basic.password }
  end
end
