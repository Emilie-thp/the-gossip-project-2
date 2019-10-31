# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

City.destroy_all
User.destroy_all
Gossip.destroy_all
Tag.destroy_all
GossipMetum.destroy_all
PrivateMessage.destroy_all
MessageDelivering.destroy_all
Comment.destroy_all
Like.destroy_all

# building cities (requires nothing)
10.times do
  City.create(
  	name: Faker::Address.unique.city, 
  	zip_code: Faker::Address.unique.zip
  	)
end

# create some users (requires cities)
10.times do
  name = Faker::FunnyName.unique.two_word_name
  name = name.split(' ')
  description = Faker::Lorem.sentence(word_count: 10,random_words_to_add: 5)
  email = Faker::Internet.unique.safe_email(name: name)
  age = rand(16..70)
  password = Faker::Internet.password
  User.create(
  	first_name: name[0], 
  	last_name: name[1],
  	description: description, 
  	email: email, 
  	age: age,
  	city_id: City.all.sample.id,
    password_digest: password
  	)
end

# getting to the gossips (requires users)
20.times do
  title = Faker::Book.unique.title
  sentences = rand(3..8)
  content = ([Faker::Lorem.sentence(word_count: 5,random_words_to_add: 15)] * sentences).join(' ')
  user = rand(1..10)
  Gossip.create(
  	title: title, 
  	content: content, 
  	user_id: User.all.sample.id
  	)
end

# drawing some tags (requires nothing)
tags = [
  'sexual assault', 'racist behavior', 'lack of kindness',
  'fake romance', 'useless', 'fake news', 'hearsay', 'trash talk',
  'homophobia', 'transphobia'
]

tags.each do |tag|
  Tag.create(title: tag)
end

# creating the gossip_metum exchange table (requires gossips, tags)
Gossip.all.each do |gossip| # making sure each gossip has at least one tag
  tag_ids = Tag.all.sample(4).map { |tag| tag.id } # selecting 4 random tag ids
  tag_ids.each do |id| # creating the meta
      GossipMetum.create(gossip_id: gossip.id, tag_id: id)
  end
end

# creating private messages (requires users)
20.times do
  subject = Faker::Lorem.sentence(word_count: 5)
  content = Faker::Lorem.sentence(word_count: 10) + ' ' + Faker::Lorem.sentence(word_count: 10)
  PrivateMessage.create(subject: subject, content: content, sender_id: User.all.sample.id)
end

# creating message_delivering objects (requires private_messages & users)
PrivateMessage.all.each do |message|
  recipients = (User.all - [message.sender]).sample(5)
  recipients.each do |recipient|
    MessageDelivering.create(recipient_id: recipient.id, received_message_id: message.id)
  end
end

# creating comments on gossips (requires users and gossips)
20.times do
  content = Faker::Lorem.sentence(word_count: 8)
  Comment.create(user_id: User.all.sample.id, content: content, commentable: Gossip.all.sample)
end

# creating likes
20.times do
  user = User.all.sample.id
  # half for gossips, half for comments
  rand > 0.5 ? Like.create(user_id: user, gossip_id: Gossip.all.sample.id) : Like.create(user_id: user, comment_id: Comment.all.sample.id)
end

# creating comments v2 (requires users, gossips, and some comments)
20.times do
  content = Faker::Lorem.sentence(word_count: 4)
  # half for gossips, half for comments
  rand > 0.5 ? commentable = Gossip.all.sample : commentable = Comment.all.sample
  Comment.create(user_id: User.all.sample.id, content: content, commentable: commentable)
end