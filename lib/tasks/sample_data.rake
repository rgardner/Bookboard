namespace :db do
  desc "Fill database with sample data"
  task populate :environment do
    make_users
  end
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "foobar"
    User.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password)
  end
end