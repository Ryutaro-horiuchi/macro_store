FactoryBot.define do
  factory :user do
    name { 'テストユーザー1' }
    email { 'example@i.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
    calorie { 852 }
    carbohydrate { 117 }
    protein { 53 }
    lipid { 19 }
  end
end
