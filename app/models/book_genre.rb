class BookGenre < ActiveRecord::Base
  belongs_to :genre
  belongs_to :book
  
  validates :genre, :presence => true
  validates :book, :presence => true
end
