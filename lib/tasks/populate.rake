namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Contest, User, Participant].each(&:delete_all)

    # Old contests
    Contest.populate(5) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 8.days
      contest.closing_enrollment   =   Time.zone.now - 6.days
      contest.opening              =   Time.zone.now - 4.days
      contest.closing              =   Time.zone.now - 2.days
    end

    Contest.populate(5) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 35.days
      contest.closing_enrollment   =   Time.zone.now - 30.days
      contest.opening              =   Time.zone.now - 26.days
      contest.closing              =   Time.zone.now - 20.days
    end

    Contest.populate(10) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 8.month
      contest.closing_enrollment   =   Time.zone.now - 6.month
      contest.opening              =   Time.zone.now - 4.month
      contest.closing              =   Time.zone.now - 2.month
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

    # Current open enrollment contest
    Contest.populate(1) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 4.days
      contest.closing_enrollment   =   Time.zone.now + 2.days
      contest.opening              =   Time.zone.now + 4.days
      contest.closing              =   Time.zone.now + 8.days
    end

    # Current idle contest
    Contest.populate(1) do |contest|
      contest.title                =   "Concurso #{Faker::Name.title}"
      contest.description          =   Faker::Lorem.paragraphs(8)

      contest.opening_enrollment   =   Time.zone.now - 4.days
      contest.closing_enrollment   =   Time.zone.now - 2.days
      contest.opening              =   Time.zone.now + 2.days
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
      user.short_description = Faker::Name.title
      user.biography = Faker::Lorem.paragraph(5)
      user.avatar = Faker::Avatar.image
      user.sign_in_count = 0
      user.username = Faker::Internet.user_name
      user.first = Faker::Number.number(1)
      user.second= Faker::Number.number(1)
      user.third = Faker::Number.number(1)
    end

    user = User.new
    user.name = 'Admin' 
    user.email = 'admin@admin.com'
    user.password = '12345678'
    user.password_confirmation = '12345678'
    user.username = 'admin'
    user.admin = true
    user.save!

    users = User.all.ids
    contests = Contest.all.ids

    i = 0
    Participant.populate(5) do |participant|
      participant.user_id = users[i]
      participant.contest_id = contests[i]
      i = i + 1 
    end
  end
end
