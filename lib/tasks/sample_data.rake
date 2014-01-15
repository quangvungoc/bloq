namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
    make_relationships    
  end
end

def make_users
  admin = User.create!(name: "Quang",
               email: "qq@bloq.com",
               email_confirmation: "qq@bloq.com",
               password: "foobar",
               password_confirmation: "foobar",
               admin: true
               )
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@bloq.com"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 email_confirmation: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_entries
=begin
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(10)
    users.each { |user| user.microposts.create!(content: content)}
  end
=end
end

def make_relationships
=begin
  users = User.all
  user = User.first
  followed_users  = users[2..50]
  followers       = users[3..40]
  followed_users.each { |followed| user.follow!(followed)}
  followers.each      { |follower| follower.follow!(user)}
=end
end
