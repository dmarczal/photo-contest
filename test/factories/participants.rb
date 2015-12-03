# This will guess the User class
FactoryGirl.define do
  factory :participant do
    association :user, factory: :user
    association :contest, factory: :contest
    accepted_term true
    status 2
    description Faker::Lorem.paragraph
    title								{ Faker::Name.title }
    picture_file_name "National_Geographic_Photography_Contest_2010_1.jpg"
    picture_content_type  "image/jpeg"
    picture_file_size  37367
    picture_updated_at Time.now
  end
end
