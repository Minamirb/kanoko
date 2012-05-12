# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    provider "MyString"
    uid "MyString"
    name "MyString"
    screen_name "MyString"
  end
end
