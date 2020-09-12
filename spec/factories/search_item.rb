FactoryBot.define do
  factory :search_item do
    association :user
    query { 'querymethis' }
  end
end
