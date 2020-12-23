FactoryBot.define do
  factory :user do
    id                    {Faker::Number}
    nickname              {"test"}
    email                 {Faker::Internet.free_email}
    password              {"0000ja"}
    password_confirmation {password}
  end
end