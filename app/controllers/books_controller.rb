class BooksController < ApplicationController
  def index
    render json: Book.all.as_json(only: [:id, :title, :author, :publication_year])
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: { id: book.id }
    else
      render json: { errors: book.errors.messages }, status: :bad_request
    end
  end

  private
  def book_params
    return params.require(:book).permit(:title, :author, :publication_year)
  end
end
