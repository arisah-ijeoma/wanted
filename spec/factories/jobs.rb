FactoryBot.define do
  factory :job, class: Job do
    classification { 'full-time' }
    description { 'I am Ijeoma. Hear me roar!' }
    title { 'Ruby on Rails Developer' }
    amount { 100000 }

    trait :invalid do
      classification { '' }
    end

    factory :invalid_job, traits: [:invalid]
  end
end
