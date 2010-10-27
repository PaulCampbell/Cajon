require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin_user = User.create!(:name => "Paul Campbell",
                 :email => "example@railstutorial.org",
                 :twitter => "Slarty_Bartfast",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin_user.toggle!(:admin)
    
    4.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@decoratedworld.co.uk"
      password  = "password"
      description = " like building apps for the web and fancy mobile phones. Need something building?

      Do we need basic formatting for the user description? I think we probably do..."
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    
    User.all(:limit => 3).each do |user|
      50.times do
        user.posts.create!(:content => Faker::Lorem.paragraphs(paragraph_count = 4), :slug => Faker::Lorem.sentences(3), :title => Faker::Lorem.sentence(5), :published => true)
      end
    end  
  end
end