# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :external_summary do
    url "MyText"
    category "MyString"
    title "MyString"
  end
end
