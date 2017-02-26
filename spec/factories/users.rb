FactoryGirl.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    full_name 'Jay Jay'
    address 'Home Sweet Home'
    phone_number '02942029586'

    trait :invalid do
      phone_number 1234
    end

    factory :invalid_user, traits: [:invalid]
  end
end
