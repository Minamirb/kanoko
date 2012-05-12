# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    content "MyText"
    member_id 1
    picture ""
  end
end
