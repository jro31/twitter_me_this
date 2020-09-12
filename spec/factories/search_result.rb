FactoryBot.define do
  factory :search_result do
    association :search_item
    twitter_id_number { 123_456 }
    twitter_screen_name { 'mistertwitter' }
  end
end
