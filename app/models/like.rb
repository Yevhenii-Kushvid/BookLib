class Like < ActiveRecord::Base
  belongs_to :user
  has_one :quote_like, dependent: :destroy

  has_one :quote, through: :quote_like
end
