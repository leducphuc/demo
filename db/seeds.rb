# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:'tomato',email:'tomato@gmail.com',password:'password',password_confirmation:'password',admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "juicea#{n}@gmail.com"
  password='password'
  User.create!(name: name,
              email: email,
              password:password,
              password_confirmation:password)
  end
users = User.order(:updated_at).take(10)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each{|user| user.microposts.create!(content: content)}
end
