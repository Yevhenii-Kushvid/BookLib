class Quote < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :book
  belongs_to :user

  has_many :quote_likes, dependent: :destroy
  has_many :likes, through: :quote_likes

  def can_i_like_it?(current_user)
    self.likes.where(user: current_user).count == 0
  end
end
