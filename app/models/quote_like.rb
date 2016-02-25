class QuoteLike < ActiveRecord::Base

  belongs_to :quote
  belongs_to :like
end
