# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

#City.destroy_all
10.times do
    city = City.create(
        name: Faker::Nation.capital_city,
        zip_code: Faker::Address.zip_code
    )
end

#User.destroy_all
10.times do
    user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        description: Faker::Hipster.sentence,  
        email: Faker::Internet.free_email,
        password: "bonjour",
        image_url: Faker::Avatar.image,
        age: rand(18..124),
        city: City.all.sample
    )
end

#Gossip.destroy_all
20.times do
    gossip = Gossip.create(
        user: User.all.sample,
        title: Faker::Quote.singular_siegler,
        content: Faker::Books::Dune.quote
    )
end

#Comment.destroy_all
50.times do
    comment = Comment.create(
        gossip: Gossip.all.sample,
        user: User.all.sample,
        content: Faker::Movies::HarryPotter.quote
    )
end

#Tag.destroy_all
10.times do
    tag = Tag.create(
        title: Faker::Movies::HarryPotter.spell
    )
end 

#GossTag.destroy_all
30.times do
    gosstag = GossTag.create(
        gossip: Gossip.all.sample,
        tag: Tag.all.sample
    )
end

#Likes.destroy_all
30.times do
    like = Like.create(
        gossip: Gossip.all.sample,
        user: User.all.sample,
        liked: true
    )
end


#PrivateMessage.destroy_all
10.times do
    private = PrivateMessage.new
    private.sender = User.all.sample
    private.recipient = User.all.sample
    private.content = Faker::ChuckNorris.fact
    private.save
end
