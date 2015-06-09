namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'    
    
    Admin::Contest.delete_all    
    
    # Old contests
    Admin::Contest.populate(5) do |admin_contest|
      admin_contest.title                =   "Concurso #{Faker::Name.title}"
      admin_contest.description          =   Faker::Lorem.paragraphs(8)

      admin_contest.opening_enrollment   =   Time.now - 2.days
      admin_contest.closing_enrollment   =   Time.now - 4.days
      admin_contest.opening              =   Time.now - 6.days
      admin_contest.closing              =   Time.now - 8.days
    end
    
    # Future contests
    Admin::Contest.populate(5) do |admin_contest|
      admin_contest.title                =   "Concurso #{Faker::Name.title}"
      admin_contest.description          =   Faker::Lorem.paragraphs(8)

      admin_contest.opening_enrollment   =   Time.now + 2.days
      admin_contest.closing_enrollment   =   Time.now + 4.days
      admin_contest.opening              =   Time.now + 6.days
      admin_contest.closing              =   Time.now + 8.days
    end

    # Current contest
    Admin::Contest.populate(1) do |admin_contest|
      admin_contest.title                =   "Concurso #{Faker::Name.title}"
      admin_contest.description          =   Faker::Lorem.paragraphs(8)

      admin_contest.opening_enrollment   =   Time.now - 4.days
      admin_contest.closing_enrollment   =   Time.now - 2.days
      admin_contest.opening              =   Time.now
      admin_contest.closing              =   Time.now + 8.days
    end


    Admin::Contest.all.each do |admin_contest|
      admin_contest.folder =  File.open(Dir["#{Rails.root}/lib/images/*"].sample)
      admin_contest.save(validate: false)
    end
  end
end
