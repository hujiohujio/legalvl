FactoryBot.define do
  factory :user do
    nickname              {"test"}
    email                 {"test@example"}
    password              {"0000ja"}
    password_confirmation {password}
  end
end