namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
    make_relationships    
    make_comments
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
  users = User.all(limit: 6)
  40.times do
    title = Faker::Lorem.sentence(5)
    body = Faker::Lorem.sentence(50)
    users.each { |user| user.entries.create!(title: title, body: body) }
  end
end

def make_relationships
  users = User.all
  user = User.first
  followed_users  = users[2..50]
  followers       = users[3..40]
  followed_users.each { |followed| user.follow!(followed)}
  followers.each      { |follower| follower.follow!(user)}
end

def make_comments
  users = User.all(limit: 6)
  entries = Entry.all(limit: 6)
  entries.each do |entry|
    content = Faker::Lorem.sentence(10)
    users.each do |user|
      user.comments.create!(content: content, entry_id: entry.id)
    end
  end
end