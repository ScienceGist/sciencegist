FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "#{n}@example.com"}
    sequence(:password) {|n| "password#{n}"}
    sequence(:name) {|n| n}
  end
end