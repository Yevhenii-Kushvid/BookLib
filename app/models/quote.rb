class Quote < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :book
  belongs_to :user

  has_many :quote_likes, dependent: :delete_all
end
