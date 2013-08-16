FactoryGirl.define do
  factory :gist do
    sequence(:content) {|n| n}
    user
    paper
  end
end