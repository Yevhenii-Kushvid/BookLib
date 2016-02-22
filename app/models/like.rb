class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :quote_like
end
