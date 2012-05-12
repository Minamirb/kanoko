# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    after_create {|u| FactoryGirl.create(:diary, :users => [u]) }
  end
end
