namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Contest, User].each(&:delete_all)

    # Old contests
    Contest.populate(5) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 8.days
      contest.closing_enrollment   =   Time.zone.now - 6.days
      contest.opening              =   Time.zone.now - 4.days
      contest.closing              =   Time.zone.now - 2.days
    end
    
    # Future contests
    Contest.populate(5) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now + 2.days
      contest.closing_enrollment   =   Time.zone.now + 4.days
      contest.opening              =   Time.zone.now + 6.days
      contest.closing              =   Time.zone.now + 8.days
    end

    # Current contest
    Contest.populate(1) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 2.days
      contest.closing_enrollment   =   Time.zone.now - 4.days
      contest.opening              =   Time.zone.now
      contest.closing              =   Time.zone.now + 8.days
    end


    Contest.all.each do |contest|
      contest.image =  File.open(Dir["#{Rails.root}/lib/images/*"].sample)
      contest.save(validate: false)
    end

    # Some users
    password = 'password'
    User.populate(20) do |user|
      user.name = Faker::Name.name
      user.email = Faker::Internet.email
      user.encrypted_password = User.new(:password => password).encrypted_password
      user.sign_in_count = 0
      user.username = Faker::Internet.user_name
    end

    user = User.new
    user.name = 'Admin' 
    user.email = 'admin@admin.com'
    user.password = '12345678'
    user.password_confirmation = '12345678'
    user.username = 'admin'
    user.admin = true
    user.save!

  end
end
