# This will guess the User class
FactoryGirl.define do
  factory :contest do
  	title								{ Faker::Name.title }
  	description					{ Faker::Lorem.sentence }
  	opening_enrollment	{ Time.now }
  	closing_enrollment	{ Time.now + 2.weeks }
  	opening 						{ Time.now + 2.weeks }
  	closing 						{ Time.now + 1.month }
    image               { File.open(Dir["#{Rails.root}/lib/images/contest/*"].sample) }
  end
end
