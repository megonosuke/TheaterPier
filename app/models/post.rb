class Post < ApplicationRecord
  
  has_one_attached :post_image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :searches, dependent: :destroy
  belongs_to :user
  
end
