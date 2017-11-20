# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Purging existing book data"
Book.destroy_all

JSON.parse(File.read('db/books.json')).each do |raw_book|
  Book.create!(raw_book)
end

puts "Created #{Book.count} books"
