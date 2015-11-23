# This will guess the User class
FactoryGirl.define do
  factory :user do
    name                  { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    username              { "#{Faker::Internet.user_name}_#{Random.new.rand(100)}" }
    email                 { Faker::Internet.email }
    password              { 123123123 }
    password_confirmation { 123123123 }
    short_description     { Faker::Name.title }
    biography             { Faker::Lorem.paragraph(5) }
    avatar                { Faker::Avatar.image }
    sign_in_count         0
    first                 { Faker::Number.number(1) }
    second                { Faker::Number.number(1) }
    third                 { Faker::Number.number(1) }
  end

  factory :admin_user, parent: :user do
    admin true
  end
end