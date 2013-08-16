FactoryGirl.define do
  factory :paper do
    sequence(:title) {|n| "Title #{n}"}
    sequence(:abstract) {|n| "Abstract #{n}"}
    metadata { {:authors => 'Janez Novak, Jože Horvat', journal: 'Abstract 2012'} } 
    sequence(:identifier) {|n| "doi: #{n}"}
  end
end