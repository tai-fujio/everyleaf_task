FactoryBot.define do
  factory :user do
    name { "テストユーザー名" }
    email { "test@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    admin_or_not { false }
  end
end
