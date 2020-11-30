# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false
               )
end
User.create!(name: "user1",
             email: "user1@user.com",
             password: "password",
             password_confirmation: "password",
             admin: true
             )
User.create!(name: "user2",
             email: "user2@user.com",
             password: "password",
             password_confirmation: "password",
             admin: true
             )
5.times do |n|
  Label.create!(name: "ラベル#{n + 1}",
                user_id: 1)
end
