class Quote < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :books
  belongs_to :users
end
