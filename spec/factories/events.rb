FactoryBot.define do
  factory :event do
    sequence(:name) { |i| "イベント名#{i}" }
    sequence(:place) { |i| "イベント開催場所#{i}" }
    sequence(:content) { |i| "イベント本文#{i}" }
    start_at { rand(1..30).days.from_now }
    end_at { start_at + rand(1..30).hours }
    # user { event.owner }
    association :owner
  end
end