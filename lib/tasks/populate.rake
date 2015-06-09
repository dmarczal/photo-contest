namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    Contest.delete_all

    # Old contests
    Contest.populate(5) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.now - 2.days
      contest.closing_enrollment   =   Time.now - 4.days
      contest.opening              =   Time.now - 6.days
      contest.closing              =   Time.now - 8.days
    end
    
    # Future contests
    Contest.populate(5) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.now + 2.days
      contest.closing_enrollment   =   Time.now + 4.days
      contest.opening              =   Time.now + 6.days
      contest.closing              =   Time.now + 8.days
    end

    # Current contest
    Contest.populate(1) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.now - 4.days
      contest.closing_enrollment   =   Time.now - 2.days
      contest.opening              =   Time.now
      contest.closing              =   Time.now + 8.days
    end


    Contest.all.each do |contest|
      contest.image =  File.open(Dir["#{Rails.root}/lib/images/*"].sample)
      contest.save(validate: false)
    end
  end
end
