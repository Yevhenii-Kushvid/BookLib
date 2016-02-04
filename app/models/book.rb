class Book < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  has_many :quotes, dependent: :destroy

  validates :name, :presence => true
  validates :author, :presence => true
  validates :picture, :presence => true
  validates :context, :presence => true
end
