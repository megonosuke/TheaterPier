class Post < ApplicationRecord
  
  has_one_attached :post_image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :searches, dependent: :destroy
  belongs_to :user
  
  def liked?(user)
    likes.where(user_id: user.id).exists?
  end
  
  
  
end
