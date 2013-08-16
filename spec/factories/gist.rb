FactoryGirl.define do
  factory :gist do
    sequence(:content) {|n| n.to_s}
    user
    paper
  end
end