class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :publication_year, presence: true, numericality: { greater_than: 1000, less_than_or_equal_to: Date.today.year }
end
