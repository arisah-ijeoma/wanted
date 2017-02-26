FactoryGirl.define do
  factory :job, class: Job do
    classification 'full-time'
    duration '3 weeks'
    description 'I am Ijeoma. Hear me roar!'

    trait :invalid do
      classification ''
    end

    factory :invalid_job, traits: [:invalid]
  end
end
