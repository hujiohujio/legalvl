FactoryBot.define do
  factory :message do
    content         {"テスト"}

    association :user, :article
  end
end
