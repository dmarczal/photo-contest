# This will guess the User class
FactoryGirl.define do
  factory :vote do
  	association :participant, factory: :participant
  	association :user, factory: :user
  end
end