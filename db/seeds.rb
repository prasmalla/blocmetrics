require 'faker'

# admin user
user = User.new(
  name: 'admin user',
  email: 'default@user.com',
  password: 'default1',
  role: 'admin'
)
user.skip_confirmation!
user.save!

# users
3.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# registered applications
6.times do
  application = users.sample.registered_applications.new(
    name: Faker::Hipster.words(2).join(' '),
    url: Faker::Internet.url
  )
  application.save!
end
apps = RegisteredApplication.all

# application events
9.times do
  event = apps.sample.events.create(
    name: Faker::Hacker.verb
  )
end
