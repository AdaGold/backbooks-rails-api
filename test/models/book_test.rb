require "test_helper"

describe Book do
  describe "validations" do
    let (:raw_book) {{title: 'test book', author: 'tester', publication_year: 1999}}
    it "Is valid with all fields" do
      book = Book.new(raw_book)
      book.must_be :valid?
    end

    it "Requires a title" do
      raw_book[:title] = ""
      book = Book.new(raw_book)
      book.wont_be :valid?
      book.errors.messages.must_include :title
    end

    it "Requires a unique title" do
      Book.create!(raw_book)
      book = Book.new(raw_book)
      book.wont_be :valid?
      book.errors.messages.must_include :title
    end

    it "Requires an author" do
      raw_book[:author] = ""
      book = Book.new(raw_book)
      book.wont_be :valid?
      book.errors.messages.must_include :author
    end

    it "Requires a pub year b/w 1000 and now" do
      # 1000 won't work, 1001 will
      book = Book.new(raw_book)
      book.publication_year = 1000
      book.wont_be :valid?
      book.errors.messages.must_include :publication_year

      book.publication_year = 1001
      book.must_be :valid?

      # This year works, next year does not
      book.publication_year = Date.today.year
      book.must_be :valid?

      book.publication_year = Date.today.year + 1
      book.wont_be :valid?
      book.errors.messages.must_include :publication_year
    end
  end
end
