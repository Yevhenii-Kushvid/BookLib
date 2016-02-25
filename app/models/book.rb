class Book < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  has_many :quotes, dependent: :delete_all
  belongs_to :user

  validates :name, :presence => true
  validates :author, :presence => true
  validates :picture, :presence => true
  validates :context, :presence => true
end
