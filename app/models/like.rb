class Like < ActiveRecord::Base

  belongs_to :user
  has_one :quote_like, dependent: :destroy
end
