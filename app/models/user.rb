class User < ActiveRecord::Base
  has_many :quotes, dependent: :delete_all
  has_many :books, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
