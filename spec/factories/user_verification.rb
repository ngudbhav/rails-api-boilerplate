FactoryBot.define do
  factory :user_verification do
    association :user
    phone_number { user.phone_number }
  end
end
