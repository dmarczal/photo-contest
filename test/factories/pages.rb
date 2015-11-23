# This will guess the User class
FactoryGirl.define do
  factory :page do
    name Faker::Name.title
    permalink Faker::Internet.slug
    content Faker::Lorem.paragraph(2)
  end

  factory :about_page, parent: :page do
    name "Sobre"
    permalink "about"
    content "Esta é a pagina sobre."
  end
  #
  factory :contact_page, parent: :page do
    name "Contato"
    permalink "contact"
    content "Esta é uma página de contato."
  end
end