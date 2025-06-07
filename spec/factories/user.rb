FactoryBot.define do
  factory :user do
    phone_number { '919000000000' }
    email_address { Faker::Internet.email }
  end
end
