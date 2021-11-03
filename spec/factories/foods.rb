FactoryBot.define do
  factory :food do
    name { "MyString" }
    price { 1 }
    calorie { 1 }
    carbohydrate { "9.99" }
    protein { "9.99" }
    lipid { "9.99" }
    store { 1 }
  end
end
