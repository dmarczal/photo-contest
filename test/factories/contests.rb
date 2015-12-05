# This will guess the User class
FactoryGirl.define do
  factory :contest do
  	title								{ Faker::Name.title }
  	description					{ Faker::Lorem.sentence }
  	opening_enrollment	{ Time.now }
  	closing_enrollment	{ Time.now + 2.weeks }
  	opening 						{ Time.now + 2.weeks }
  	closing 						{ Time.now + 1.month }
  end

  factory :old_contest, class: Contest do
    title								{ Faker::Name.title }
  	description					{ Faker::Lorem.sentence }
  	opening_enrollment	{ Time.now - 3.weeks}
  	closing_enrollment	{ Time.now - 2.weeks }
  	opening 						{ Time.now - 2.weeks }
  	closing 						{ Time.now - 1.week }
  end


  factory :current_contest, class: Contest do
    title								{ Faker::Name.title }
    description					{ Faker::Lorem.sentence }
    opening_enrollment	{ Time.now - 3.weeks}
    closing_enrollment	{ Time.now - 2.weeks }
    opening 						{ Time.now - 2.weeks }
    closing 						{ Time.now + 1.week }
  end

end
