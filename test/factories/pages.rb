# This will guess the User class
FactoryGirl.define do
  factory :page do
  	name Faker::Name.title
  	permalink Faker::Internet.slug
  	content Faker::Lorem.paragraph(2)
  end

  factory :contact_page, parent: :page do
  	name "Contact"
  	permalink "contact"
  	content "### Contact \n\n Essa é uma página de *contato*"
  end

  factory :about_page, parent: :page do
    name "About us"
    permalink "about"
    content "Page About US"
  end

end
