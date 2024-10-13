# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# サンプルデータの生成
require 'faker'

puts "Cleaning the database..."
MatchPost.destroy_all
ImagePost.destroy_all
MusicPost.destroy_all
Tagging.destroy_all
UserInterestTag.destroy_all
Tag.destroy_all
User.destroy_all


# puts "Creating users..."
# 10.times do
#     User.create!(
#         email: Faker::Internet.email,
#         password: Faker::Internet.password(min_length: 8),
#         username: Faker::Internet.username
#     )
# end

# puts "Creating tags..."
# 20.times do
#     Tag.create!(name: Faker::Music.genre)
# end

# puts "Creating image posts..."
# 30.times do
#     image_post = ImagePost.new(
#         title: Faker::Lorem.sentence(word_count: 3),
#         user: User.all.sample
#     )
#     image_post.image.attach(
#         io: URI.open(Faker::LoremFlickr.image(size: "300x200", search_terms: ['music'])),
#         filename: "image_#{Faker::Alphanumeric.alphanumeric(number: 10)}.jpg"
#     )
#     image_post.save!

#     image_post.tags << Tag.all.sample(rand(1..3))
# end

# puts "Creating music posts..."
# 30.times do
#     music_post = MusicPost.new(
#         title: Faker::Music::GratefulDead.song,
#         user: User.all.sample
#     )
#     # 注意: 実際の音楽ファイルの代わりにダミーデータを使用
#     music_post.music.attach(
#         io: StringIO.new("Dummy audio content"),
#         filename: "song_#{Faker::Alphanumeric.alphanumeric(number: 10)}.mp3",
#         content_type: "audio/mpeg"
#     )
#     music_post.save!

#     music_post.tags << Tag.all.sample(rand(1..3))
# end

# puts "Creating match posts..."
# 20.times do
#     MatchPost.create!(
#         image_post: ImagePost.all.sample,
#         music_post: MusicPost.all.sample
#     )
# end

# puts "Seed data creation completed!"


# 管理者権限を持つアカウントを作成
admin = User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.admin = true
    user.username = 'admin'
end

puts "Admin user created with email: #{admin.email} and password: password"
