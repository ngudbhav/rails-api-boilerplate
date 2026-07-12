FactoryBot.define do
  factory :user do
    phone_number { '919000000000' }
    email_address { Faker::Internet.email }

    trait :with_email_auth do
      phone_number { nil }
      password { 'password123456' }
      password_confirmation { 'password123456' }
    end
  end
end
