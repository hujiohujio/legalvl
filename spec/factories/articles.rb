FactoryBot.define do
  factory :article do
    id           {"1"}
    text         {"テスト"}
    title        {"テスト"}

    association :user
  end
end
