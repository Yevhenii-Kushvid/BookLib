class Like < ActiveRecord::Base

  belongs_to :user
  has_one :quote_like, dependent: :delete_all
end
