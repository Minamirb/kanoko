# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    user nil
    diary nil
    sort 1
    baton 1
  end
end
