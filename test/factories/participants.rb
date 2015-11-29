# This will guess the User class
FactoryGirl.define do
  factory :participant do
    association :user, factory: :user
    association :contest, factory: :contest
    accepted_term true
    status 2
    description Faker::Lorem.paragraph
    title Faker::Lorem.words(3, true)
  end
end