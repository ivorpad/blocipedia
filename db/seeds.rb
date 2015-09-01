require 'faker'

5.times do
  user = User.new(
      username: Faker::Internet.user_name,
      email:    Faker::Internet.email,
      password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

50.times do
  Wiki.create!(
      user_id: users.shuffle.last.id,
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

puts "Seeds finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"