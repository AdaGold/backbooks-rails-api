require "test_helper"

describe BooksController do
  describe "index" do
    it "gives all the books" do
      get books_url
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "count"
      body.must_include "books"
      body["count"].must_equal Book.count
      body["books"].must_be_kind_of Array
      body["books"].length.must_equal Book.count

      keys = %w(id title author publication_year).sort
      body["books"].each do |book|
        book.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if no books exist" do
      Book.destroy_all

      get books_url
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "count"
      body.must_include "books"
      body["count"].must_equal 0
      body["books"].must_be_kind_of Array
      body["books"].length.must_equal 0
    end
  end

  describe "create" do
    let (:raw_book) {{title: 'test book', author: 'tester', publication_year: 1999}}

    it "creates a book from valid data" do
      # Assumption: book data is valid
      Book.new(raw_book).must_be :valid?

      start_count = Book.count

      post books_url, params: { book: raw_book }
      must_respond_with :success

      Book.count.must_equal start_count + 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.must_include "id"

      book = Book.last
      book.id.must_equal body["id"]
      book.title.must_equal raw_book[:title]
    end

    it "returns an error and creates no book from invalid data" do
      # Assumption: book data is invalid with no title
      raw_book[:title] = ""
      Book.new(raw_book).wont_be :valid?

      start_count = Book.count

      post books_url, params: { book: raw_book }
      must_respond_with :bad_request

      Book.count.must_equal start_count

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.must_include "errors"
      body["errors"].must_include "title"
    end
  end
end
