# Book data was copied from the Goodreads list of feminist literature
# https://www.goodreads.com/shelf/show/feminist-literature
# To clean it up, I used a tasty regex search/replace
# search: /(.*) \(.*\) \nby (.*) \(.*\) \n.*published (\d{4})\n.*\n.*\n.*stars/
# replace with: '{ "title": "$1", "author": "$2", "publication_year": $3 },'
# Took a little extra cleanup beyond that, but that got me 90% of the way

puts "Purging existing book data"
Book.destroy_all

JSON.parse(File.read('db/books.json')).each do |raw_book|
  Book.create!(raw_book)
end

puts "Created #{Book.count} books"
