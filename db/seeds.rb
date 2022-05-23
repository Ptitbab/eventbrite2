# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Attendance.destroy_all 
Event.destroy_all 
User.destroy_all 

### Generate 5 users
["",1,2,3,4,5].each do |i|
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: "Cet utilisateur a la description suivante: Generated description ##{Faker::Number.number(digits: 5)}", email: "thptest#{i}@yopmail.com",password: Faker::Lorem.characters(number: rand(7..12)))
end

### Generate 5 events
5.times do
  Event.create(admin: User.all.sample, start_date: Faker::Date.between(from: Date.today, to: 1.year.from_now), duration: 5 * rand(12..120), title: Faker::Hobby.activity, description: "Cet evenement a la description aléatoire ##{rand(100..9999)}", price: rand(1..200), location: Faker::Address.city)
end

### Add 1-3 attendees to each event
Event.all.each do |event|
  n = rand(1..3)
  n.times do
    Attendance.create(event: event, attendee: User.all.sample)
  end
end