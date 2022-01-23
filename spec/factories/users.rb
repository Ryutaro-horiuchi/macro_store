FactoryBot.define do
  factory :user do
    name { 'テストユーザー1' }
    email { 'example@i.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
